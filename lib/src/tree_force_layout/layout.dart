part of tree_force_layout;

class Layout extends StatelessWidget {
  final Insets margin;
  final Insets padding;
  final Length width;
  final Length height;
  final List<String> classes;
  final Widget child;

  const Layout({
    dynamic key,
    this.margin,
    this.padding,
    this.width,
    this.height,
    this.classes,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Margin(
        insets: margin,
        child: Padding(
            insets: padding,
            child: Size(
              width: width,
              height: height,
              child: child,
            )));
  }
}
