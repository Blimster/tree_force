part of widget_tree;

typedef EventListener = void Function(Event event);

class HtmlNode {
  final String tagName;
  final String key;
  final String text;
  final List<HtmlNode> children = [];
  final Map<String, String> attributes = {};
  final Map<String, dynamic> properties = {};
  final Map<String, List<EventListener>> listeners = {};
  HtmlElement htmlElement;

  HtmlNode(
    this.tagName, {
    this.key,
    this.text,
    List<HtmlNode> children,
    Map<String, String> attributes,
    Map<String, dynamic> properties,
    Map<String, List<EventListener>> listeners,
  }) {
    if (children != null) {
      this.children.addAll(children);
    }
    if (attributes != null) {
      this.attributes.addAll(attributes);
    }
    if (properties != null) {
      this.properties.addAll(properties);
    }
    if (listeners != null) {
      this.listeners.addAll(listeners);
    }
  }

  void addChild(HtmlNode child) {
    this.children.add(child);
  }

  void setAttribute(String name, dynamic value) {
    this.attributes[name] = value != null ? '$value' : null;
  }

  void setProperty(String name, dynamic value) {
    this.properties[name] = value;
  }

  void addListener(String event, EventListener listener) {
    this.listeners[event] ??= [];
    this.listeners[event].add(listener);
  }

  void addClasses(List<String> names) {
    var currentValue = attributes['class'];
    names?.forEach((name) {
      if (currentValue != null) {
        currentValue += ' name';
      } else {
        currentValue = name;
      }
    });
    attributes['class'] = currentValue.trim();
  }

  void addClass(String name) {
    addClasses([name]);
  }

  void addStyles(Map<String, String> styles) {
    var currentValue = attributes['style'];
    styles?.forEach((name, value) {
      if (currentValue != null) {
        currentValue += '; $name: $value';
      } else {
        currentValue = '$name: $value';
      }
    });
    attributes['style'] = currentValue.trim();
  }

  void addStyle(String name, String value) {
    addStyles({name: value});
  }
}

abstract class HtmlNodeRenderer {
  void render(HtmlElement hostElement, List<HtmlNode> nodes);
}

class NativeNodeRender extends HtmlNodeRenderer {
  @override
  void render(HtmlElement hostElement, List<HtmlNode> nodes) {
    while (hostElement.firstChild != null) {
      hostElement.firstChild.remove();
    }
    nodes.forEach((node) {
      final element = _createElement(node);
      hostElement.append(element);
    });
  }

  HtmlElement _createElement(HtmlNode node) {
    final element = Element.tag(node.tagName);

    element.text = node.text;

    node.attributes.forEach((name, value) {
      element.setAttribute(name, value);
    });

    node.properties.forEach((name, value) {
      if (element is InputElement) {
        if (name == 'value') {
          element.value = value;
        }
      }
    });

    node.listeners.forEach((event, listeners) {
      element.on[event].listen((e) => listeners.forEach((listener) => listener(e)));
    });

    node.children.forEach((child) {
      element.append(_createElement(child));
    });

    node.htmlElement = element;

    return element;
  }
}

class IncrementalDomHtmlNodeRenderer extends HtmlNodeRenderer {
  @override
  void render(HtmlElement hostElement, List<HtmlNode> nodes) {
    patch(hostElement, () {
      nodes.forEach((node) => _createElement(node));
    });
  }

  void _createElement(HtmlNode node) {
    final props = [];
    node.attributes.forEach((name, value) => props.addAll([name, value]));
    node.listeners.forEach((event, listeners) => props.addAll([event, (e) => listeners.forEach((listener) => listener(e))]));

    final htmlElement = elementOpen(node.tagName, key: node.key, propertyValuePairs: props);
    if (node.text != null) {
      text(node.text);
    }

    node.children.forEach((child) => _createElement(child));
    elementClose(node.tagName);

    node.htmlElement = htmlElement;
  }
}
