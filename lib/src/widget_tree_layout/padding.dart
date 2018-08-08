part of widget_tree_layout;

class Padding extends SingleChildRenderWidget {
  final String paddingTop;
  final String paddingRight;
  final String paddingBottom;
  final String paddingLeft;

  const Padding({
    this.paddingTop,
    this.paddingRight,
    this.paddingBottom,
    this.paddingLeft,
    Widget child,
  }) : super(child: child);

  @override
  SingleChildRenderTreeNode<SingleChildRenderWidget> createTreeNode() {
    return _PaddingTreeNode(this);
  }
}

class _PaddingTreeNode extends SingleChildRenderTreeNode<Padding> {
  HtmlNode _htmlNode;

  _PaddingTreeNode(Padding widget) : super(widget);

  @override
  HtmlNode get htmlNode => _htmlNode;

  @override
  void setChild(RenderTreeNode<RenderWidget> child) {
    child.htmlNode.addStyles({
      'padding-top': widget.paddingTop,
      'padding-tight': widget.paddingRight,
      'padding-bottom': widget.paddingBottom,
      'padding-left': widget.paddingLeft
    });

    _htmlNode = child.htmlNode;
  }
}
