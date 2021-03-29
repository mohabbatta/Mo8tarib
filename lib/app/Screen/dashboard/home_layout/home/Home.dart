import 'package:flutter/material.dart';
import 'package:mo8tarib/app/Screen/dashboard/home_layout/home/home_bloc.dart';
import 'package:mo8tarib/app/Screen/dashboard/home_layout/home/post.dart';
import 'package:mo8tarib/app/Screen/dashboard/profile/post_model.dart';
import 'package:mo8tarib/app/Screen/dashboard/property/property_model.dart';
import 'package:mo8tarib/app/Screen/sign_in/model/user.dart';
import 'package:mo8tarib/services/data_base.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  Home({this.goHomeBloc, this.database});
  final HomeBloc goHomeBloc;
  final Database database;

  static Widget create(BuildContext context) {
    final database = Provider.of<Database>(context);
    return Provider<HomeBloc>(
      create: (_) => HomeBloc(database: database),
      child: Consumer<HomeBloc>(
          builder: (context, goHomeBloc, _) => Home(
                goHomeBloc: goHomeBloc,
                database: database,
              )),
      dispose: (context, goHomeBloc) => goHomeBloc.dispose(),
    );
  }

  /// go home bloc مش مستخدم

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<PostModel>>(
      stream: widget.database.postStream(),
      builder: (context, allPost) {
        if (allPost.hasData) {
          return ListView.separated(
              separatorBuilder: (context, index) => SizedBox(
                    height: 8,
                    child: Container(color: Colors.black12),
                  ),
              padding: EdgeInsets.all(4),
              shrinkWrap: true,
              itemCount: allPost.data.length,
              itemBuilder: (context, index) => StreamBuilder<Property>(
                    stream: widget.database
                        .propertyStream(propertyId: allPost.data[index].flatId),
                    builder: (context, data) {
                      if (data.hasData) {
                        print(data.data);
                        return StreamBuilder<MyUser>(
                            stream: widget.database
                                .userStream(userId: allPost.data[index].userId),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Post(
                                  postModel: allPost.data[index],
                                  user: snapshot.data,
                                  property: data.data,
                                );
                              } else {
                                return CircularProgressIndicator();
                              }
                            });
                      } else {
                        return Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                    },
                  ));
        } else {
          return Center(
            child: Text('no data'),
          );
        }
      },
    );
  }
}
