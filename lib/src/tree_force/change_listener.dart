part of tree_force;

typedef OnChange<T> = void Function(T value);

enum ElementProperty { value, checked }

class ChangeListener<T> extends DecoratorRenderWidget {
  final ElementProperty prop;
  final OnChange<T> onChange;

  const ChangeListener({this.prop, this.onChange, Widget child}) : super(child: child);

  @override
  ChangeListenerTreeNode createTreeNode() {
    return ChangeListenerTreeNode<T>(this);
  }
}

class ChangeListenerTreeNode<T> extends DecoratorRenderTreeNode<ChangeListener<T>> {
  ChangeListenerTreeNode(ChangeListener<T> widget) : super(widget);

  @override
  void decorate(RenderTreeNode<RenderWidget> child) {
    if (widget.onChange != null) {
      _htmlNode.addListener('onchange', (html.Event e) => widget.onChange(_propertyValue(e.target as html.InputElement, widget.prop)));
    }
  }
}

dynamic _propertyValue(html.InputElement input, ElementProperty v) {
  switch (v) {
    case ElementProperty.value:
      return input.value;
    case ElementProperty.checked:
      return input.checked;
    default:
      return input.value;
  }
}
