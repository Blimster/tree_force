part of tree_force_basic;

class BulletList extends StatelessWidget {
  final String id;
  final List<String> classes;
  final List<Widget> children;

  BulletList({
    dynamic key,
    this.id,
    this.classes,
    this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HtmlTag(
      key: key,
      tag: 'ul',
      id: id,
      classes: classesOf('${classPrefix}bulletlist', classes),
      children: _mapChildren(children),
    );
  }
}

_mapChildren(List<Widget> source) {
  if (source == null) {
    return null;
  }
  return source.map((w) => HtmlTag(
        tag: 'li',
        classes: ['${classPrefix}bulletlist-item'],
        children: [w],
      )).toList(growable: false);
}
