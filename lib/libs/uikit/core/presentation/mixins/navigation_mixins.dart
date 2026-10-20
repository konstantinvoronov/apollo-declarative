import '../../../../../app/di.dart';
import '../../../../../app/routing/app_router.dart';
import 'package:flutter/cupertino.dart';

/// Callback that reports a successful outcome.
///
/// *Receives the result value and returns a new value to pass further.*
/// Returning **`null`** signals that the callback consumed the event and the
/// route should **not** be popped by the mixin.
typedef AppOnSuccess<T> = Future<T?> Function(BuildContext context,T param);

/// Callback that reports a skipped / cancelled step.
///
/// Returning **`null`** blocks the automatic `Navigator.pop` that would
/// otherwise follow.
typedef AppOnSkip<T> = Future<T?> Function();

/// Adds a **success event** to a widget that participates in a
/// [`NavigationFlow`].
///
/// Usage pattern:
/// ```dart
/// class AmountInputSheet extends StatelessWidget with EventOnSuccess<Decimal> {
///   @override
///   final AppOnSuccess<Decimal>? getOnSuccess;
///   // ... when user confirms:
///   callSuccessPop(decimalValue);
/// }
/// ```
///
/// Behaviour of [callSuccessPop]:
/// 1. If an `onSuccess` callback is provided it is awaited.
/// 2. If the callback returns **non-null**, that value is popped via the global
///    [Navigation] service; this passes control back to the surrounding
///    `NavigationFlow`.
/// 3. If the callback returns **null**, the flow has handled the event and the
///    route remains open.
///
/// This keeps widgets UI‑centric and lets the flow coordinate navigation.
mixin EventOnSuccess<T extends Object> {
  /// The success callback supplied by the parent flow or screen.
  AppOnSuccess<T>? get getOnSuccess;

  /// Call this when the step finishes with [resultValue].
  Future<void> callSuccessPop(BuildContext context,T resultValue) async {
    if (getOnSuccess != null) {
      final val = await getOnSuccess!.call(context,resultValue);
      if (val == null) return; // callback handled everything
    }
    if(di<AppRouter>().router.canPop()) {
      di<AppRouter>().router.pop(resultValue);
    }
  }
}

/// Adds a **skip / cancel event** to a widget that participates in a
/// [`NavigationFlow`]. Works analogously to [EventOnSuccess] but without a
/// payload.
///
/// Typical use: a *Skip* button or a back‑arrow inside the step.
mixin EventOnSkip<T extends Object> {
  /// Optional skip callback.
  AppOnSkip<T>? get getOnSkip;

  /// Call this when the user skips / cancels the current step.
  Future<void> callSkipPop() async {
    if (getOnSkip != null) {
      final T? val = await getOnSkip?.call();
      if (val == null) return; // callback handled cancellation
      di<AppRouter>().router.pop(val);
      return;
    }
    if(di<AppRouter>().router.canPop()) {
      di<AppRouter>().router.pop();
    }
  }
}
