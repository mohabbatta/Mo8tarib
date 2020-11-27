import 'package:flutter/material.dart';
import 'package:mo8tarib/app/Screen/dashboard/home/go_home_bloc.dart';
import 'package:mo8tarib/app/Screen/dashboard/home/go_home_model.dart';
import 'package:mo8tarib/app/Screen/dashboard/home/post.dart';
import 'package:mo8tarib/app/Screen/property/property_model.dart';
import 'package:mo8tarib/app/Screen/sign_in/model/user.dart';
import 'package:mo8tarib/services/data_base.dart';
import 'package:provider/provider.dart';

class GoHome extends StatefulWidget {
  GoHome({this.goHomeBloc, this.database});
  final GoHomeBloc goHomeBloc;
  final Database database;

  static Widget create(BuildContext context) {
    final database = Provider.of<Database>(context);
    return Provider<GoHomeBloc>(
      create: (_) => GoHomeBloc(database: database),
      child: Consumer<GoHomeBloc>(
          builder: (context, goHomeBloc, _) => GoHome(
                goHomeBloc: goHomeBloc,
                database: database,
              )),
      dispose: (context, goHomeBloc) => goHomeBloc.dispose(),
    );
  }

  /// go home bloc مش مستخدم

  @override
  _GoHomeState createState() => _GoHomeState();
}

class _GoHomeState extends State<GoHome> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<GoHomeModel>>(
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
                    stream: widget.database.propertyStream(
                        propertyId: allPost.data[index].propertyReference),
                    builder: (context, data) {
                      if (data.hasData) {
                        print(data.data);
                        return StreamBuilder<User>(
                            stream: widget.database.userStream(
                                userId: allPost.data[index].userReference),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Post(
                                  goHomeModel: allPost.data[index],
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
