part of tree_force_redux;

class StoreProvider<S> extends StatelessWidget {
  final Store<S> store;
  final Widget child;

  const StoreProvider({
    dynamic key,
    this.store,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;
  }

  static Store<S> of<S>(BuildContext context) {
    final type = _typeOf<StoreProvider<S>>();
    final StoreProvider<S> widget = context.nearestWidgetOfType(type);
    if (widget != null) {
      return widget.store;
    }
    throw StateError('no store provider found!');
  }

  static Type _typeOf<T>() => T;
}
