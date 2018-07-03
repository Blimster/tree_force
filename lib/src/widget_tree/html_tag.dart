part of widget_tree;

///
/// Creates a list of classes from the given main class and a list of additional classes.
///
List<String> classesOf(String mainClass, List<String> additionalClasses) {
  final result = <String>[];
  if (mainClass != null) {
    result.add(mainClass);
  }
  if (additionalClasses != null) {
    result.addAll(additionalClasses);
  }
  return result;
}

///
/// A simple HTML element.
///
class HtmlTag extends MultiChildRenderWidget {
  final String tag;
  final String id;
  final Map<String, String> styles;
  final Iterable<String> classes;
  final String text;

  const HtmlTag({dynamic key, this.tag, this.id, this.styles, this.classes, this.text, List<Widget> children}) : super(key: key, children: children);

  @override
  MultiChildRenderTreeNode createTreeNode() {
    return HtmlTagTreeNode(this);
  }
}

class HtmlTagTreeNode extends MultiChildRenderTreeNode<HtmlTag> {
  final HtmlElement _htmlElement;

  HtmlTagTreeNode(HtmlTag widget)
      : _htmlElement = Element.tag(widget.tag),
        super(widget) {
    if (widget.id != null) {
      _htmlElement.id = widget.id;
    }
    widget.styles?.forEach((name, value) {
      _htmlElement.style.setProperty(name, value);
    });
    if (widget.classes != null) {
      _htmlElement.classes = widget.classes;
    }
    _htmlElement.text = widget.text;
  }

  HtmlElement get htmlElement => _htmlElement;

  @override
  void addChild(RenderTreeNode child) {
    _htmlElement.append(child.htmlElement);
  }
}
