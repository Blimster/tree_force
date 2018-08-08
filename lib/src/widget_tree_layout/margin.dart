part of widget_tree_layout;

class Margin extends SingleChildRenderWidget {
  final String marginTop;
  final String marginRight;
  final String marginBottom;
  final String marginLeft;

  const Margin({
    this.marginTop,
    this.marginRight,
    this.marginBottom,
    this.marginLeft,
    Widget child,
  }) : super(child: child);

  @override
  SingleChildRenderTreeNode<SingleChildRenderWidget> createTreeNode() {
    return _MarginTreeNode(this);
  }
}

class _MarginTreeNode extends SingleChildRenderTreeNode<Margin> {
  HtmlNode _htmlNode;

  _MarginTreeNode(Margin widget) : super(widget);

  @override
  HtmlNode get htmlNode => _htmlNode;

  @override
  void setChild(RenderTreeNode<RenderWidget> child) {
    child.htmlNode.addStyles({
      'margin-top': widget.marginTop,
      'margin-right': widget.marginRight,
      'margin-bottom': widget.marginBottom,
      'margin-left': widget.marginLeft,
    });

    _htmlNode = child.htmlNode;
  }
}
