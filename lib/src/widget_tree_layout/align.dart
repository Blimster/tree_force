part of widget_tree_layout;

class HorizontalAlignment {
  static const left = HorizontalAlignment._(MainAlignment.start);
  static const center = HorizontalAlignment._(MainAlignment.center);
  static const right = HorizontalAlignment._(MainAlignment.end);

  final MainAlignment mainAlign;

  const HorizontalAlignment._(this.mainAlign);
}

class VerticalAlignment {
  static const top = VerticalAlignment._(CrossAlignment.start);
  static const center = VerticalAlignment._(CrossAlignment.center);
  static const bottom = VerticalAlignment._(CrossAlignment.end);

  final CrossAlignment crossAlign;

  const VerticalAlignment._(this.crossAlign);
}

class Align extends Flex {
  Align({
    dynamic key,
    VerticalAlignment vertical = VerticalAlignment.center,
    HorizontalAlignment horizontal = HorizontalAlignment.center,
    Widget child,
  }) : super(
    key: key,
    direction: FlexDirection.row,
    mainAlign: horizontal.mainAlign,
    crossAlign: vertical.crossAlign,
    classes: ['${classPrefix}align'],
    children: [child],
  );
}

