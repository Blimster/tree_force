part of tree_force_form;

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

  void setDirty() {
    _formFields.forEach((f) => f.setDirty());
  }

  void setTouched() {
    _formFields.forEach((f) => f.setTouched());
  }

  bool validate() {
    if (_formFields.isNotEmpty) {
      return _formFields.map((f) => f.validate()).reduce((v, e) => v && e);
    }
    return true;
  }

  void reset() {
    _formFields.forEach((f) => f.reset());
  }

  void submit() {
    _formFields.forEach((f) => f.submit());
  }

  @override
  Widget build() {
    return widget.child;
  }

  void _registerFormField(FormFieldState state) {
    _formFields.add(state);
  }
}
