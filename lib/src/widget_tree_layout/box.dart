part of widget_tree_layout;

class Box extends StatelessWidget {
  final Length marginTop;
  final Length marginRight;
  final Length marginBottom;
  final Length marginLeft;
  final Length paddingTop;
  final Length paddingRight;
  final Length paddingBottom;
  final Length paddingLeft;
  final Length width;
  final Length height;
  final List<String> classes;
  final List<Widget> children;

  const Box({
    dynamic key,
    this.marginTop,
    this.marginRight,
    this.marginBottom,
    this.marginLeft,
    this.paddingTop,
    this.paddingRight,
    this.paddingBottom,
    this.paddingLeft,
    this.width,
    this.height,
    this.classes,
    this.children,
  }) : super(key: key);

  @override
  Widget build() {
    return Margin(
        top: marginTop,
        right: marginRight,
        bottom: marginBottom,
        left: marginLeft,
        child: Padding(
            top: paddingTop,
            right: paddingRight,
            bottom: paddingBottom,
            left: paddingLeft,
            child: Size(
                width: width,
                height: height,
                child: Container(
                  key: key,
                  classes: classes,
                  children: children,
                ))));
  }
}
