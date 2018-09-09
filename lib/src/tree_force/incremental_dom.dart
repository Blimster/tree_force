part of tree_force;

final JsObject _incDom = context['IncrementalDOM'];

HtmlElement elementOpen(String tagName, {String key, List<dynamic> staticPropertyValuePairs, List<dynamic> propertyValuePairs}) {
  final args = [tagName, key, staticPropertyValuePairs];
  if (propertyValuePairs != null) {
    args.addAll(propertyValuePairs);
  }
  return _incDom.callMethod('elementOpen', args);
}

void elementClose(String tagName) {
  _incDom.callMethod('elementClose', [tagName]);
}

void text(dynamic text) {
  _incDom.callMethod('text', text != null ? ['$text'] : []);
}

void patch(Node node, void description(dynamic data)) {
  _incDom.callMethod('patch', [node, allowInterop(description)]);
}
