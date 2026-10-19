abstract interface class IAppHapticService {
  Future<void> clickResponse();
  Future<void> attentionHapticResponse();
  Future<void> positiveHapticResponse();
}
