part of tree_force;

class Length {
  final num value;
  final String unit;

  const Length._(this.value, this.unit);

  @override
  String toString() {
    return '$value$unit';
  }
}

class PixelLength extends Length {
  const PixelLength._(int pixel) : super._(pixel, 'px');
}

class PercentageLength extends Length {
  const PercentageLength._(num percentage) : super._(percentage, '%');
}

Length pixel(int pixel) {
  return PixelLength._(pixel);
}

Length percentage(num percentage) {
  return PercentageLength._(percentage);
}

const fullLength = PercentageLength._(100);
