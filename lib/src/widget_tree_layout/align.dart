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

class Align extends SingleChildRenderWidget {
  final HorizontalAlignment horizontal;
  final VerticalAlignment vertical;

  const Align({
    this.horizontal,
    this.vertical,
    Widget child,
  }) : super(child: child);

  @override
  SingleChildRenderTreeNode<SingleChildRenderWidget> createTreeNode() {
    return _AlignTreeNode(this);
  }
}

class _AlignTreeNode extends SingleChildRenderTreeNode<Align> {
  HtmlNode _htmlNode;

  _AlignTreeNode(Align widget) : super(widget) {
    _htmlNode = HtmlNode(
      'div',
      attributes: {
        'class': '${classPrefix}align',
        'style': '${widget.horizontal != null ? 'width: 100%;' : ''} ${widget.vertical != null ? 'height: 100%;' : ''} position: relative',
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
      'left': widget.horizontal?.positionLeft,
      'right': widget.horizontal?.positionRight,
      'top': widget.vertical?.positionTop,
      'bottom': widget.vertical?.positionBottom,
      'transform': 'translate(${widget.horizontal != null ? widget.horizontal.translateX : '0'}, ${widget.vertical != null ? widget.vertical.translateY : '0'})'
    });

    _htmlNode.addChild(child.htmlNode);
  }
}
