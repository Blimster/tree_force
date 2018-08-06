part of widget_tree_fx;

class Transform extends SingleChildRenderWidget {
  final Matrix4 transform;

  Transform(this.transform, Widget child) : super(child: child);

  @override
  SingleChildRenderTreeNode<SingleChildRenderWidget> createTreeNode() {
    return TransformTreeNode(this);
  }
}

class TransformTreeNode extends SingleChildRenderTreeNode<Transform> {
  HtmlNode _htmlNode;

  TransformTreeNode(Transform widget) : super(widget);

  @override
  HtmlNode get htmlNode => _htmlNode;

  @override
  void setChild(RenderTreeNode<RenderWidget> child) {
    _htmlNode = child.htmlNode;
    if(widget.transform != null) {
      final cells = List<num>(16);
      widget.transform.copyIntoArray(cells, 0);
      _htmlNode.addStyle('transform', 'matrix3d(${cells.join(', ')})');
    }
  }
}
