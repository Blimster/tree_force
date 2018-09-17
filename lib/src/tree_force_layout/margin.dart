part of tree_force_layout;

class Margin extends DecoratorRenderWidget {
  final Insets insets;

  const Margin({
    this.insets,
    Widget child,
  }) : super(child: child);

  @override
  DecoratorRenderTreeNode<DecoratorRenderWidget> createTreeNode() {
    return _MarginTreeNode(this);
  }
}

class _MarginTreeNode extends DecoratorRenderTreeNode<Margin> {
  _MarginTreeNode(Margin widget) : super(widget);

  @override
  void decorate(RenderTreeNode<RenderWidget> child) {
    child.htmlNode.addStyles({
      'margin-top': widget.insets?.top?.toString(),
      'margin-right': widget.insets?.right?.toString(),
      'margin-bottom': widget.insets?.bottom?.toString(),
      'margin-left': widget.insets?.left?.toString(),
    });
  }
}
