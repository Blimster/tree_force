part of widget_tree_basic;

typedef RouteBuilder = Widget Function(String location, Map<String, dynamic> params);

final Map<String, RouteBuilder> _routes = {};
final Map<String, _RouterState> _states = {};

class Router extends StatefulWidget {
  final String initialLocation;
  final Set<String> locations;

  Router({this.initialLocation, Map<String, RouteBuilder> routes}) : locations = routes.keys.toSet() {
    if (_routes.keys.where((location) => routes.containsKey(location)).isNotEmpty) {
      throw ArgumentError('duplicate location!');
    }
    _routes.addAll(routes);
  }

  @override
  State<StatefulWidget> createState() {
    final state = _RouterState(this);
    locations.forEach((location) => _states[location] = state);
    return state;
  }

  static void navigate(String location, {Map<String, dynamic> params}) {
    final state = _states[location];
    state?.setState(() {
      state.builder = _routes[location];
      state.location = location;
      state.params = params;
    });
  }
}

class _RouterState extends State<Router> {
  RouteBuilder builder;
  String location;
  Map<String, dynamic> params;

  _RouterState(Router widget) : super(widget);

  @override
  Widget build() {
    return builder(location, params);
  }
}
