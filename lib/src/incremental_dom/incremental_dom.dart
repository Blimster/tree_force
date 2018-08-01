library incremental_dom;

import 'dart:html';
import 'dart:js';

final JsObject _incDom = context['IncrementalDOM'];

void elementOpen(String tagName, {String key, List<dynamic> staticPropertyValuePairs, List<dynamic> propertyValuePairs}) {
  final args = [tagName, key, staticPropertyValuePairs];
  if (propertyValuePairs != null) {
    args.addAll(propertyValuePairs);
  } else {
    args.add(null);
  }
  _incDom.callMethod('elementOpen', args);
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
