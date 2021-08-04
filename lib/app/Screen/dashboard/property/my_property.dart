import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:mo8tarib/app/Screen/dashboard/property/add_property.dart';
import 'package:mo8tarib/app/Screen/dashboard/property/pending_proprty.dart';
import 'package:mo8tarib/app/bloc/navigation_bloc.dart';
import 'package:mo8tarib/constants/color_constants.dart';

import 'package:mo8tarib/constants/global.dart';
import 'package:mo8tarib/helper/localization.dart';

class MyProperty extends StatefulWidget with NavigationStates {
  final Function onMenuTap;

  const MyProperty({Key key, this.onMenuTap}) : super(key: key);

  @override
  _MyPropertyState createState() => _MyPropertyState();
}

class _MyPropertyState extends State<MyProperty>
    with SingleTickerProviderStateMixin {

  List<Widget> containers = [AddProperty.create(), PendingProperty()];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context).translate("Mo8tarib"),
          style: TextStyle(
            color: ColorConstants.primaryColor,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            size: 30,
            color: ColorConstants.primaryColor,
          ),
          onPressed: widget.onMenuTap,
        ),
        bottom: new TabBar(
          isScrollable: true,
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: new BubbleTabIndicator(
            indicatorHeight: 40,
            indicatorColor: ColorConstants.primaryColor,
            tabBarIndicatorSize: TabBarIndicatorSize.tab,
          ),
          tabs: [
            new Tab(text: AppLocalizations.of(context).translate("Add Property")),
            new Tab(text:AppLocalizations.of(context).translate("My Property")),
          ],
          controller: _tabController,
        ),
      ),
      body: new TabBarView(controller: _tabController, children: containers),
    );
  }
}
