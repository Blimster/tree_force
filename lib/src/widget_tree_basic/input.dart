part of widget_tree_basic;

typedef ValueChangeListener = void Function(String);

class Input extends StatelessWidget {
  final String id;
  final String type;
  final String name;
  final String initialValue;
  final String placeholder;
  final Map<String, String> additionalAttributes;
  final List<String> additionalClasses;
  final ValueChangeListener onInput;

  Input({
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
      onInput: (value) {
        if (this.onInput != null) {
          onInput(value);
        }
      },
      child: HtmlTag(
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
      ));
}
