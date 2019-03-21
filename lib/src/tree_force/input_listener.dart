part of tree_force;

typedef OnInput = void Function(String value);

class InputListener extends DecoratorRenderWidget {
  final OnInput onInput;

  const InputListener({this.onInput, Widget child}) : super(child: child);

  @override
  InputListenerTreeNode createTreeNode() {
    return InputListenerTreeNode(this);
  }
}

class InputListenerTreeNode extends DecoratorRenderTreeNode<InputListener> {
  InputListenerTreeNode(InputListener widget) : super(widget);

  @override
  void decorate(RenderTreeNode<RenderWidget> child) {
    if (widget.onInput != null) {
      _htmlNode.addListener('oninput', (html.Event e) => widget.onInput((e.target as html.InputElement).value));
    }
  }
}
