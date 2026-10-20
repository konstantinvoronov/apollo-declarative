#!/usr/bin/env python3
"""Preview or synchronize explicitly shared AI harness units without blind overwrites."""

import argparse
import hashlib
import json
import os
from pathlib import Path, PurePosixPath
import shutil
import sys
import tempfile


STATE = "ai_development/harness_sync_state.json"
MANIFEST = "ai_development/harness_sync_manifest.json"


def digest(data):
    return hashlib.sha256(data).hexdigest()


def safe_path(root, relative):
    path = PurePosixPath(relative)
    if path.is_absolute() or not path.parts or any(
        part in ("..", ".git") for part in path.parts
    ) or "\\" in relative:
        raise ValueError(f"Unsafe manifest path: {relative}")
    candidate = root.joinpath(*path.parts)
    for parent in (candidate, *candidate.parents):
        if parent == root:
            break
        if parent.is_symlink():
            raise ValueError(f"Symlink not allowed in managed path: {relative}")
    if not candidate.resolve().is_relative_to(root):
        raise ValueError(f"Managed path escapes project: {relative}")
    return candidate


def load_state(root):
    path = safe_path(root, STATE)
    if not path.exists():
        return {}
    state = json.loads(path.read_text())
    if state.get("version") != 1 or not isinstance(state.get("units"), dict):
        raise ValueError(f"Unsupported synchronization state in {root}")
    if not all(isinstance(k, str) and isinstance(v, str)
               for k, v in state["units"].items()):
        raise ValueError(f"Invalid synchronization hashes in {root}")
    return state["units"]


def section(data, entry):
    if "start_marker" not in entry:
        return data, 0, len(data)
    start = entry["start_marker"].encode()
    end = entry["end_marker"].encode()
    if data.count(start) != 1 or data.count(end) != 1:
        raise ValueError(f"Missing or repeated section markers: {entry['path']}")
    left = data.index(start)
    right = data.index(end) + len(end)
    if right - len(end) < left + len(start):
        raise ValueError(f"Reversed section markers: {entry['path']}")
    return data[left:right], left, right


def atomic_write(path, data):
    path.parent.mkdir(parents=True, exist_ok=True)
    descriptor, temporary = tempfile.mkstemp(prefix=".harness-", dir=path.parent)
    try:
        with os.fdopen(descriptor, "wb") as output:
            output.write(data)
        if path.exists():
            shutil.copymode(path, temporary)
        os.replace(temporary, path)
    finally:
        if os.path.exists(temporary):
            os.unlink(temporary)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--source", required=True, type=Path)
    parser.add_argument("--target", required=True, type=Path)
    parser.add_argument("--apply", action="store_true")
    parser.add_argument("--path", action="append", default=[])
    parser.add_argument("--accept-source", action="append", default=[])
    args = parser.parse_args()
    source, target = args.source.resolve(), args.target.resolve()
    if not source.is_dir() or not target.is_dir() or source == target:
        raise ValueError("Source and target must be different existing project directories")
    if source.is_relative_to(target) or target.is_relative_to(source):
        raise ValueError("Source and target must not contain each other")

    manifest_path = safe_path(source, MANIFEST)
    manifest = json.loads(manifest_path.read_text())
    if manifest.get("version") != 1:
        raise ValueError("Unsupported manifest version")
    entries = manifest.get("shared")
    if not isinstance(entries, list) or not entries:
        raise ValueError("Manifest must list shared units explicitly")
    seen = set()
    for entry in entries:
        relative = entry["path"]
        if relative in seen:
            raise ValueError(f"Duplicate manifest entry: {relative}")
        seen.add(relative)
        safe_path(source, relative)
        safe_path(target, relative)
        parts = PurePosixPath(relative).parts
        if (parts[-1].lower() == "patterns.md" or "violation" in parts[-1].lower()
                and not relative.startswith(".agents/skills/")):
            raise ValueError(f"Project patterns/history cannot be synchronized: {relative}")
        if relative == STATE or relative in (
            "ai_development/implementation_plan.md", "ai_development/development_history.md"
        ):
            raise ValueError(f"Project-owned state cannot be synchronized: {relative}")
        if ("start_marker" in entry) != ("end_marker" in entry):
            raise ValueError(f"Both section markers are required: {relative}")

    selected = set(args.path) if args.path else seen
    if not selected <= seen or not set(args.accept_source) <= selected:
        raise ValueError("Selected and accepted paths must be explicit selected manifest entries")
    source_state, target_state = load_state(source), load_state(target)
    plans = []
    blocked = False
    for entry in entries:
        relative = entry["path"]
        if relative not in selected:
            continue
        source_path, target_path = safe_path(source, relative), safe_path(target, relative)
        if not source_path.is_file():
            print(f"SOURCE MISSING: {relative}")
            blocked = True
            continue
        source_data = source_path.read_bytes()
        source_unit, _, _ = section(source_data, entry)
        source_hash = digest(source_unit)
        key = relative + ("::" + entry["start_marker"] if "start_marker" in entry else "")
        target_data = target_path.read_bytes() if target_path.exists() else None
        target_unit, left, right = (section(target_data, entry)
                                    if target_data is not None else (None, 0, 0))
        target_hash = digest(target_unit) if target_unit is not None else None
        bases = {state[key] for state in (source_state, target_state) if key in state}
        if source_hash == target_hash:
            action = "SAME"
        elif target_data is None:
            action = "CREATE"
        elif relative in args.accept_source:
            action = "ACCEPT SOURCE"
        elif not bases:
            action = "CONFLICT: no shared baseline"
        elif len(bases) != 1:
            action = "CONFLICT: baseline disagreement"
        elif target_hash in bases:
            action = "UPDATE"
        elif source_hash in bases:
            action = "KEEP TARGET EDIT: reverse direction to promote"
        else:
            action = "CONFLICT: both sides changed"
        print(f"{action}: {relative}")
        if action.startswith(("CONFLICT", "KEEP TARGET")):
            blocked = True
        new_data = (source_data if "start_marker" not in entry or target_data is None
                    else target_data[:left] + source_unit + target_data[right:])
        plans.append((relative, key, source_hash, target_path, target_data, new_data, action))

    if blocked:
        print("No files written. Reconcile the reported differences and preview again.")
        return 2
    if not args.apply:
        print("Preview only. Add --apply after reviewing the plan.")
        return 0

    for relative, _, expected_hash, target_path, old, _, _ in plans:
        source_path = safe_path(source, relative)
        entry = next(item for item in entries if item["path"] == relative)
        current_source, _, _ = section(source_path.read_bytes(), entry)
        if digest(current_source) != expected_hash:
            raise ValueError(f"Source changed since preview planning: {relative}")
        current = target_path.read_bytes() if target_path.exists() else None
        if current != old:
            raise ValueError(f"Target changed since preview planning: {relative}")
    replacements = [plan for plan in plans if plan[-1] != "SAME"]
    backup = Path(tempfile.mkdtemp(prefix="ai-harness-sync-")) if replacements else None
    for relative, _, _, _, old, _, _ in replacements:
        if old is not None:
            original = backup / relative
            original.parent.mkdir(parents=True, exist_ok=True)
            original.write_bytes(old)
    for _, _, _, target_path, _, new, _ in replacements:
        atomic_write(target_path, new)
    for _, key, hash_value, _, _, _, _ in plans:
        source_state[key] = target_state[key] = hash_value
    for root, units in ((source, source_state), (target, target_state)):
        data = (json.dumps({"version": 1, "units": units}, indent=2, sort_keys=True) + "\n").encode()
        atomic_write(safe_path(root, STATE), data)
    print(f"Applied {len(replacements)} shared unit(s).")
    if backup is not None:
        print(f"Recoverable originals: {backup}")
    return 0


if __name__ == "__main__":
    try:
        sys.exit(main())
    except (ValueError, KeyError, TypeError, OSError, json.JSONDecodeError) as error:
        print(f"Synchronization stopped: {error}", file=sys.stderr)
        sys.exit(2)
