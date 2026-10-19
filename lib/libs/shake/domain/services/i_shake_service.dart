abstract interface class IShakeService {
  bool get enabled;

  double get threshold;
  set threshold(double value);
  int get hitsRequired;
  set hitsRequired(int value);
  int get windowMs;
  set windowMs(int value);
  int get minHitGapMs;
  set minHitGapMs(int value);
  int get cooldownMs;
  set cooldownMs(int value);

  void init({
    required void Function() onShake,
    double? threshold,
    int? hitsRequired,
    int? windowMs,
    int? minHitGapMs,
    int? cooldownMs,
  });

  void enable();
  void disable();
  void dispose();
}
