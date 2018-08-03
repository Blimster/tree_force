part of widget_tree;

typedef ValueChangeCallback = void Function(String value);

class ValueListener extends SingleChildRenderWidget {
  final ValueChangeCallback onInput;

  const ValueListener({dynamic key, this.onInput, Widget child}) : super(key: key, child: child);

  @override
  SingleChildRenderTreeNode createTreeNode() {
    return _ValueListenerTreeNode(this);
  }
}

class _ValueListenerTreeNode extends SingleChildRenderTreeNode<ValueListener> {
  HtmlNode _htmlNode;

  _ValueListenerTreeNode(ValueListener widget) : super(widget);

  @override
  HtmlNode get htmlNode => _htmlNode;

  @override
  void setChild(RenderTreeNode child) {
    _htmlNode = child.htmlNode;
    if (widget.onInput != null) {
      _htmlNode.setListener('oninput', (Event e) => widget.onInput((e.target as InputElement).value));
    }
  }
}
