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
      _htmlNode.addListener('onblur', (e) {
        // prevents an exception in the browser console.
        // it's a combination of the fact, that an input
        // field to be removed triggers a blur event and
        // the use of incremental-dom.
        Future.microtask(() => widget.onBlur());
      });
    }
  }
}
