part of widget_tree_layout;

class Sized extends SingleChildRenderWidget {
  final String width;
  final String height;

  const Sized({dynamic key, this.width, this.height, Widget child}) : super(key: key, child: child);

  const Sized.full({dynamic key, Widget child})
      : this.width = '100%',
        this.height = '100%',
        super(key: key, child: child);

  @override
  SingleChildRenderTreeNode<SingleChildRenderWidget> createTreeNode() {
    return _SizedTreeNode(this);
  }
}

class _SizedTreeNode extends SingleChildRenderTreeNode<Sized> {
  HtmlNode _htmlNode;

  _SizedTreeNode(Sized widget) : super(widget) {
    _htmlNode = HtmlNode('div')
      ..addClass('${classPrefix}sized')
      ..addStyles({
        'width': widget.width,
        'height': widget.height
      });
  }

  @override
  HtmlNode get htmlNode => _htmlNode;

  @override
  void setChild(RenderTreeNode<RenderWidget> child) {
    assert(_htmlNode.children.isEmpty);

    final element = child.htmlNode;
    element.addStyles({'height': '100%', 'width': '100%'});

    _htmlNode.addChild(child.htmlNode);
  }
}
