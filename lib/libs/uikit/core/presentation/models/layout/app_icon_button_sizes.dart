

enum AppIconButtonSizes {
  small(48,24), medium(56,24), zero(0,0);

  final double _buttonRadius;
  final double _iconSize;

  const AppIconButtonSizes(this._buttonRadius,this._iconSize);

  double get buttonRadius => this._buttonRadius;
  double get iconSize => this._iconSize;
}
