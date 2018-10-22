part of tree_force;

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

  void init() {}

  void dispose() {}

  void widgetDidChanged() {}

  W get widget => _widget;

  BuildContext get context => _context;

  void setState(void Function() setter) {
    setter();
    _treeForce.render();
  }

  void updateState() {
    _treeForce.render();
  }

  @override
  String toString() {
    return '${this.runtimeType}';
  }
}
