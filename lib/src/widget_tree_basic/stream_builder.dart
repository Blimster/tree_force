part of widget_tree_basic;

typedef WidgetBuilder<T> = Widget Function(T state);

class StreamBuilder<T> extends StatefulWidget {
  final T initial;
  final Stream<T> stream;
  final WidgetBuilder<T> builder;

  StreamBuilder({dynamic key, this.initial, this.stream, this.builder}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _StreamBuilderState<T>(this);
}

class _StreamBuilderState<T> extends State<StreamBuilder<T>> {
  T state;

  _StreamBuilderState(StreamBuilder widget) : super(widget) {
    if (widget.initial != null) {
      state = widget.initial;
    }
    widget.stream.listen((state) => setState(() => this.state = state));
  }

  @override
  Widget build() {
    return widget.builder(state);
  }
}
