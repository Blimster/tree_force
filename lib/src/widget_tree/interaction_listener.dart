part of widget_tree;

class InteractionListener extends SingleChildRenderWidget {
  final VoidCallback onClick;

  const InteractionListener({dynamic key, this.onClick, Widget child}) : super(key: key, child: child);

  @override
  SingleChildRenderTreeNode createTreeNode() {
    return _InteractionListenerTreeNode(this);
  }
}

class _InteractionListenerTreeNode extends SingleChildRenderTreeNode<InteractionListener> {
  HtmlElement _htmlElement;

  _InteractionListenerTreeNode(InteractionListener widget) : super(widget);

  @override
  HtmlElement get htmlElement => _htmlElement;

  @override
  void setChild(RenderTreeNode child) {
    _htmlElement = child.htmlElement;
    if (widget.onClick != null) {
      _htmlElement.onClick.listen((_) => widget.onClick());
    }
  }
}
