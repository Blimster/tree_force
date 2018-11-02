part of tree_force_basic;

class FocusNode {
  static final Map<String, FocusNode> _nodes = {};

  HtmlNode _htmlNode;

  FocusNode._();

  factory FocusNode(String key) {
    final result = FocusNode._();
    _nodes[key] = result;
    return result;
  }

  static void requestFocus(String key) {
    final focusNode = _nodes[key];
    focusNode?._htmlNode?.htmlElement?.focus();
  }
}

class Focus extends DecoratorRenderWidget {
  final FocusNode node;

  const Focus({this.node, Widget child}) : super(child: child);

  @override
  FocusTreeNode createTreeNode() {
    return FocusTreeNode(this);
  }
}

class FocusTreeNode extends DecoratorRenderTreeNode<Focus> {
  FocusTreeNode(Focus widget) : super(widget);

  @override
  void decorate(RenderTreeNode<RenderWidget> child) {
    if (widget.node != null) {
      widget.node._htmlNode = child.htmlNode;
      child.htmlNode.attributes['tabindex'] = '-1';
    }
  }
}
