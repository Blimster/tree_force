part of tree_force_basic;

typedef ValueChangeListener = void Function(String);

class Input extends StatelessWidget {
  final String id;
  final String type;
  final String name;
  final String initialValue;
  final String placeholder;
  final bool autofocus;
  final Map<String, String> attributes;
  final List<String> classes;
  final ValueChangeListener onInput;

  Input({
    dynamic key,
    this.id,
    this.type,
    this.name,
    this.initialValue,
    this.placeholder,
    this.autofocus,
    this.attributes,
    this.classes,
    this.onInput,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ValueListener(
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
            'name': name,
            'placeholder': placeholder,
            'value': initialValue,
            'autofocus': autofocus != null && autofocus ? '' : null,
          }..removeWhere((_, v) => v == null),
          attributes,
        ),
        classes: classesOf('${classPrefix}input', classes),
      ));
}
