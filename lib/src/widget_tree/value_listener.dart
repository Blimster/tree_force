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
  HtmlElement _htmlElement;

  _ValueListenerTreeNode(ValueListener widget) : super(widget);

  @override
  HtmlElement get htmlElement => _htmlElement;

  @override
  void setChild(RenderTreeNode child) {
    _htmlElement = child.htmlElement;
    if (widget.onInput != null) {
      _htmlElement.onInput.listen((_) => widget.onInput((_htmlElement as InputElement).value));
    }
  }
}
