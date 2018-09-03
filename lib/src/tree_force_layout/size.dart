part of tree_force_layout;

class Size extends DecoratorRenderWidget {
  final Length width;
  final Length height;

  const Size({this.width, this.height, Widget child}) : super(child: child);

  const Size.full({Widget child})
      : this.width = fullLength,
        this.height = fullLength,
        super(child: child);

  @override
  DecoratorRenderTreeNode createTreeNode() => _SizeTreeNode(this);
}

class _SizeTreeNode extends DecoratorRenderTreeNode<Size> {
  _SizeTreeNode(Widget widget) : super(widget);

  @override
  void decorate(RenderTreeNode child) {
    final element = child.htmlNode;
    element.addStyles({'width': '${widget.width}', 'height': '${widget.height}'});
  }
}
