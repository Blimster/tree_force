part of widget_tree;

final JsObject _consoleSupport = JsObject(context['Object']);
final List<_WidgetTree> _widgetTrees = [];

///
///
///
const classPrefix = 'wt-';

///
/// Binds a widget tree to an HTML element.
///
/// The HTML element is selected using the given selector. The widget tree is described by the
/// given root widget and its child widgets.
///
/// All child elements of the selected HTML element will be removed from the DOM and the HTML element
/// representing the root widget will be added instead.
///
/// It is an error to run more than one widget tree on the same HTML element.
///
/// After this function is executed, a JavaScript object with the name 'wt' is available in the
/// browser console, that provides some debug information at runtime.
///
void runWidgetTree(String selector, Widget root, {HtmlNodeRenderer renderer}) {
  if (_widgetTrees.where((wt) => wt.selector == selector).isNotEmpty) {
    throw ArgumentError("there already runs a widget tree on selector '$selector'!");
  }

  renderer ??= IncrementalDomHtmlNodeRenderer();

  final hostElement = querySelector(selector);
  while (hostElement.firstChild != null) {
    hostElement.firstChild.remove();
  }

  final widgetTree = _WidgetTree(selector, hostElement, root, renderer);
  _widgetTrees.add(widgetTree);

  if (_consoleSupport['list'] == null) {
    _consoleSupport['list'] = (_) {
      for (int i = 0; i < _widgetTrees.length; i++) {
        final tree = _widgetTrees[i];
        print("t${i}: ${tree.selector} -> ${tree.root.runtimeType}");
      }
    };
    context['wt'] = _consoleSupport;
  }

  final ti = _consoleSupport['t${_widgetTrees.length - 1}'] = JsObject(context['Object']);
  ti['states'] = (_) => widgetTree.states.entries.forEach((e) => print('${e.key} -> ${e.value}'));
  ti['tree'] = (_) => widgetTree.nodes.keys.forEach((p) => print(p));

  widgetTree.render();
}

class _TreeLocation {
  final String path;
  final Map<Type, int> widgetTypePositions = {};

  _TreeLocation(Widget widget, {String parent = null, int position = 0}) : path = '${parent != null ? '$parent.' : ''}${widget.runtimeType}#$position';

  _TreeLocation childLocation(Widget widget, {bool resetPositions = false}) {
    if (resetPositions) {
      widgetTypePositions.clear();
    }
    var position = widgetTypePositions[widget.runtimeType];
    if (position == null) {
      position = 0;
    }
    widgetTypePositions[widget.runtimeType] = position + 1;

    return _TreeLocation(widget, parent: path, position: position);
  }

  @override
  bool operator ==(Object other) => identical(this, other) || other is _TreeLocation && runtimeType == other.runtimeType && path == other.path;

  @override
  int get hashCode => path.hashCode;

  @override
  String toString() {
    return path;
  }
}

class _WidgetTree {
  final String selector;
  final HtmlElement hostElement;
  final Widget root;
  final HtmlNodeRenderer renderer;
  final Map<_TreeLocation, State> states = {};
  final Map<_TreeLocation, TreeNode> nodes = {};

  _WidgetTree(this.selector, this.hostElement, this.root, this.renderer);

  RenderTreeNode buildTreeNode(Widget widget, _TreeLocation location) {
    if (widget is MultiChildRenderWidget) {
      final treeNode = widget.createTreeNode();
      nodes[location] = treeNode;
      widget.children?.forEach((child) {
        treeNode.addChild(buildTreeNode(child, location.childLocation(child)));
      });
      return treeNode;
    } else if (widget is SingleChildRenderWidget) {
      final child = widget.child;
      final treeNode = widget.createTreeNode();
      nodes[location] = treeNode;
      treeNode.setChild(buildTreeNode(child, location.childLocation(child)));
      return treeNode;
    } else if (widget is RenderWidget) {
      final treeNode = widget.createTreeNode();
      nodes[location] = treeNode;
      return treeNode;
    } else if (widget is StatelessWidget) {
      final builtWidget = widget.build();
      nodes[location] = widget.createTreeNode();
      return buildTreeNode(builtWidget, location.childLocation(builtWidget));
    } else if (widget is StatefulWidget) {
      var state = states[location];
      if (state == null) {
        state = widget.createState();
        state._widgetTree = this;
        states[location] = state;
      }

      final treeNode = widget.createTreeNode();
      nodes[location] = treeNode;

      final builtWidget = state.build();
      final builtTreeNode = buildTreeNode(builtWidget, location.childLocation(builtWidget, resetPositions: true));

      return builtTreeNode;
    }
    throw new StateError('unsupported widget type: ${widget?.runtimeType}');
  }

  void render() {
    renderer.render(hostElement, buildTreeNode(root, _TreeLocation(root)).htmlNode);
  }
}

///
/// The base class for all widgets.
///
/// A widget tree is built up of nothing than widgets.
///
abstract class Widget {
  final dynamic key;

  const Widget({this.key});

  TreeNode createTreeNode();
}

///
/// The base class for all tree nodes.
///
/// A tree node represents an instance of a widget in the widget tree.
///
abstract class TreeNode<W extends Widget> {
  final W widget;

  TreeNode(Widget widget) : widget = widget;
}

///
/// The base class for all widgets, that can be rendered directly as an HTML element.
///
abstract class RenderWidget extends Widget {
  const RenderWidget({dynamic key}) : super(key: key);

  RenderTreeNode createTreeNode();
}

///
/// The base class for all tree nodes, that represents render widgets.
///
abstract class RenderTreeNode<W extends RenderWidget> extends TreeNode<W> {
  RenderTreeNode(Widget widget) : super(widget);

  ///
  /// Creates an [HtmlNode] representing this tree nodes widget. Multiple calls of this function
  /// have to return the same instance of the [HtmlNode].
  ///
  HtmlNode get htmlNode;
}

///
/// The base class for all widgets, that can be rendered directly as an HTML element and has child widgets.
///
abstract class MultiChildRenderWidget extends RenderWidget {
  ///
  /// A list of all child widgets.
  ///
  final List<Widget> children;

  const MultiChildRenderWidget({dynamic key, this.children}) : super(key: key);

  MultiChildRenderTreeNode createTreeNode();
}

abstract class MultiChildRenderTreeNode<W extends MultiChildRenderWidget> extends RenderTreeNode<W> {
  MultiChildRenderTreeNode(RenderWidget widget) : super(widget);

  void addChild(RenderTreeNode child);
}

abstract class SingleChildRenderWidget extends RenderWidget {
  final Widget child;

  const SingleChildRenderWidget({dynamic key, this.child}) : super(key: key);

  SingleChildRenderTreeNode createTreeNode();
}

abstract class SingleChildRenderTreeNode<W extends SingleChildRenderWidget> extends RenderTreeNode<W> {
  SingleChildRenderTreeNode(RenderWidget widget) : super(widget);

  void setChild(RenderTreeNode child);
}

abstract class DecoratorRenderWidget extends SingleChildRenderWidget {
  const DecoratorRenderWidget({Widget child}) : super(child: child);

  DecoratorRenderTreeNode createTreeNode();
}

abstract class DecoratorRenderTreeNode<W extends DecoratorRenderWidget> extends SingleChildRenderTreeNode<W> {
  DecoratorRenderTreeNode(Widget widget) : super(widget);

  HtmlNode _htmlNode;

  @override
  HtmlNode get htmlNode => _htmlNode;

  @override
  void setChild(RenderTreeNode child) {
    _htmlNode = child.htmlNode;
    decorate(child);
  }

  void decorate(RenderTreeNode child);
}

abstract class StatelessWidget extends Widget {
  const StatelessWidget({dynamic key}) : super(key: key);

  @override
  StatelessTreeNode createTreeNode() => StatelessTreeNode(this);

  Widget build();
}

class StatelessTreeNode extends TreeNode<StatelessWidget> {
  StatelessTreeNode(StatelessWidget widget) : super(widget);
}

abstract class StatefulWidget extends Widget {
  const StatefulWidget({dynamic key}) : super(key: key);

  @override
  StatefulTreeNode createTreeNode() => StatefulTreeNode(this);

  State<StatefulWidget> createState();
}

class StatefulTreeNode extends TreeNode<StatefulWidget> {
  StatefulTreeNode(StatefulWidget widget) : super(widget);
}

abstract class State<W extends StatefulWidget> {
  final W widget;
  _WidgetTree _widgetTree;

  State(this.widget);

  Widget build();

  void setState(void Function() setter) {
    setter();
    _widgetTree.render();
  }

  @override
  String toString() {
    return '${this.runtimeType}';
  }
}
