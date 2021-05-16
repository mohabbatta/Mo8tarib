import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo8tarib/app/Screen/sign_in/edit_user.dart';
import 'package:mo8tarib/app/Screen/sign_in/model/user.dart';
import 'package:mo8tarib/app/bloc/navigation_bloc.dart';
import 'package:mo8tarib/app/common_widgets/avatar.dart';
import 'package:mo8tarib/app/common_widgets/menu_item.dart';
import 'package:mo8tarib/app/common_widgets/platform_alert_dialog.dart';
import 'package:mo8tarib/constants/global.dart';
import 'package:mo8tarib/helper/localization.dart';
import 'package:mo8tarib/services/auth.dart';
import 'package:provider/provider.dart';

class Menu extends StatefulWidget {
  final Animation<double> menuScaleAnimation;
  final Animation<Offset> slideAnimation;
  final int selectedIndex;
  final Function onMenuItemClicked;
  final MyUser user;

  Menu(
    this.menuScaleAnimation,
    this.slideAnimation,
    this.selectedIndex,
    this.onMenuItemClicked,
    this.user,
  );

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  Future<void> _signOut(BuildContext context) async {
    try {
      final authBase = Provider.of<AuthBase>(context, listen: false);
      await authBase.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await PlatformAlertDialog(
      title: 'LogOut',
      content: 'Are You Sure That you want to Logout',
      defaultActionText: 'LogOut',
      cancelActionText: 'Cancel',
    ).show(context);
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: widget.slideAnimation,
      child: ScaleTransition(
        scale: widget.menuScaleAnimation,
        child: Container(
          color: Colors.white12,
          child: Padding(
            padding: const EdgeInsets.only(right: 16.0,left: 16.0),
            child: Align(
              // alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 15, left: 15),
                        child: Column(
                          children: <Widget>[
                            Avatar(
                                photoUrl: widget.user?.photoUrl, radius: 55.0),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              widget.user?.disPlayName ?? "name",
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 20,
                                fontFamily: "VarelaRound",
                                fontWeight: FontWeight.normal,
                                color: foregroundColor,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => EditUser()),
                                );
                              },
                              child: Text(
                                AppLocalizations.of(context).translate("Edit Profile"),
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  fontSize: 16,
                                  fontFamily: "VarelaRound",
                                  fontWeight: FontWeight.normal,
                                  color: foregroundColor,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      MenuItem(
                        itemName: AppLocalizations.of(context).translate('Home'),
                        function: () {
                          BlocProvider.of<NavigationBloc>(context)
                              .add(NavigationEvents.DashBoardClickEvent);
                          widget.onMenuItemClicked();
                        },
                        fontWeight: widget.selectedIndex == 0
                            ? FontWeight.w900
                            : FontWeight.normal,
                        icon: Icons.home,
                      ),
                      SizedBox(height: 10),
                      MenuItem(
                        itemName: AppLocalizations.of(context).translate("Profile"),
                        function: () {
                          BlocProvider.of<NavigationBloc>(context)
                              .add(NavigationEvents.ProfileClickEvent);
                          widget.onMenuItemClicked();
                        },
                        fontWeight: widget.selectedIndex == 1
                            ? FontWeight.w900
                            : FontWeight.normal,
                        icon: Icons.person,
                      ),
                      SizedBox(height: 10),
                      MenuItem(
                        itemName: AppLocalizations.of(context).translate("My Property"),
                        function: () {
                          BlocProvider.of<NavigationBloc>(context)
                              .add(NavigationEvents.FlatClickEvent);
                          widget.onMenuItemClicked();
                        },
                        fontWeight: widget.selectedIndex == 2
                            ? FontWeight.w900
                            : FontWeight.normal,
                        icon: Icons.room,
                      ),
                      SizedBox(height: 10),
                      MenuItem(
                        itemName: AppLocalizations.of(context).translate("Reservation"),
                        function: () {
                          BlocProvider.of<NavigationBloc>(context)
                              .add(NavigationEvents.ReservationClickEvent);
                          widget.onMenuItemClicked();
                        },
                        fontWeight: widget.selectedIndex == 3
                            ? FontWeight.w900
                            : FontWeight.normal,
                        icon: Icons.phone_in_talk,
                      ),
                      SizedBox(height: 10),
                      MenuItem(
                        itemName: AppLocalizations.of(context).translate("Settings"),
                        function: () {
                          BlocProvider.of<NavigationBloc>(context)
                              .add(NavigationEvents.SettingClickEvent);
                          widget.onMenuItemClicked();
                        },
                        fontWeight: widget.selectedIndex == 4
                            ? FontWeight.w900
                            : FontWeight.normal,
                        icon: Icons.settings,
                      ),
                      SizedBox(height: 10),
                      MenuItem(
                        itemName: AppLocalizations.of(context).translate("about"),
                        function: () {
                          BlocProvider.of<NavigationBloc>(context)
                              .add(NavigationEvents.AboutClickEvent);
                          widget.onMenuItemClicked();
                        },
                        fontWeight: widget.selectedIndex == 5
                            ? FontWeight.w900
                            : FontWeight.normal,
                        icon: Icons.help,
                      ),
                      SizedBox(height: 10),
                      MenuItem(
                        itemName: AppLocalizations.of(context).translate("connect us"),
                        function: () {
                          BlocProvider.of<NavigationBloc>(context)
                              .add(NavigationEvents.ConnectUsEvent);
                          widget.onMenuItemClicked();
                        },
                        fontWeight: widget.selectedIndex == 6
                            ? FontWeight.w900
                            : FontWeight.normal,
                        icon: Icons.contact_mail,
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: MenuItem(
                      itemName: AppLocalizations.of(context).translate("Logout"),
                      icon: Icons.power_settings_new,
                      function: () {
                        _confirmSignOut(context);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
