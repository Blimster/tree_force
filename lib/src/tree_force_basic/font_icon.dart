part of tree_force_basic;

class FontIcon extends HtmlTag {
  final String icon;

  FontIcon({
    dynamic key,
    String id,
    this.icon,
  }) : super(
          key: key,
          tag: 'i',
          id: id,
          classes: [icon],
        );
}
