part of widget_tree_basic;

typedef RouteBuilder = Widget Function(String location, Map<String, dynamic> params);

final Map<String, StreamController<LocationWithParams>> _streamControllers = {};

class Router extends StatelessWidget {
  final StreamController<LocationWithParams> _streamController = StreamController<LocationWithParams>();
  final LocationWithParams initial;
  final Map<String, RouteBuilder> builders;

  Router({dynamic key, this.initial, Stream<LocationWithParams> stream, this.builders}) : super(key: key) {
    builders?.keys?.forEach((location) => _streamControllers[location] = _streamController);

    if (stream != null) {
      stream.listen((event) => _streamController.add(event));
    }
  }

  static void navigate(String location, [Map<String, dynamic> params]) {
    _streamControllers[location]?.add(LocationWithParams(location, params));
  }

  @override
  Widget build() {
    return StreamBuilder<LocationWithParams>(
        initial: initial,
        stream: _streamController.stream,
        builder: (state) {
          if (state == null) {
            throw StateError('null event received! maybe no initial location was defined?');
          }
          final builder = builders[state.location];
          if (builder == null) {
            throw StateError('no route builder found for location: ${state.location}');
          }
          return builder(state.location, state.params);
        });
  }
}

class LocationWithParams {
  final String location;
  final Map<String, dynamic> params;

  LocationWithParams(this.location, [this.params]);
}
