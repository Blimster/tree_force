part of tree_force;

class Color {
  final String color;

  Color._(this.color);
}

Color color(String colorString) {
  return Color._(colorString);
}

Color transparent() {
  return Color._('transparent');
}

Color rgb(int r, int g, int b) {
  return Color._('rgb($r, $g, $b)');
}

Color rgba(int r, int g, int b, double a) {
  return Color._('rgba($r, $g, $b, $a)');
}
