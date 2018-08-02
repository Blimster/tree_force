import 'dart:async';

import 'package:widget_tree/widget_tree.dart';
import 'package:widget_tree/widget_tree_basic.dart';
import 'package:widget_tree/widget_tree_layout.dart';

void main() {
//  patch(querySelector('#test'), () {
//    elementOpen('div', propertyValuePairs: ['onclick', (MouseEvent e) => print(e.client.x)]);
//    text('foo');
//    elementClose('div');
//  });

  runWidgetTree(
    '#output',
    Sized(
      width: '100%',
      height: '400px',
      child: Row(children: [
        Column(children: [
          SimpleStateless(),
          SimpleStateful('state'),
          Text(text: 'E-Mail'),
          Text(text: 'Nickname'),
          Input(
            placeholder: 'test',
            initialValue: 'foo',
            onInput: (text) => print('value of input: $text'),
          ),
        ]),
        FlexItem(
            flexGrow: 1,
            child: Aligned(
              child: Button(
                title: 'Sign In',
                additionalClasses: ['foo'],
                onClick: () => print('button was clicked!'),
              ),
            )),
      ]),
    ),
  );
}

class SimpleStateless extends StatelessWidget {
  @override
  Widget build() {
    return Row(
      children: [
        Text(text: 'Hello'),
        Boxed(
          marginLeft: '10px',
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
  Widget build() {
    return Text(text: '${widget.prefix}: $counter');
  }

  @override
  String toString() {
    return '_SimpleState{counter: $counter}';
  }
}
