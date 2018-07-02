part of nodder;

class HtmlTag extends MultiChildRenderWidget {
  final String tag;
  final Map<String, String> styles;
  final Iterable<String> classes;
  final String text;

  const HtmlTag({dynamic key, this.tag, this.styles, this.classes, this.text, List<Widget> children}) : super(key: key, children: children);

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
    _htmlElement.text = widget.text;
    widget.styles?.forEach((name, value) {
      _htmlElement.style.setProperty(name, value);
    });
    if (widget.classes != null) {
      _htmlElement.classes = widget.classes;
    }
  }

  HtmlElement get htmlElement => _htmlElement;

  @override
  void addChild(RenderTreeNode child) {
    _htmlElement.append(child.htmlElement);
  }
}

class InteractionListener extends SingleChildRenderWidget {
  final VoidCallback onClick;

  const InteractionListener({dynamic key, this.onClick, Widget child}) : super(key: key, child: child);

  @override
  SingleChildRenderTreeNode createTreeNode() {
    return _InteractionListenerTreeNode(this);
  }
}

class _InteractionListenerTreeNode extends SingleChildRenderTreeNode<InteractionListener> {
  HtmlElement _htmlElement;

  _InteractionListenerTreeNode(InteractionListener widget) : super(widget);

  @override
  HtmlElement get htmlElement => _htmlElement;

  @override
  void setChild(RenderTreeNode child) {
    _htmlElement = child.htmlElement;
    if (widget.onClick != null) {
      _htmlElement.onClick.listen((_) => widget.onClick());
    }
  }
}

class Button extends InteractionListener {
  Button({
    dynamic key,
    String text,
    VoidCallback onClick,
  }) : super(
            key: key,
            onClick: onClick,
            child: HtmlTag(
              key: key,
              tag: 'div',
              classes: ['${classPrefix}button'],
              text: text,
            ));
}

class Text extends HtmlTag {
  Text({dynamic key, String text})
      : super(
          key: key,
          tag: 'span',
          classes: ['${classPrefix}text'],
          text: text,
        );
}
