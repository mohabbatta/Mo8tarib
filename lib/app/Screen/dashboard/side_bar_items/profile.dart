import 'package:flutter/material.dart';
import 'package:mo8tarib/app/Screen/dashboard/profile/my_likes.dart';
import 'package:mo8tarib/app/Screen/dashboard/profile/my_posts.dart';
import 'package:mo8tarib/app/Screen/sign_in/model/user.dart';
import 'package:mo8tarib/app/bloc/navigation_bloc.dart';
import 'package:mo8tarib/app/common_widgets/avatar.dart';
import 'package:mo8tarib/global.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget with NavigationStates {
  final Function onMenuTap;

  const Profile(this.onMenuTap);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  List<Widget> containers = [MyPosts(), MyLikes()];

  final List<Tab> tabs = <Tab>[
    new Tab(text: "Add Property"),
    new Tab(text: "Pending Property"),
  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: tabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                leading: IconButton(
                  icon: Icon(
                    Icons.menu,
                    size: 30,
                    color: foregroundColor,
                  ),
                  onPressed: widget.onMenuTap,
                ),
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                title: Text(user.disPlayName),
                centerTitle: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Avatar(photoUrl: user.photoUrl, radius: 50),
                        Text(user.phone),
                        Text(user.email)
                      ],
                    ),
                  ),
                ),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    controller: _tabController,
                    labelColor: Colors.black87,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(icon: Icon(Icons.list), text: "my posts"),
                      Tab(icon: Icon(Icons.favorite), text: "my favorites"),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body:
              new TabBarView(controller: _tabController, children: containers),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
