import 'package:flutter/foundation.dart';
import 'package:mo8tarib/app/Screen/sign_in/model/user.dart';
import 'package:mo8tarib/servies/api_path.dart';
import 'package:mo8tarib/servies/firestore_servies.dart';

abstract class Database {
  Future<void> setUser(User user);
}

class FireStoreDatabase implements Database {
  FireStoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;

  final _service = FireStoreService.instance;

  @override
  Future<void> setUser(User user) async => await _service.setData(
        path: APIPath.users(uid),
        data: user.toMap(),
      );
}
