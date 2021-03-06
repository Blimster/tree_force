part of tree_force;

class KeyEvent {
  final html.KeyboardEvent _source;

  KeyEvent._(this._source);

  int get keyCode => _source.keyCode;

  bool get ctrlKey => _source.ctrlKey;

  bool get altKey => _source.altKey;

  bool get metaKey => _source.metaKey;

  bool get shiftKey => _source.shiftKey;

  void preventDefault() => _source.preventDefault();

  void stopPropagation() => _source.stopPropagation();
}

typedef OnInteraction = void Function();
typedef OnKey = void Function(KeyEvent event);

class InteractionListener extends DecoratorRenderWidget {
  final OnInteraction onClick;
  final OnInteraction onFocus;
  final OnInteraction onBlur;
  final OnKey onKeyDown;
  final OnKey onKeyUp;

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
          widget.onKeyDown(KeyEvent._(e));
        }
      });
    }
    if (widget.onKeyUp != null) {
      _htmlNode.addListener('onkeyup', (e) {
        if (e is html.KeyboardEvent) {
          widget.onKeyUp(KeyEvent._(e));
        }
      });
    }
  }
}
