part of tree_force_redux;

typedef StoreConverter<StateState, ViewModel> = ViewModel Function(Store<StateState> store);

typedef ViewModelBuilder<ViewModel> = Widget Function(BuildContext context, ViewModel vm);

class StoreConnector<StoreState, ViewModel> extends StatefulWidget {
  final ViewModelBuilder<ViewModel> builder;
  final StoreConverter<StoreState, ViewModel> converter;

  StoreConnector({this.builder, this.converter});

  @override
  State<StatefulWidget> createState() => _StoreConnectorState(this);
}

class _StoreConnectorState<StoreState, ViewModel> extends State<StoreConnector<StoreState, ViewModel>> {
  _StoreConnectorState(StoreConnector<StoreState, ViewModel> widget) : super(widget);

  Store<StoreState> store;
  StoreState state;

  @override
  void init() {
    store = StoreProvider.of<StoreState>(context);
    store.onChange.listen((state) {
      setState(() => this.state = state);
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, widget.converter(store));
  }
}
