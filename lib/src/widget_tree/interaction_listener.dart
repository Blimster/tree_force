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
  HtmlNode _htmlNode;

  _InteractionListenerTreeNode(InteractionListener widget) : super(widget);

  @override
  HtmlNode get htmlNode => _htmlNode;

  @override
  void setChild(RenderTreeNode child) {
    _htmlNode = child.htmlNode;
    if (widget.onClick != null) {
      _htmlNode.setListener('onclick', (_) => widget.onClick());
    }
  }
}
