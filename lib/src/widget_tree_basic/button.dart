part of widget_tree_basic;

class Button extends StatelessWidget {
  final String title;
  final String id;
  final List<String> additionalClasses;
  final void Function() onClick;

  Button({
    dynamic key,
    this.id,
    this.title,
    this.additionalClasses,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build() => InteractionListener(
      key: key,
      onClick: onClick,
      child: HtmlTag(
        tag: 'button',
        id: id,
        classes: classesOf('${classPrefix}button', additionalClasses),
        text: title,
      ));
}
