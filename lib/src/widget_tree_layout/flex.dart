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
  HtmlNode _htmlNode;

  _FlexItemTreeNode(FlexItem widget)
      : _htmlNode = HtmlNode('div')
          ..addStyle('flex-grow', '${widget.flexGrow}')
          ..addClass('${classPrefix}flex-item'),
        super(widget);

  @override
  HtmlNode get htmlNode => _htmlNode;

  @override
  void setChild(RenderTreeNode child) {
    assert(_htmlNode.children.isEmpty);
    _htmlNode.addChild(child.htmlNode);
  }
}

class FlexDirection {
  static const row = FlexDirection._('row');
  static const column = FlexDirection._('column');

  final String style;

  const FlexDirection._(this.style);
}

class MainAlignment {
  static const start = MainAlignment._('flex-start');
  static const end = MainAlignment._('flex-end');
  static const center = MainAlignment._('center');
  static const stretch = MainAlignment._('stretch');

  final String style;

  const MainAlignment._(this.style);
}

class CrossAlignment {
  static const start = CrossAlignment._('flex-start');
  static const end = CrossAlignment._('flex-end');
  static const center = CrossAlignment._('center');
  static const stretch = CrossAlignment._('stretch');

  final String style;

  const CrossAlignment._(this.style);
}

class Flex extends HtmlTag {
  Flex({
    dynamic key,
    FlexDirection direction = FlexDirection.row,
    MainAlignment mainAlign = MainAlignment.start,
    CrossAlignment crossAlign = CrossAlignment.start,
    Iterable<String> classes = const ['${classPrefix}flex'],
    List<Widget> children,
  }) : super(
            key: key,
            tag: 'div',
            styles: {
              'display': 'flex',
              'flex-direction': direction.style,
              'justify-content': mainAlign.style,
              'align-items': crossAlign.style,
            },
            classes: classes,
            children: children);
}

class Row extends Flex {
  Row({
    dynamic key,
    MainAlignment mainAlign = MainAlignment.start,
    CrossAlignment crossAlign = CrossAlignment.start,
    List<Widget> children,
  }) : super(
          key: key,
          direction: FlexDirection.row,
          mainAlign: mainAlign,
          crossAlign: crossAlign,
          classes: ['${classPrefix}flex-row'],
          children: children,
        );
}

class Column extends Flex {
  Column({
    dynamic key,
    MainAlignment mainAlign = MainAlignment.start,
    CrossAlignment crossAlign = CrossAlignment.start,
    List<Widget> children,
  }) : super(
          key: key,
          direction: FlexDirection.column,
          mainAlign: mainAlign,
          crossAlign: crossAlign,
          classes: ['${classPrefix}flex-column'],
          children: children,
        );
}
