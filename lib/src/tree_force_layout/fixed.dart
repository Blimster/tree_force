part of tree_force_layout;

class Fixed extends DecoratorRenderWidget {
  final Length top;
  final Length right;
  final Length bottom;
  final Length left;

  Fixed({this.top, this.right, this.bottom, this.left, Widget child}) : super(child: child);

  @override
  FixedTreeNode createTreeNode() {
    return FixedTreeNode(this);
  }
}

class FixedTreeNode extends DecoratorRenderTreeNode<Fixed> {
  FixedTreeNode(Widget widget) : super(widget);

  @override
  void decorate(RenderTreeNode<RenderWidget> child) {
    child.htmlNode.addStyles({
      'position': 'fixed',
      'top': widget.top?.toString(),
      'right': widget.right?.toString(),
      'bottom': widget.bottom?.toString(),
      'left': widget.left?.toString()
    });
  }
}
