part of tree_force_layout;

class ScrollBars {
  static const horizontal = ScrollBars._(true, false);
  static const vertical = ScrollBars._(false, true);
  static const both = ScrollBars._(true, true);

  final bool scrollX;
  final bool scrollY;

  const ScrollBars._(this.scrollX, this.scrollY);
}

class ScrollBox extends HtmlTag {
  static final int maxPos = pow(2, 53) - 1;

  ScrollBox({
    dynamic key,
    String id,
    List<String> classes,
    ScrollBars scrollBars = ScrollBars.vertical,
    int posHorizontal,
    int posVertical,
    List<Widget> children,
  }) : super(
          key: key,
          id: id,
          tag: 'div',
          classes: classesOf('${classPrefix}scrollbox', classes),
          styles: {
            'overflow-x': scrollBars != null && scrollBars.scrollX ? 'scroll' : 'hidden',
            'overflow-y': scrollBars != null && scrollBars.scrollY ? 'scroll' : 'hidden',
          },
          children: children,
          modifier: (htmlNode) {
            final x = posHorizontal ?? htmlNode.htmlElement.scrollLeft;
            final y = posVertical ?? htmlNode.htmlElement.scrollTop;
            htmlNode.htmlElement.scrollTo(x, y);
          },
        );
}
