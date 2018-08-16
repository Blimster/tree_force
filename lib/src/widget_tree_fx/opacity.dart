part of widget_tree_fx;

class Opacity extends DecoratorRenderWidget {
  final num opacity;

  Opacity({this.opacity, Widget child}) : super(child: child);

  @override
  OpacityTreeNode createTreeNode() {
    return OpacityTreeNode(this);
  }
}

class OpacityTreeNode extends DecoratorRenderTreeNode<Opacity> {
  OpacityTreeNode(Opacity widget) : super(widget);

  @override
  void decorate(RenderTreeNode<RenderWidget> child) {
    if (widget.opacity != null) {
      child.htmlNode.addStyle('opacity', '${widget.opacity}');
    }
  }
}
