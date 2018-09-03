part of tree_force;

class InteractionListener extends DecoratorRenderWidget {
  final VoidCallback onClick;
  final VoidCallback onFocus;
  final VoidCallback onBlur;

  const InteractionListener({this.onClick, this.onFocus, this.onBlur, Widget child}) : super(child: child);

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
      _htmlNode.addListener('onclick', (_) => widget.onClick());
    }
    if (widget.onFocus != null) {
      _htmlNode.addListener('onfocus', (_) => widget.onFocus());
    }
    if (widget.onBlur != null) {
      _htmlNode.addListener('onblur', (_) => widget.onBlur());
    }
  }
}
