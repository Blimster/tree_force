part of tree_force_basic;

class CheckBox extends StatelessWidget {
  final String id;
  final String label;
  final List<String> classes;
  final OnChange<bool> onChange;

  CheckBox({dynamic key, this.id, this.label, this.classes, this.onChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeListener<bool>(
      prop: ElementProperty.checked,
      onChange: (value) {
        if(this.onChange != null) {
          this.onChange(value);
        }
      },
      child: HtmlTag(
        id: id,
        tag: 'label',
        classes: classesOf('${classPrefix}checkbox', classes),
        children: [
          HtmlTag(
            tag: 'input',
            classes: ['${classPrefix}checkbox-box'],
            attributes: {'type': 'checkbox'},
          ),
          HtmlTag(
            tag: 'span',
            classes: ['${classPrefix}checkbox-label'],
            text: label,
          ),
        ],
      ),
    );
  }
}
