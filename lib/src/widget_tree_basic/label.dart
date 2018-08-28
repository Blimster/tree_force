part of widget_tree_basic;

class Label extends HtmlTag {
  Label({dynamic key, String id, String text, String labelFor, List<String> classes})
      : super(
          tag: 'label',
          key: key,
          id: id,
          attributes: {'for': labelFor},
          classes: classesOf('${classPrefix}label', classes),
          text: text,
        );
}
