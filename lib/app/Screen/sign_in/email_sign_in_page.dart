import 'package:flutter/material.dart';
import 'package:mo8tarib/app/Screen/dashboard/dashboard_layout.dart';
import 'package:mo8tarib/app/Screen/sign_in/add_inf.dart';
import 'package:mo8tarib/app/Screen/sign_in/bloc/email_sign_in_bloc.dart';
import 'package:mo8tarib/app/Screen/sign_in/model/email_sign_in_model.dart';
import 'package:mo8tarib/app/common_widgets/form_raised_button.dart';
import 'package:mo8tarib/app/common_widgets/platform_exception_alert_dialog.dart';
import 'package:mo8tarib/services/auth.dart';
import 'package:mo8tarib/services/data_base.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class EmailSignInPage extends StatefulWidget {
  EmailSignInPage({@required this.bloc});
  final EmailSignInBloc bloc;

  static Widget create(BuildContext context) {
    final AuthBase auth = Provider.of<AuthBase>(context);
    return Provider<EmailSignInBloc>(
      create: (context) => EmailSignInBloc(auth: auth),
      child: Consumer<EmailSignInBloc>(
          builder: (context, bloc, _) => EmailSignInPage(bloc: bloc)),
      dispose: (context, bloc) => bloc.dispose(),
    );
  }

  @override
  _EmailSignInPageState createState() => _EmailSignInPageState();
}

class _EmailSignInPageState extends State<EmailSignInPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
  }

//  void _addInfo(BuildContext context) {
//    Navigator.of(context).push(
//      MaterialPageRoute(
//        fullscreenDialog: true,
//        builder: (context) => Provider<DateBase>(
//            create: (context) =>DateBase() , child: AddINf()),
//      ),
//    );
//  }

  Future<void> _submit(EmailSignInModel model) async {
    try {
      final user = await widget.bloc.submit();
      if (model.isNewUser) {
        Navigator.of(context).push(
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => AddINf.create(context, user),
          ),
        );
      } else {
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) => Provider<Database>(
              create: (_) => FireStoreDatabase(uid: user.uid),
              child: DashBoardLayout(
                uid: user.uid,
              )),
        );
      }
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'SignIn Failed',
        exception: e,
      ).show(context);
    }
  }

  void _emailEditingComplete(EmailSignInModel model) {
    final newFocus = model.emailValidator.isValid(model.email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _toggleFormType() {
    widget.bloc.toggleFormType();
    _emailController.clear();
    _passwordController.clear();
  }

  List<Widget> _buildChildren(EmailSignInModel model) {
    return [
      _buildEmailTextField(model),
      SizedBox(height: 8),
      _buildPasswordTextField(model),
      SizedBox(height: 8),
      FormRaisedButton(
        onPressed: () => model.canSubmit ? _submit(model) : null,
        text: model.primaryButtonText,
      ),
      SizedBox(height: 8),
      FlatButton(
        onPressed: !model.isLoaded ? () => _toggleFormType() : null,
        child: Text(model.secondButtonText),
      )
    ];
  }

  TextField _buildPasswordTextField(EmailSignInModel model) {
    return TextField(
      controller: _passwordController,
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: model.passwordErrorText,
        enabled: model.isLoaded == false,
      ),
      onChanged: widget.bloc.updatePassword,
      onEditingComplete: () {
        _submit(model);
      },
      focusNode: _passwordFocusNode,
      obscureText: true,
      textInputAction: TextInputAction.done,
    );
  }

  TextField _buildEmailTextField(EmailSignInModel model) {
    return TextField(
      controller: _emailController,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'user@email.com',
        errorText: model.emailErrorText,
        enabled: model.isLoaded == false,
      ),
      onChanged: widget.bloc.updateEmail,
      focusNode: _emailFocusNode,
      onEditingComplete: () => _emailEditingComplete(model),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<EmailSignInModel>(
        stream: widget.bloc.modelStream,
        initialData: EmailSignInModel(),
        builder: (context, snapshot) {
          final EmailSignInModel model = snapshot.data;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: _buildChildren(model),
            ),
          );
        });
  }
}
