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
  HtmlElement _htmlElement;

  _BoxedTreeNode(Boxed widget) : super(widget);

  @override
  HtmlElement get htmlElement => _htmlElement;

  @override
  void setChild(RenderTreeNode<RenderWidget> child) {
    child.htmlElement
      ..style.marginTop = widget.marginTop
      ..style.marginRight = widget.marginRight
      ..style.marginBottom = widget.marginBottom
      ..style.marginLeft = widget.marginLeft
      ..style.paddingTop = widget.paddingTop
      ..style.paddingRight = widget.paddingRight
      ..style.paddingBottom = widget.paddingBottom
      ..style.paddingLeft = widget.paddingLeft;

    _htmlElement = child.htmlElement;
  }
}
