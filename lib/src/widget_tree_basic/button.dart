part of widget_tree_basic;

class Button extends StatelessWidget {
  final String title;
  final String id;
  final List<String> classes;
  final void Function() onClick;

  Button({
    dynamic key,
    this.id,
    this.title,
    this.classes,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => InteractionListener(
      onClick: onClick,
      child: HtmlTag(
        key: key,
        tag: 'button',
        id: id,
        classes: classesOf('${classPrefix}button', classes),
        text: title,
      ));
}
