part of tree_force_basic;

typedef ValueChangeListener = void Function(String);
typedef ValueProvider = String Function();

class Input extends StatelessWidget {
  final String id;
  final String type;
  final String name;
  final String initialValue;
  final ValueProvider value;
  final String placeholder;
  final bool autoFocus;
  final bool spellCheck;
  final Map<String, String> attributes;
  final List<String> classes;
  final FocusNode focusNode;
  final ValueChangeListener onInput;

  Input({
    dynamic key,
    this.id,
    this.type,
    this.name,
    this.initialValue,
    this.value,
    this.placeholder,
    this.autoFocus,
    this.spellCheck,
    this.attributes,
    this.classes,
    this.focusNode,
    this.onInput,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ValueListener(
      onInput: (value) {
        if (this.onInput != null) {
          onInput(value);
        }
      },
      child: Focus(
        node: focusNode,
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
                  'autofocus': autoFocus != null && autoFocus ? '' : null,
                  'spellcheck': spellCheck != null && spellCheck ? 'true' : 'false',
                }..removeWhere((_, v) => v == null),
                attributes,
              ),
              classes: classesOf('${classPrefix}input', classes),
              modifier: (htmlNode, event) {
                final input = htmlNode.htmlElement as InputElement;
                if (value != null) {
                  input.value = value();
                }
                if (event == HtmlNodeModifierEvent.mount && autoFocus != null && autoFocus) {
                  input.focus();
                }
              })));
}
