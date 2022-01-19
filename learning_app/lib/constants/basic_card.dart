class BasicCard {
  static double get height => 110.0;
  static double get borderRadius => 12.5;
  static _CardElevation get elevation => _CardElevation();
  static _Padding get padding => _Padding();
}

class _CardElevation {
  double get low => 2.0;
  double get high => 5.0;
}

class _Padding {
  double get innerHorizontal => 10;
  double get outerHorizontal => 10;
  double get innerVertical => 10;
  double get outerVertical => 10;
}
