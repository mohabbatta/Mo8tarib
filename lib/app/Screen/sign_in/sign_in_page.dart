import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mo8tarib/app/Screen/sign_in/bloc/sign_in_manager.dart';
import 'package:mo8tarib/app/Screen/sign_in/email_sign_in_page.dart';
import 'package:mo8tarib/app/common_widgets/platform_exception_alert_dialog.dart';
import 'package:mo8tarib/app/common_widgets/social_icon.dart';
import 'package:mo8tarib/helper/localization.dart';
import 'package:mo8tarib/services/auth.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  final SignInManager manager;
  final bool isLoading;
  const SignInPage({Key key, @required this.manager, @required this.isLoading})
      : super(key: key);

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context);
    return ChangeNotifierProvider<ValueNotifier<bool>>(
      create: (_) => ValueNotifier<bool>(false),
      child: Consumer<ValueNotifier<bool>>(
        builder: (_, isLoading, __) => Provider<SignInManager>(
          create: (_) => SignInManager(auth: auth, isLoading: isLoading),
          child: Consumer<SignInManager>(
              builder: (context, bloc, _) => SignInPage(
                    manager: bloc,
                    isLoading: isLoading.value,
                  )),
        ),
      ),
    );
  }

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..forward();
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceIn,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showSignInError(BuildContext context, PlatformException exception) {
    PlatformExceptionAlertDialog(
        title: 'Sign In Failed ', exception: exception);
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      await widget.manager.signInWithGoogle();
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
    }
  }

  Future<void> _signInWithFaceBook(BuildContext context) async {
    try {
      await widget.manager.signInWithFaceBook();
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      } else if (e.code != 'ERROR') {
        _showSignInError(context, e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    return Scaffold(
      body: _buildContent(context, localization),
    );
  }

  Widget _buildContent(BuildContext context, AppLocalizations localization) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ScaleTransition(
                scale: _animation,
                child: Center(
                    child: Image.asset(
                      'images/a1.png',
                      color: Colors.indigo,
                      width: 120,
                      height: 120,
                    )),
              ),
              Text(
                "Mo8trab",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 50, fontFamily: "Pacifico"),
              ),
              // SizedBox(
              //   height: 50,
              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Join us",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, fontFamily: "VareaRound"),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SocialIcon(
                      icon: FontAwesomeIcons.facebook,
                      color: Colors.indigo,
                      socialFunction: widget.isLoading
                          ? null
                          : () {
                        _signInWithFaceBook(context);
                      }),
                  SocialIcon(
                      icon: FontAwesomeIcons.googlePlus,
                      color: Colors.red,
                      socialFunction: widget.isLoading
                          ? null
                          : () {
                        _signInWithGoogle(context);
                      }),
                  SocialIcon(
                      icon: FontAwesomeIcons.apple,
                      //color: Colors.yellow,
                      socialFunction: widget.isLoading
                          ? null
                          : () {
                        // _emailSignIn(context);
                      })
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Or",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, fontFamily: "VareaRound"),
                ),
              ),
              Card(
                child: EmailSignInPage.create(context),
                color: Colors.white.withOpacity(1),
              )
            ],
          ),
        ),
      ),
    );
  }
}
