part of widget_tree_layout;

class HorizontalAlignment {
  static const left = HorizontalAlignment._('0', null, '0');
  static const center = HorizontalAlignment._('50%', null, '-50%');
  static const right = HorizontalAlignment._(null, '0', '0');

  final String positionLeft;
  final String positionRight;
  final String translateX;

  const HorizontalAlignment._(this.positionLeft, this.positionRight, this.translateX);
}

class VerticalAlignment {
  static const top = VerticalAlignment._('0', null, '0');
  static const center = VerticalAlignment._('50%', null, '-50%');
  static const bottom = VerticalAlignment._(null, '0', '0');

  final String positionTop;
  final String positionBottom;
  final String translateY;

  const VerticalAlignment._(this.positionTop, this.positionBottom, this.translateY);
}

class Aligned extends SingleChildRenderWidget {
  final HorizontalAlignment horizontalAlignment;
  final VerticalAlignment verticalAlignment;

  const Aligned({
    this.horizontalAlignment = HorizontalAlignment.center,
    this.verticalAlignment = VerticalAlignment.center,
    Widget child,
  }) : super(child: child);

  @override
  SingleChildRenderTreeNode<SingleChildRenderWidget> createTreeNode() {
    return _AlignedTreeNode(this);
  }
}

class _AlignedTreeNode extends SingleChildRenderTreeNode<Aligned> {
  HtmlNode _htmlNode;

  _AlignedTreeNode(Aligned widget) : super(widget) {
    _htmlNode = HtmlNode(
      'div',
      attributes: {
        'class': '${classPrefix}aligned',
        'style': 'width: 100%; height: 100%; position: relative',
      },
    );
  }

  @override
  HtmlNode get htmlNode => _htmlNode;

  @override
  void setChild(RenderTreeNode<RenderWidget> child) {
    assert(_htmlNode.children.isEmpty);

    child.htmlNode.addStyles({
      'position': 'absolute',
      'left': widget.horizontalAlignment.positionLeft,
      'right': widget.horizontalAlignment.positionRight,
      'top': widget.verticalAlignment.positionTop,
      'bottom': widget.verticalAlignment.positionBottom,
      'transform': 'translate(${widget.horizontalAlignment.translateX}, ${widget.verticalAlignment.translateY})'
    });

    _htmlNode.addChild(child.htmlNode);
  }
}
