part of widget_tree_layout;

class Container extends StatelessWidget {
  final String marginTop;
  final String marginRight;
  final String marginBottom;
  final String marginLeft;
  final String paddingTop;
  final String paddingRight;
  final String paddingBottom;
  final String paddingLeft;
  final Length width;
  final Length height;
  final HorizontalAlignment horizontalAlignment;
  final VerticalAlignment verticalAlignment;
  final Widget child;

  const Container({
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
    this.horizontalAlignment,
    this.verticalAlignment,
    this.child,
  }) : super(key: key);

  @override
  Widget build() {
    return Margin(
        marginTop: marginTop,
        marginRight: marginRight,
        marginBottom: marginBottom,
        marginLeft: marginLeft,
        child: Padding(
            paddingTop: paddingTop,
            paddingRight: paddingRight,
            paddingBottom: paddingBottom,
            paddingLeft: paddingLeft,
            child: Size(
                width: width,
                height: height,
                child: Align(
                  horizontalAlignment: horizontalAlignment,
                  verticalAlignment: verticalAlignment,
                  child: child,
                ))));
  }
}
