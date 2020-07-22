import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mo8tarib/localization.dart';

class EditUser extends StatefulWidget {
  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  String name;

  TextEditingController userNameController;
  TextEditingController emailController;
  TextEditingController phoneNameController;
  TextEditingController locationNameController;
  TextEditingController dateOfBirthController;

  @override
  void initState() {
    userNameController = TextEditingController(text: "Mohab");
    emailController = TextEditingController(text: "Mohab@batta.com");
    phoneNameController = TextEditingController(text: "01126177037");
    dateOfBirthController = TextEditingController(text: "12 march");
    locationNameController = TextEditingController(text: "Cairo,Egypt");

    super.initState();
  }

  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    phoneNameController.dispose();
    locationNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            localization.translate("Edit Profile"),
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                size: 30,
                color: Colors.blue,
              ),
              onPressed: null),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Theme(
                data: ThemeData(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
                child: InkWell(
                  onTap: () {
                    print(name);
                  },
                  child: Center(
                    child: Text(
                      localization.translate("Done"),
                      style: TextStyle(color: Colors.blue, fontSize: 20),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('images/avater.png'),
                    radius: 60,
                  ),
                ),
                InkWell(
                  onTap: () {
                    print("object");
                  },
                  child: Text(
                    localization.translate("Change profile photo"),
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                ReusableEditUser(
                  controller: userNameController,
                  textFieldName: localization.translate("Username"),
                  getText: (value) {
                    name = value;
                  },
                ),
                SizedBox(
                  child: Divider(color: Colors.blueAccent),
                ),
                ReusableEditUser(
                    controller: emailController,
                    textFieldName: localization.translate("Email")),
                SizedBox(
                  child: Divider(color: Colors.blueAccent),
                ),
                ReusableEditUser(
                    textFieldName: localization.translate("phone"),
                    controller: phoneNameController),
                SizedBox(
                  child: Divider(color: Colors.blueAccent),
                ),
                ReusableEditUser(
                    textFieldName: localization.translate("Date Of Birth"),
                    controller: dateOfBirthController),
                SizedBox(
                  child: Divider(color: Colors.blueAccent),
                ),
                ReusableEditUser(
                    textFieldName: localization.translate("Location"),
                    controller: locationNameController)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ReusableEditUser extends StatelessWidget {
  ReusableEditUser(
      {@required this.textFieldName, @required this.controller, this.getText});

  final TextEditingController controller;
  final String textFieldName;
  final Function getText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Text(
            textFieldName,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          Flexible(
            child: TextField(
              onEditingComplete: () {
                print(controller);
              },
              controller: controller,
              textAlign: TextAlign.end,
              decoration: InputDecoration(border: InputBorder.none),
              onChanged: getText,
            ),
          )
        ],
      ),
    );
  }
}
