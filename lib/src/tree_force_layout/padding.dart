part of tree_force_layout;

class Padding extends DecoratorRenderWidget {
  final Insets insets;

  const Padding({
    this.insets,
    Widget child,
  }) : super(child: child);

  @override
  DecoratorRenderTreeNode<Padding> createTreeNode() {
    return _PaddingTreeNode(this);
  }
}

class _PaddingTreeNode extends DecoratorRenderTreeNode<Padding> {
  _PaddingTreeNode(Padding widget) : super(widget);

  @override
  void decorate(RenderTreeNode<RenderWidget> child) {
    child.htmlNode.addStyles({
      'padding-top': widget.insets?.top?.toString(),
      'padding-right': widget.insets?.right?.toString(),
      'padding-bottom': widget.insets?.bottom?.toString(),
      'padding-left': widget.insets?.left?.toString()
    });
  }
}
