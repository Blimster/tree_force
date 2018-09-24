part of tree_force_basic;

class Button extends StatelessWidget {
  final String id;
  final List<String> classes;
  final List<Widget> children;
  final void Function() onClick;

  Button({
    dynamic key,
    this.id,
    this.classes,
    this.children,
    this.onClick,
  }) : super(key: key);

  Button.text({
    dynamic key,
    this.id,
    String text,
    this.classes,
    this.onClick,
  })  : children = [Text(text: text)],
        super(key: key);

  Button.iconAndText({
    dynamic key,
    this.id,
    String text,
    FontIcon icon,
    this.classes,
    this.onClick,
  })  : children = [icon, Text(text: text)],
        super(key: key);

  Button.textAndIcon({
    dynamic key,
    this.id,
    String text,
    FontIcon icon,
    this.classes,
    this.onClick,
  })  : children = [Text(text: text), icon],
        super(key: key);

  @override
  Widget build(BuildContext context) => InteractionListener(
      onClick: onClick,
      child: HtmlTag(
        key: key,
        tag: 'button',
        id: id,
        classes: classesOf('${classPrefix}button', classes),
        children: children,
      ));
}
