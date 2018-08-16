part of widget_tree_layout;

class Stack extends MultiChildRenderWidget {
  Stack({dynamic key, List<Widget> children}) : super(key: key, children: children);

  @override
  MultiChildRenderTreeNode<MultiChildRenderWidget> createTreeNode() {
    return StackTreeNode(this);
  }
}

class StackTreeNode extends MultiChildRenderTreeNode<Stack> {
  final HtmlNode _htmlNode;
  int _zIndex = 100;

  StackTreeNode(Stack widget)
      : _htmlNode = HtmlNode('div')..addStyle('display', 'block')..addClass('wt-stack'),
        super(widget);

  @override
  HtmlNode get htmlNode => _htmlNode;

  @override
  void addChild(RenderTreeNode<RenderWidget> child) {
    final childNode = child.htmlNode;
    childNode.addStyle('position', 'absolute');
    childNode.addStyle('z-index', '$_zIndex');
    _zIndex += 100;

    _htmlNode.addChild(childNode);
  }
}
