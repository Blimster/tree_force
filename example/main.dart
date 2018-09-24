import 'dart:async';

import 'package:tree_force/tree_force.dart';
import 'package:tree_force/tree_force_basic.dart';
import 'package:tree_force/tree_force_fx.dart';
import 'package:tree_force/tree_force_layout.dart';

void main() {
  treeForce(
      '#output',
      Opacity(
          opacity: 1.0,
          child: Padding(
              insets: Insets(top: pixel(20)),
              child: Stack(children: [
                Size(
                  width: percentage(100.0),
                  height: pixel(400),
                  child: Row(children: [
//                    Size(
//                        width: pixel(200),
//                        child: Align(
//                          vertical: VerticalAlignment.top,
//                          child: Image(
//                            title: 'Dart',
//                            src: 'dart.svg',
//                          ),
//                        )),
                    Column(children: [
                      SimpleStateless(),
                      SimpleStateful('state'),
                      StreamBuilder<int>(
                          initial: 0,
                          stream: Stream.periodic<int>(Duration(seconds: 2), (count) => count + 1),
                          builder: (state) {
                            return Text(text: 'builder: ${state}');
                          }),
                      Text(key: 'key1', text: 'E-Mail'),
                      Text(text: 'Nickname'),
                      Input(
                        placeholder: 'test',
                        initialValue: 'foo',
                        onInput: (text) => print('value of input: $text'),
                      ),
                    ]),
                    FlexItem(
                        flexGrow: 1,
                        child: Align(
                          vertical: VerticalAlignment.bottom,
                          child: Button.text(
                            text: 'Sign In',
                            classes: ['foo'],
                            onClick: () => print('button was clicked!'),
                          ),
                        )),
                  ]),
                ),
              ]))));
}

class SimpleStateless extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(text: 'Hello'),
        Margin(
          insets: Insets(left: pixel(10)),
          child: Text(text: 'World'),
        ),
      ],
    );
  }
}

class SimpleStateful extends StatefulWidget {
  final String prefix;

  SimpleStateful(this.prefix);

  @override
  State<StatefulWidget> createState() {
    return _SimpleState(this);
  }
}

class _SimpleState extends State<SimpleStateful> {
  int counter = 0;

  _SimpleState(SimpleStateful widget) : super(widget) {
    Timer.periodic(Duration(seconds: 1), (_) => setState(() => counter++));
  }

  @override
  Widget build(BuildContext context) {
    return Text(text: '${widget.prefix}: $counter');
  }

  @override
  String toString() {
    return '_SimpleState{counter: $counter}';
  }
}
