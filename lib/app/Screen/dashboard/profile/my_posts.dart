import 'package:flutter/material.dart';
import 'package:mo8tarib/app/Screen/dashboard/home/post.dart';
import 'package:mo8tarib/app/Screen/dashboard/profile/post_model.dart';
import 'package:mo8tarib/app/Screen/property/property_model.dart';
import 'package:mo8tarib/app/Screen/sign_in/model/user.dart';
import 'package:mo8tarib/services/data_base.dart';
import 'package:provider/provider.dart';

class MyPosts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);
    final user = Provider.of<User>(context);
    return StreamBuilder<List<PostModel>>(
      stream: database.postsStream(userId: user.uid),
      builder: (context, allPost) {
        if (allPost.hasData) {
          print(allPost.data.length);
          return ListView.separated(
              separatorBuilder: (context, index) => SizedBox(
                    height: 8,
                    child: Container(color: Colors.black12),
                  ),
              padding: EdgeInsets.all(4),
              shrinkWrap: true,
              itemCount: allPost.data.length,
              itemBuilder: (context, index) => StreamBuilder<Property>(
                    stream: database.propertyStream(
                        propertyId: allPost.data[index].flatId),
                    builder: (context, data) {
                      if (data.hasData) {
                        print(data.data);
                        return Post(
                          postModel: allPost.data[index],
                          user: user,
                          property: data.data,
                        );
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
