part of widget_tree_basic;

typedef ValueChangeListener = void Function(String);

class Input extends HtmlTag {
  final ValueChangeListener onInput;

  Input({
    dynamic key,
    String id,
    String type,
    String name,
    String placeholder,
    String initialValue,
    Map<String, String> additionalAttributes,
    List<String> additionalClasses,
    this.onInput,
  }) : super(
          key: key,
          tag: 'input',
          id: id,
          attributes: attributesOf(
            {
              'type': type ?? 'text',
              'name': name ?? '',
              'placeholder': placeholder ?? '',
              'value': initialValue ?? '',
            },
            additionalAttributes,
          ),
          classes: classesOf('${classPrefix}input', additionalClasses),
        );
}

class Input2 extends StatelessWidget {
  final String id;
  final String type;
  final String name;
  final String initialValue;
  final String placeholder;
  final Map<String, String> additionalAttributes;
  final List<String> additionalClasses;
  final ValueChangeListener onInput;

  Input2({
    dynamic key,
    this.id,
    this.type,
    this.name,
    this.initialValue,
    this.placeholder,
    this.additionalAttributes,
    this.additionalClasses,
    this.onInput,
  }) : super(key: key);

  @override
  Widget build() => ValueListener(
      key: key,
      onInput: (v) => print(v),
      child: HtmlTag(key: key,
        tag: 'input',
        id: id,
        attributes: attributesOf(
          {
            'id': 'foo',
            'type': type ?? 'text',
            'name': name ?? '',
            'placeholder': placeholder ?? '',
            'value': initialValue ?? '',
          },
          additionalAttributes,
        ),
        classes: classesOf('${classPrefix}input', additionalClasses),
      ));
}
