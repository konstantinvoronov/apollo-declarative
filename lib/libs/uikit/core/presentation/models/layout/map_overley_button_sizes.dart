import 'app_sizes.dart';

enum MapOverlayButtonSize {
  medium(40, 40),
  large(50, 50);

  final double hUnits;
  final double wUnits;
  const MapOverlayButtonSize(this.hUnits, this.wUnits);

  double get height => AppSizes.sh(hUnits);
  double get width  => AppSizes.sw(wUnits);
}
