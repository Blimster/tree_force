part of tree_force_basic;

class Link extends StatelessWidget {
  final String title;
  final String id;
  final List<String> classes;
  final void Function() onClick;

  Link({
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
        tag: 'a',
        id: id,
        classes: classesOf('${classPrefix}link', classes),
        text: title,
      ));
}
