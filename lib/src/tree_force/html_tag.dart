part of tree_force;

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
/// Creates a map of attributes from the given main attributes and the additional attributes.
///
Map<String, String> attributesOf(Map<String, String> mainAttributes, Map<String, String> additionalAttributes) {
  final result = <String, String>{};
  if (additionalAttributes != null) {
    result.addAll(additionalAttributes);
  }
  if (mainAttributes != null) {
    result.addAll(mainAttributes);
  }
  return result;
}

///
/// A simple HTML element.
///
class HtmlTag extends MultiChildRenderWidget {
  final String tag;
  final String id;
  final Map<String, String> attributes;
  final Map<String, String> styles;
  final Iterable<String> classes;
  final Map<String, List<EventListener>> listeners;
  final String text;
  final HtmlNodeModifier modifier;

  const HtmlTag({
    dynamic key,
    this.tag,
    this.id,
    this.attributes,
    this.styles,
    this.classes,
    this.listeners,
    this.text,
    this.modifier,
    List<Widget> children,
  }) : super(key: key, children: children);

  @override
  MultiChildRenderTreeNode createTreeNode() {
    return HtmlTagTreeNode(this);
  }
}

class HtmlTagTreeNode extends MultiChildRenderTreeNode<HtmlTag> {
  final HtmlNode _htmlNode;

  HtmlTagTreeNode(HtmlTag widget)
      : _htmlNode = HtmlNode(widget.tag, text: widget.text, modifier: widget.modifier),
        super(widget) {
    if (widget.id != null) {
      _htmlNode.setAttribute('id', widget.id);
    }
    widget.attributes?.forEach((name, value) {
      _htmlNode.setAttribute(name, value);
    });

    if (widget.styles != null && widget.styles.isNotEmpty) {
      _htmlNode.setAttribute('style', widget.styles.keys.map((name) => '$name: ${widget.styles[name]}').join('; '));
    }

    if (widget.classes != null) {
      _htmlNode.setAttribute('class', widget.classes.join(' '));
    }
    if (widget.listeners != null) {
      widget.listeners
          .forEach((event, listeners) => listeners.forEach((listener) => _htmlNode.addListener(event, listener)));
    }
  }

  HtmlNode get htmlNode => _htmlNode;

  @override
  void addChild(RenderTreeNode child) {
    _htmlNode.addChild(child.htmlNode);
  }
}
