import 'package:flutter/material.dart';
import 'package:mo8tarib/app/Screen/sign_in/model/user.dart';
import 'package:mo8tarib/servies/data_base.dart';
import 'package:provider/provider.dart';

class EditPage extends StatefulWidget {
  const EditPage({
    Key key,
    @required this.database,
  }) : super(key: key);
  final Database database;

//  static Future<void> show(
//    BuildContext context, {
//    Database database,
//  }) async {
//    await Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
//      builder: (
//        context,
//      ) =>
//          EditPage(
//        database: database,
//      ),
//      fullscreenDialog: true,
//    ));
//  }

  static Future<void> show(BuildContext context) async {
    final Database database = Provider.of<Database>(context, listen: false);
    await Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
      builder: (context) => EditPage(database: database),
      fullscreenDialog: true,
    ));
  }

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlatButton(
            onPressed: () async {
              final user = User(
                uid: "zxcz",
                url: "00",
                phone: "00",
                gender: "00",
                email: "00",
                address: "00",
                age: "00",
                firstName: "00",
                lastName: "00",
                midName: "00",
              );
              await widget.database.setUser(user);
            },
            child: Text(
              'data',
              style: TextStyle(fontSize: 40),
            )),
      ),
    );
  }
}
