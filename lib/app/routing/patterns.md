# Routing Patterns

Scope: `lib/app/routing` and its descendants. Apply this catalog cumulatively with the project-wide and other applicable ancestor catalogs. It does not cancel inherited rules or change architectural dependency permissions.

The examples show the caller and destination sides of the routing contract. Examples outside this subtree do not extend this catalog's enforcement scope to feature screens or other folders. reference application-specific routes, parameters, widgets, and values below are representative; their presence here does not mean Apollo implements them.

## Pattern: push_route_with_params — Call a path with its parameters

Use when: opening a parameterized route through AppRouter; await the push when the caller needs the returned result.

Do not use when: completing the current screen or sheet; use its navigation completion mixin instead.

Rule and reason: resolve AppRouter through DI and pass the destination's Params object through `extra`, preserving the route inputs and any success callback. Preserve the returned result when the caller needs it.

### Good code

```dart
final res = await di<AppRouter>().router.push(
  '/resultInfo',
  extra: ResultInfoParams(
    needButton: false,
    resultType: (val.gameEndReason == GameEndReasons.fault)
        ? ResultType.Negative
        : ResultType.Positive,
    message: val.endReasonTitle,
    content: GameBriefSummary(gameStats: val),
    onSuccess: (context, val) async {
      return val;
    },
  ),
);
```

### Bad code

Illustrative counterexample when this destination requires the supplied parameters and the caller needs its result:

```dart
di<AppRouter>().router.push('/resultInfo');
```

This omits the destination parameters and success callback, and discards the route result.

## Pattern: complete_route_through_success_mixin — Pop using navigation mixins

Use when: a screen or sheet using `EventOnSuccess<T>` completes successfully and returns a value to its caller or flow.

Do not use when: opening a new route, or reporting cancellation through a separate skip/cancel contract.

Rule and reason: await `callSuccessPop(context, result)` instead of popping directly, so the navigation mixin can invoke the declared success callback before deciding whether to pop. In the current mixin, a callback returning null consumes the event and keeps the route open; a non-null result allows the pop. Do not add a second pop after the mixin call.

### Good code

```dart
AppButton.green(
  onTap: () async {
    await callSuccessPop(context, true);
  },
  text: 'Onboarding',
);
```

### Bad code

Illustrative counterexample for a screen with the declared success-mixin contract:

```dart
AppButton.green(
  onTap: () async {
    Navigator.of(context).pop(true);
  },
  text: 'Onboarding',
);
```

Direct popping bypasses the success callback and its decision to consume the event without closing the route.
