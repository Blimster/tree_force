part of widget_tree;

final JsObject _incDom = context['IncrementalDOM'];

HtmlElement elementOpen(String tagName, {String key, List<dynamic> staticPropertyValuePairs, List<dynamic> propertyValuePairs}) {
  final args = [tagName, key, staticPropertyValuePairs];
  if (propertyValuePairs != null) {
    args.addAll(propertyValuePairs);
  } else {
    args.add(null);
  }
  return _incDom.callMethod('elementOpen', args);
}

void elementClose(String tagName) {
  _incDom.callMethod('elementClose', [tagName]);
}

void text(dynamic text) {
  _incDom.callMethod('text', text != null ? ['$text'] : []);
}

void patch(Node node, void description()) {
  _incDom.callMethod('patch', [node, allowInterop(description)]);
}
