part of tree_force;

final JsObject _consoleSupport = JsObject(context['Object']);
final List<_TreeForce> _treeForces = [];

///
///
///
const classPrefix = 'tf-';

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
void treeForce(String selector, Widget root, {HtmlNodeRenderer renderer}) {
  if (_treeForces.where((wt) => wt.selector == selector).isNotEmpty) {
    throw ArgumentError("there already runs a widget tree on selector '$selector'!");
  }

  renderer ??= IncrementalDomHtmlNodeRenderer();

  final hostElement = querySelector(selector);
  while (hostElement.firstChild != null) {
    hostElement.firstChild.remove();
  }

  final treeForce = _TreeForce(selector, hostElement, root, renderer);
  _treeForces.add(treeForce);

  if (_consoleSupport['list'] == null) {
    _consoleSupport['list'] = (_) {
      for (int i = 0; i < _treeForces.length; i++) {
        final tree = _treeForces[i];
        print("t${i}: ${tree.selector} -> ${tree.root.runtimeType}");
      }
    };
    context['treeForce'] = _consoleSupport;
  }

  final ti = _consoleSupport['t${_treeForces.length - 1}'] = JsObject(context['Object']);
  ti['states'] = (_) => treeForce.states.entries.forEach((e) => print('${e.key} -> ${e.value}'));
  ti['tree'] = (_) {
    treeForce.nodes.keys.forEach((node) {
      final tokens = node.tokens;
      var result = '';
      for (int i = 0; i < tokens.length; i++) {
        result += '  ';
      }
      result += tokens.last;

      final state = treeForce.states[node];
      if (state != null) {
        result += ' -> ${state}';
      }

      print(result);
    });
    print('${treeForce.nodes.length} widgets');
  };

  treeForce.render();
}

class TreeLocation {
  final TreeLocation _parent;
  final String _token;
  final String _path;
  final Map<Type, int> _widgetTypePositions = {};

  TreeLocation._(Widget widget, this._parent, {int position = 0})
      : _token = '${widget.runtimeType}${widget.key != null ? '@${widget.key}' : '#${position}'}',
        _path = '${_parent != null ? '$_parent..' : ''}${widget.runtimeType}${widget.key != null ? '@${widget.key}' : '#${position}'}';

  TreeLocation _childLocation(Widget widget) {
    var position = _widgetTypePositions[widget.runtimeType];
    if (position == null) {
      position = 0;
    }
    _widgetTypePositions[widget.runtimeType] = position + 1;

    return TreeLocation._(widget, this, position: position);
  }

  String get token => _token;

  List<String> get tokens {
    final result = <String>[];
    var loc = this;
    while (loc != null) {
      result.insert(0, loc._token);
      loc = loc._parent;
    }
    return result;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is TreeLocation && runtimeType == other.runtimeType && _parent == other._parent && _token == other._token;

  @override
  int get hashCode => _parent.hashCode ^ _token.hashCode;

  @override
  String toString() {
    return _path;
  }
}

class _TreeForce {
  final String selector;
  final HtmlElement hostElement;
  final Widget root;
  final HtmlNodeRenderer renderer;
  final Map<TreeLocation, State> states = {};
  final Map<TreeLocation, TreeNode> nodes = {};

  _TreeForce(this.selector, this.hostElement, this.root, this.renderer);

  RenderTreeNode buildTreeNode(Widget widget, TreeLocation location, BuildContext parentContext) {
    nodes.clear();
    final result = buildTreeNodeInternal(widget, location, parentContext);

    final statesToRemove = [];
    states.keys.forEach((location) {
      if (!nodes.containsKey(location)) {
        statesToRemove.add(location);
      }
    });
    statesToRemove.forEach((location) => states.remove(location));

    return result;
  }

  RenderTreeNode buildTreeNodeInternal(Widget widget, TreeLocation location, BuildContext parentContext) {
    if (widget is MultiChildRenderWidget) {
      final treeNode = widget.createTreeNode();
      nodes[location] = treeNode;
      widget.children?.forEach((child) {
        if (child != null) {
          treeNode.addChild(buildTreeNodeInternal(child, location._childLocation(child), BuildContext._(child, null, parentContext)));
        }
      });
      return treeNode;
    } else if (widget is SingleChildRenderWidget) {
      final treeNode = widget.createTreeNode();
      nodes[location] = treeNode;
      final child = widget.child;
      if (child != null) {
        treeNode.setChild(buildTreeNodeInternal(child, location._childLocation(child), BuildContext._(child, null, parentContext)));
      }
      return treeNode;
    } else if (widget is RenderWidget) {
      final treeNode = widget.createTreeNode();
      nodes[location] = treeNode;
      return treeNode;
    } else if (widget is StatelessWidget) {
      final context = BuildContext._(widget, null, parentContext);
      final builtWidget = widget.build(context);
      nodes[location] = widget.createTreeNode();
      return buildTreeNodeInternal(builtWidget, location._childLocation(builtWidget), BuildContext._(builtWidget, null, context));
    } else if (widget is StatefulWidget) {
      var state = states[location];
      if (state == null) {
        state = widget.createState();
        state._treeForce = this;
        state._context = BuildContext._(widget, state, parentContext);
        states[location] = state;
      } else {
        state._widget = widget;
        state._context = BuildContext._(widget, state, parentContext);
        state.widgetDidChanged();
      }

      final treeNode = widget.createTreeNode();
      nodes[location] = treeNode;

      final builtWidget = state.build(state._context);
      final builtTreeNode = buildTreeNodeInternal(
        builtWidget,
        location._childLocation(builtWidget),
        BuildContext._(builtWidget, null, state._context),
      );

      return builtTreeNode;
    }
    throw new StateError('unsupported widget type: ${widget?.runtimeType}');
  }

  void render() {
    renderer.render(hostElement, [buildTreeNode(root, TreeLocation._(root, null), null).htmlNode]);
  }
}

class BuildContext {
  final Widget _widget;
  final State _state;
  final BuildContext _parent;

  BuildContext._(this._widget, this._state, this._parent);

  Widget nearestWidgetOfType(Type type) {
    if (_widget.runtimeType == type) {
      return _widget;
    } else if (_parent != null) {
      return _parent.nearestWidgetOfType(type);
    }
    return null;
  }

  State nearestStateOfType(Type type) {
    if (_state != null && _state.runtimeType == type) {
      return _state;
    } else if (_parent != null) {
      return _parent.nearestStateOfType(type);
    }
    return null;
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
    if (child is DecoratorRenderTreeNode) {
      decorate(this);
    } else {
      decorate(child);
    }
  }

  void decorate(RenderTreeNode child);
}

abstract class StatelessWidget extends Widget {
  const StatelessWidget({dynamic key}) : super(key: key);

  @override
  StatelessTreeNode createTreeNode() => StatelessTreeNode(this);

  Widget build(BuildContext context);
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
  W _widget;
  _TreeForce _treeForce;
  BuildContext _context;

  State(W widget) {
    _widget = widget;
  }

  Widget build(BuildContext context);

  void widgetDidChanged() {}

  W get widget => _widget;

  BuildContext get context => _context;

  void setState(void Function() setter) {
    setter();
    _treeForce.render();
  }

  @override
  String toString() {
    return '${this.runtimeType}';
  }
}
