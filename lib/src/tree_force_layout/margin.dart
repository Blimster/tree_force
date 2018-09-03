part of tree_force_layout;

class Margin extends DecoratorRenderWidget {
  final Length top;
  final Length right;
  final Length bottom;
  final Length left;

  const Margin({
    this.top,
    this.right,
    this.bottom,
    this.left,
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
      'margin-top': widget.top?.toString(),
      'margin-right': widget.right?.toString(),
      'margin-bottom': widget.bottom?.toString(),
      'margin-left': widget.left?.toString(),
    });
  }
}
