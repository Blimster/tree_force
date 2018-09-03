part of tree_force_fx;

class Transform extends DecoratorRenderWidget {
  final Matrix4 transform;

  Transform({this.transform, Widget child}) : super(child: child);

  @override
  TransformTreeNode createTreeNode() {
    return TransformTreeNode(this);
  }
}

class TransformTreeNode extends DecoratorRenderTreeNode<Transform> {
  TransformTreeNode(Transform widget) : super(widget);

  @override
  void decorate(RenderTreeNode<RenderWidget> child) {
    if (widget.transform != null) {
      final cells = List<num>(16);
      widget.transform.copyIntoArray(cells, 0);
      child.htmlNode.addStyle('transform', 'matrix3d(${cells.join(', ')})');
    }
  }
}
