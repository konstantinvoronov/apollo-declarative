// shake_service.dart
import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/widgets.dart';
import 'package:sensors_plus/sensors_plus.dart';

import '../domain/services/i_shake_service.dart';

/// App-wide shake detector (foreground only).
/// Counts direction reversals in the X–Z plane within a time window.
/// Any reversal (regardless of axis) contributes toward the same total.
class ShakeService with WidgetsBindingObserver implements IShakeService {
  ShakeService();

  StreamSubscription<UserAccelerometerEvent>? _sub;
  VoidCallback? _onShake;

  bool _enabled = false;
  bool _running = false;

  @override
  bool get enabled => _enabled;

  // --- Sensitivity & behavior (tuned for ~3 sec of shaking) ---
  @override
  double threshold = 8.5;   // m/s² magnitude in XZ plane (was per-axis)
  @override
  int hitsRequired = 8;      // ~4 back/forth cycles
  @override
  int windowMs = 3500;       // collect hits for ~3 seconds
  @override
  int minHitGapMs = 40;      // debounce between hits
  @override
  int cooldownMs = 1000;     // pause after a trigger

  // --- Global state ---
  int _totalHits = 0;
  int _windowStart = 0;
  int _lastFire = 0;
  int _lastHitTs = 0;

  // Last accepted direction vector in XZ plane
  double _lastVx = 0.0, _lastVz = 0.0;
  bool _hasLastV = false;

  @override
  void init({
    required VoidCallback onShake,
    double? threshold,
    int? hitsRequired,
    int? windowMs,
    int? minHitGapMs,
    int? cooldownMs,
  }) {
    _onShake = onShake;
    if (threshold != null) this.threshold = threshold;
    if (hitsRequired != null) this.hitsRequired = hitsRequired;
    if (windowMs != null) this.windowMs = windowMs;
    if (minHitGapMs != null) this.minHitGapMs = minHitGapMs;
    if (cooldownMs != null) this.cooldownMs = cooldownMs;
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void enable() { _enabled = true; _maybeStart(); }
  @override
  void disable() { _enabled = false; _stop(); }
  @override
  void dispose() { disable(); WidgetsBinding.instance.removeObserver(this); }

  @override
  void didChangeAppLifecycleState(AppLifecycleState s) {
    if (s == AppLifecycleState.resumed) _maybeStart(); else _stop();
  }

  void _maybeStart() {
    if (_running || !_enabled) return;
    _running = true;
    _sub = userAccelerometerEvents.listen(_onEvent);
  }

  Future<void> _stop() async {
    if (!_running) return;
    _running = false;
    await _sub?.cancel();
    _sub = null;
    _resetWindow();
  }

  void _resetWindow() {
    _totalHits = 0;
    _windowStart = 0;
    _lastHitTs = 0;
    _lastVx = 0.0; _lastVz = 0.0; _hasLastV = false;
  }

  void _onEvent(UserAccelerometerEvent e) {
    final now = DateTime.now().millisecondsSinceEpoch;

    // Cooldown after a trigger
    if (now - _lastFire < cooldownMs) return;

    // Reset window if expired
    if (_windowStart == 0 || now - _windowStart > windowMs) {
      _windowStart = now;
      _totalHits = 0;
      _hasLastV = false;
      _lastHitTs = 0;
    }

    // Use X & Z components; ignore Y (vertical) to resist walking/jogging noise
    final ax = e.x;
    final az = e.z;
    final mag = math.sqrt(ax * ax + az * az);

    // Not strong enough? bail
    if (mag <= threshold) return;

    // Global debounce to avoid echo/double counts
    if (now - _lastHitTs <= minHitGapMs) return;

    // First strong hit starts the sequence
    if (!_hasLastV) {
      _acceptHit(now, ax, az);
      return;
    }

    // Direction reversal test via dot product (no need to normalize)
    final dot = ax * _lastVx + az * _lastVz; // < 0 → angle > 90°
    if (dot < 0) {
      _acceptHit(now, ax, az);
    }
  }

  void _acceptHit(int now, double vx, double vz) {
    _lastHitTs = now;
    _lastVx = vx; _lastVz = vz; _hasLastV = true;
    _totalHits++;
    // print(_totalHits); // optional
    print ("aa ${_totalHits}");
    if (_totalHits >= hitsRequired) {
      _resetWindow();
      _lastFire = now;
      _onShake?.call();
    }
  }
}
