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
