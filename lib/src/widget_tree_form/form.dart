part of widget_tree_form;

class Form extends StatefulWidget {
  final Widget child;

  Form({dynamic key, this.child}) : super(key: key);

  @override
  FormState createState() {
    return FormState(this);
  }

  static FormState of(BuildContext context) {
    final state = context.nearestStateOfType(FormState);
    if (state is FormState) {
      return state;
    }
    return null;
  }
}

class FormState extends State<Form> {
  final Set<FormFieldState> _formFields = Set<FormFieldState>();

  FormState(Form widget) : super(widget);

  void save() {
    _formFields.forEach((f) => f.save());
  }

  @override
  Widget build() {
    return widget.child;
  }

  void _registerFormField(FormFieldState state) {
    _formFields.add(state);
  }
}
