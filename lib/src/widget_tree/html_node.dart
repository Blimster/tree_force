part of widget_tree;

typedef EventListener = void Function(Event event);

class HtmlNode {
  final String tagName;
  final List<HtmlNode> children = [];
  final Map<String, String> attributes = {};
  final Map<String, dynamic> properties = {};
  final Map<String, EventListener> listeners = {};
  String text;

  HtmlNode(
    this.tagName, {
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
}

abstract class HtmlNodeRenderer {
  void render(HtmlElement hostElement, HtmlNode rootNode);
}

class NativeNodeRender extends HtmlNodeRenderer {
  @override
  void render(HtmlElement hostElement, HtmlNode rootNode) {
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

    return element;
  }
}
