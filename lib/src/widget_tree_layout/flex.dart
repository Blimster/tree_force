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
