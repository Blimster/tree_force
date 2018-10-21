part of tree_force;

class KeyEvent {
  final int keyCode;
  final bool altKey;
  final bool ctrlKey;
  final bool metaKey;
  final bool shiftKey;

  KeyEvent(this.keyCode, this.altKey, this.ctrlKey, this.metaKey, this.shiftKey);
}

typedef KeyListener = void Function(KeyEvent event);

class InteractionListener extends DecoratorRenderWidget {
  final html.VoidCallback onClick;
  final html.VoidCallback onFocus;
  final html.VoidCallback onBlur;
  final KeyListener onKeyDown;
  final KeyListener onKeyUp;

  const InteractionListener({this.onClick, this.onFocus, this.onBlur, this.onKeyDown, this.onKeyUp, Widget child}) : super(child: child);

  @override
  InteractionListenerTreeNode createTreeNode() {
    return InteractionListenerTreeNode(this);
  }
}

class InteractionListenerTreeNode extends DecoratorRenderTreeNode<InteractionListener> {
  InteractionListenerTreeNode(InteractionListener widget) : super(widget);

  @override
  void decorate(RenderTreeNode<RenderWidget> child) {
    if (widget.onClick != null) {
      _htmlNode.addListener('onclick', (e) {
        e.stopPropagation();
        widget.onClick();
      });
    }
    if (widget.onFocus != null) {
      _htmlNode.addListener('onfocus', (e) {
        e.stopPropagation();
        widget.onFocus();
      });
    }
    if (widget.onBlur != null) {
      _htmlNode.addListener('onblur', (e) {
        e.stopPropagation();
        // prevents an exception in the browser console.
        // it's a combination of the fact, that an input
        // field to be removed triggers a blur event and
        // the use of incremental-dom.
        Future.microtask(() => widget.onBlur());
      });
    }
    if (widget.onKeyDown != null) {
      _htmlNode.addListener('onkeydown', (e) {
        if (e is html.KeyboardEvent) {
          widget.onKeyDown(KeyEvent(e.keyCode, e.altKey, e.ctrlKey, e.metaKey, e.shiftKey));
        }
      });
    }
    if (widget.onKeyUp != null) {
      _htmlNode.addListener('onkeyup', (e) {
        if (e is html.KeyboardEvent) {
          widget.onKeyUp(KeyEvent(e.keyCode, e.altKey, e.ctrlKey, e.metaKey, e.shiftKey));
        }
      });
    }
  }
}
