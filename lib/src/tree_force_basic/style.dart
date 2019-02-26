part of tree_force_basic;

class Style extends DecoratorRenderWidget {
  final Color color;
  final Color background;
  final Iterable<String> classes;

  const Style({this.color, this.background, this.classes, Widget child}) : super(child: child);

  @override
  DecoratorRenderTreeNode createTreeNode() => _StyleTreeNode(this);
}

class _StyleTreeNode extends DecoratorRenderTreeNode<Style> {
  _StyleTreeNode(Widget widget) : super(widget);

  @override
  void decorate(RenderTreeNode child) {
    final element = child.htmlNode;
    final Map<String, String> styles = {};

    if (widget.color != null) {
      styles['color'] = widget.color.color;
    }
    if (widget.background != null) {
      styles['background-color'] = widget.background.color;
    }

    element.addStyles(styles);

    if (this.widget.classes?.isNotEmpty ?? false) {
      element.addClasses(this.widget.classes);
    }
  }
}
