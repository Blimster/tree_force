part of widget_tree;

typedef EventListener = void Function(Event event);

class HtmlNode {
  final String tagName;
  final String key;
  final String text;
  final List<HtmlNode> children = [];
  final Map<String, String> attributes = {};
  final Map<String, dynamic> properties = {};
  final Map<String, EventListener> listeners = {};
  HtmlElement htmlElement;

  HtmlNode(
    this.tagName, {
    this.key,
    this.text,
    List<HtmlNode> children,
    Map<String, String> attributes,
    Map<String, dynamic> properties,
    Map<String, EventListener> listeners,
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

  void setListener(String event, EventListener listener) {
    this.listeners[event] = listener;
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
  void render(HtmlElement hostElement, HtmlNode node);
}

class NativeNodeRender extends HtmlNodeRenderer {
  @override
  void render(HtmlElement hostElement, HtmlNode rootNode) {
    while (hostElement.firstChild != null) {
      hostElement.firstChild.remove();
    }
    final rootElement = _createElement(rootNode);
    hostElement.append(rootElement);
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

    node.listeners.forEach((event, listener) {
      element.on[event].listen((e) => listener(e));
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
  void render(HtmlElement hostElement, HtmlNode rootNode) {
    patch(hostElement, () => _createElement(rootNode));
  }

  void _createElement(HtmlNode node) {
    final props = [];
    node.attributes.forEach((name, value) => props.addAll([name, value]));
    node.listeners.forEach((event, listener) => props.addAll([event, listener]));

    final htmlElement = elementOpen(node.tagName, key: node.key, propertyValuePairs: props);
    if (node.text != null) {
      text(node.text);
    }

    node.children.forEach((child) => _createElement(child));
    elementClose(node.tagName);

    node.htmlElement = htmlElement;
  }
}