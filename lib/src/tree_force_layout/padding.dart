part of tree_force_layout;

class Padding extends DecoratorRenderWidget {
  final Length top;
  final Length right;
  final Length bottom;
  final Length left;

  const Padding({
    this.top,
    this.right,
    this.bottom,
    this.left,
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
      'padding-top': widget.top?.toString(),
      'padding-right': widget.right?.toString(),
      'padding-bottom': widget.bottom?.toString(),
      'padding-left': widget.left?.toString()
    });
  }
}
