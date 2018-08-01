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
  HtmlNode _htmlElement;

  _SizedTreeNode(Sized widget) : super(widget) {
    _htmlElement = HtmlNode('div')
      ..addClass('${classPrefix}sized')
      ..addStyles({
        'width': widget.width,
        'height': widget.height
      });
  }

  @override
  HtmlNode get htmlElement => _htmlElement;

  @override
  void setChild(RenderTreeNode<RenderWidget> child) {
    assert(_htmlElement.children.isEmpty);

    final element = child.htmlElement;
    element.addStyles({'height': '100%', 'width': '100%'});

    _htmlElement.addChild(child.htmlElement);
  }
}
