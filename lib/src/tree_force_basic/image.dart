part of tree_force_basic;

class Image extends HtmlTag {
  Image({dynamic key, String id, String src, String title, List<String> classes})
      : super(
          key: key,
          tag: 'img',
          id: id,
          attributes: {
            'src': src,
            'title': title ?? '',
          },
          classes: classesOf('${classPrefix}image', classes),
        );
}
