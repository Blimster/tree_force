part of tree_force_form;

typedef FormWidgetBuilder = Widget Function(FormState);

class Form extends StatefulWidget {
  final String id;
  final FormWidgetBuilder builder;

  Form({dynamic key, this.id, this.builder}) : super(key: key);

  @override
  FormState createState() {
    return FormState(this);
  }

  static FormState of(BuildContext context) {
    final state = context.nearestStateOfType(FormState);
    if (state is FormState) {
      return state;
    }
    throw StateError('no form state found!');
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

  FormFieldState formFieldByKey(dynamic key) {
    for(final formField in _formFields) {
      if(formField.widget.key == key) {
        return formField;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return HtmlTag(
      tag: 'form',
      id: widget.id,
      listeners: {
        'onsubmit': [(e) {
          e.preventDefault();
        }]
      },
      children: [widget.builder(this)],
    );
  }

  void _registerFormField(FormFieldState state) {
    _formFields.add(state);
  }
}
