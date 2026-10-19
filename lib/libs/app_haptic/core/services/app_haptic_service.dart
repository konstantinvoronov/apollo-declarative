
import 'package:flutter/services.dart';
import '../domain/services/i_app_haptic_service.dart';

class AppHapticService implements IAppHapticService {

  @override
  Future<void> clickResponse() async {
    HapticFeedback.lightImpact();
  }

  @override
  Future<void> attentionHapticResponse() async {
    HapticFeedback.lightImpact();
    await Future.delayed(const Duration(milliseconds: 300));
    HapticFeedback.lightImpact();
  }

  @override
  Future<void> positiveHapticResponse() async {
    HapticFeedback.lightImpact();
    await Future.delayed(const Duration(milliseconds: 50));
    HapticFeedback.mediumImpact();
    await Future.delayed(const Duration(milliseconds: 50));
    HapticFeedback.heavyImpact();
  }
}
