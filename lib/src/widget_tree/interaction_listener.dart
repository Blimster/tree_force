part of widget_tree;

class InteractionListener extends DecoratorRenderWidget {
  final VoidCallback onClick;

  const InteractionListener({this.onClick, Widget child}) : super(child: child);

  @override
  InteractionListenerTreeNode createTreeNode() {
    return InteractionListenerTreeNode(this);
  }
}

class InteractionListenerTreeNode extends DecoratorRenderTreeNode<InteractionListener> {
  InteractionListenerTreeNode(InteractionListener widget) : super(widget);

  @override
  void decorate(RenderTreeNode<RenderWidget> child) {
    if (widget.onClick != null) {
      _htmlNode.setListener('onclick', (_) => widget.onClick());
    }
  }
}
