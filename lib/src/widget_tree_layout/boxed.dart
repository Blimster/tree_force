part of widget_tree_layout;

class Boxed extends SingleChildRenderWidget {
  final String marginTop;
  final String marginRight;
  final String marginBottom;
  final String marginLeft;
  final String paddingTop;
  final String paddingRight;
  final String paddingBottom;
  final String paddingLeft;

  const Boxed({
    this.marginTop,
    this.marginRight,
    this.marginBottom,
    this.marginLeft,
    this.paddingTop,
    this.paddingRight,
    this.paddingBottom,
    this.paddingLeft,
    Widget child,
  }) : super(child: child);

  @override
  SingleChildRenderTreeNode<SingleChildRenderWidget> createTreeNode() {
    return _BoxedTreeNode(this);
  }
}

class _BoxedTreeNode extends SingleChildRenderTreeNode<Boxed> {
  HtmlNode _htmlNode;

  _BoxedTreeNode(Boxed widget) : super(widget);

  @override
  HtmlNode get htmlNode => _htmlNode;

  @override
  void setChild(RenderTreeNode<RenderWidget> child) {
    child.htmlNode.addStyles({
      'margin-top': widget.marginTop,
      'margin-right': widget.marginRight,
      'margin-bottom': widget.marginBottom,
      'margin-left': widget.marginLeft,
      'padding-top': widget.paddingTop,
      'padding-tight': widget.paddingRight,
      'padding-bottom': widget.paddingBottom,
      'padding-left': widget.paddingLeft
    });

    _htmlNode = child.htmlNode;
  }
}
