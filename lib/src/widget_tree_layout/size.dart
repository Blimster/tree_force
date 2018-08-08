part of widget_tree_layout;

class Length {
  final num value;
  final String unit;

  const Length._(this.value, this.unit);

  @override
  String toString() {
    return '$value$unit';
  }
}

Length pixel(int pixel) {
  return Length._(pixel, 'px');
}

Length percentage(double percentage) {
  return Length._(percentage, '%');
}

class Size extends SingleChildRenderWidget {
  final Length width;
  final Length height;

  const Size({dynamic key, this.width, this.height, Widget child}) : super(key: key, child: child);

  const Size.full({dynamic key, Widget child})
      : this.width = const Length._(100, '%'),
        this.height = const Length._(100, '%'),
        super(key: key, child: child);

  @override
  SingleChildRenderTreeNode<SingleChildRenderWidget> createTreeNode() {
    return _SizeTreeNode(this);
  }
}

class _SizeTreeNode extends SingleChildRenderTreeNode<Size> {
  HtmlNode _htmlNode;

  _SizeTreeNode(Size widget) : super(widget) {
    _htmlNode = HtmlNode('div')
      ..addClass('${classPrefix}sized')
      ..addStyles({
        'width': '${widget.width}',
        'height': '${widget.height}',
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
