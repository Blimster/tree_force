part of widget_tree_form;

class FieldTraffic extends StatelessWidget {
  final FormFieldState formField;
  final Widget child;

  FieldTraffic({this.formField, this.child});

  @override
  Widget build() {
    return ValueListener(
        onInput: (_) => formField.setDirty(),
        child: InteractionListener(
          onBlur: () => formField.setTouched(),
          child: child,
        ));
  }
}
