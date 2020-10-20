import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mo8tarib/app/common_widgets/platfrom_widgets.dart';

class PlatformAlertDialog extends PlatFormWidgets {
  PlatformAlertDialog(
      {@required this.title,
      this.cancelActionText,
      @required this.content,
      @required this.defaultActionText})
      : assert(title != null),
        assert(content != null),
        assert(defaultActionText != null);

  final String title;
  final String content;
  final String defaultActionText;
  final String cancelActionText;

  Future<bool> show(BuildContext context) async {
    return Platform.isIOS
        ? await showCupertinoDialog(
            context: context, builder: (context) => this)
        : await showDialog(
            context: context,
            builder: (context) => this,
            barrierDismissible: false,
          );
  }

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: _buildAction(context),
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: _buildAction(context),
    );
  }

  List<Widget> _buildAction(BuildContext context) {
    final actions = <Widget>[];
    if (cancelActionText != null) {
      actions.add(AlertDialogAction(
        child: Text(cancelActionText),
        onPressed: () {
          Navigator.of(context).pop(false);
        },
      ));
    }
    actions.add(
      AlertDialogAction(
        child: Text(defaultActionText),
        onPressed: () {
          Navigator.of(context).pop(true);
        },
      ),
    );
    return actions;
  }
}

class AlertDialogAction extends PlatFormWidgets {
  final Widget child;
  final VoidCallback onPressed;

  AlertDialogAction({this.child, this.onPressed});

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoDialogAction(
      child: child,
      onPressed: onPressed,
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return FlatButton(onPressed: onPressed, child: child);
  }
}
