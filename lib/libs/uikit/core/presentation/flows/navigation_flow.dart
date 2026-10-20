
import 'package:flutter/material.dart';

/// Determines how the steps of a navigation flow are presented.
enum FlowType { screens, dialogs }

/// Base class for a navigation flow.
///
/// * Builds a chain of screens or dialogs.
/// * Returns a value of type `T` on success or `null` if the user cancels.
/// * Contains **no business logic**; screens simply call
///   `Navigator.pop(context, result)`.
///
/// ### Integrating screens
/// A screen that participates in a `NavigationFlow` can declare its events
/// with the following mixins:
///
/// * **`EventOnSuccess<T>`** — signals a successful outcome of the step,
///   executes the supplied `onSuccess` callback and, if needed,
///   calls `Navigator.pop(context, result)`.
/// * **`EventOnSkip<T>`** — signals that the step was skipped/cancelled,
///   executes `onSkip`, then finishes the screen via `Navigator.pop`.
///
/// Thanks to this every screen supports two equivalent interaction patterns:
///
/// 1. **Callback functions** (`onSuccess`, `onSkip`) — handy when the screen
///    itself should decide the next move.
/// 2. **Returning a value through `Navigator.pop`** — the classic Flutter
///    pattern, convenient when an outer `NavigationFlow` controls the sequence.
abstract class NavigationFlow<T> {
  const NavigationFlow({this.context});

  /// The context through which the flow interacts with the `Navigator`.
  final BuildContext? context;

  /// Starts the flow and returns its result.
  Future<T?> call();
}