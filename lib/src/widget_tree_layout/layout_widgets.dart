part of widget_tree_layout;

class FlexItem extends SingleChildRenderWidget {
  final int flexGrow;

  const FlexItem({dynamic key, this.flexGrow, Widget child}) : super(key: key, child: child);

  @override
  SingleChildRenderTreeNode<SingleChildRenderWidget> createTreeNode() {
    return _FlexItemTreeNode(this);
  }
}

class _FlexItemTreeNode extends SingleChildRenderTreeNode<FlexItem> {
  HtmlElement _htmlElement;

  _FlexItemTreeNode(FlexItem widget)
      : _htmlElement = DivElement()
          ..style.flexGrow = '${widget.flexGrow}'
          ..classes = ['${classPrefix}flex-item'],
        super(widget);

  @override
  HtmlElement get htmlElement => _htmlElement;

  @override
  void setChild(RenderTreeNode child) {
    assert(_htmlElement.childNodes.isEmpty);
    _htmlElement.append(child.htmlElement);
  }
}

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
  HtmlElement _htmlElement;

  _SizedTreeNode(Sized widget) : super(widget) {
    _htmlElement = new DivElement()
      ..classes = ['${classPrefix}sized']
      ..style.width = widget.width
      ..style.height = widget.height;
  }

  @override
  HtmlElement get htmlElement => _htmlElement;

  @override
  void setChild(RenderTreeNode<RenderWidget> child) {
    assert(_htmlElement.childNodes.isEmpty);

    final element = child.htmlElement;
    element
      ..style.height = '100%'
      ..style.width = '100%';

    _htmlElement.append(child.htmlElement);
  }
}

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
  HtmlElement _htmlElement;

  _AlignedTreeNode(Aligned widget) : super(widget) {
    _htmlElement = DivElement()
      ..classes = ['${classPrefix}aligned']
      ..style.width = '100%'
      ..style.height = '100%'
      ..style.position = 'relative';
  }

  @override
  HtmlElement get htmlElement => _htmlElement;

  @override
  void setChild(RenderTreeNode<RenderWidget> child) {
    assert(_htmlElement.childNodes.isEmpty);

    child.htmlElement
      ..style.position = 'absolute'
      ..style.left = widget.horizontalAlignment.positionLeft
      ..style.right = widget.horizontalAlignment.positionRight
      ..style.top = widget.verticalAlignment.positionTop
      ..style.bottom = widget.verticalAlignment.positionBottom
      ..style.transform = 'translate(${widget.horizontalAlignment.translateX}, ${widget.verticalAlignment.translateY})';

    _htmlElement.append(child.htmlElement);
  }
}

class FlexDirection {
  static const row = FlexDirection._('row');
  static const column = FlexDirection._('column');

  final String style;

  const FlexDirection._(this.style);
}

class Flex extends HtmlTag {
  Flex({
    dynamic key,
    FlexDirection direction = FlexDirection.row,
    Iterable<String> classes = const ['${classPrefix}flex'],
    List<Widget> children,
  }) : super(
            key: key,
            tag: 'div',
            styles: {
              'display': 'flex',
              'flex-direction': direction.style,
            },
            classes: classes,
            children: children);
}

class Row extends Flex {
  Row({
    dynamic key,
    List<Widget> children,
  }) : super(
          key: key,
          direction: FlexDirection.row,
          classes: ['${classPrefix}flex-row'],
          children: children,
        );
}

class Column extends Flex {
  Column({
    dynamic key,
    List<Widget> children,
  }) : super(
          key: key,
          direction: FlexDirection.column,
          classes: ['${classPrefix}flex-column'],
          children: children,
        );
}
