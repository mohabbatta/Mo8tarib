import 'dart:async';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:mo8tarib/app/Screen/property/add_propert_model.dart';
import 'package:mo8tarib/app/Screen/property/property_model.dart';
import 'package:mo8tarib/app/Screen/sign_in/model/user.dart';
import 'package:mo8tarib/services/data_base.dart';
import 'package:rxdart/rxdart.dart';

import 'go_home_model.dart';

class GoHomeBloc {
  GoHomeBloc({@required this.database});

  final Database database;
  final StreamController<List<GoHomeModel>> _modelController =
      StreamController<List<GoHomeModel>>();
  Stream<List<GoHomeModel>> get modelStream => _modelController.stream;
  AddPropertyModel _model = AddPropertyModel();

  void dispose() {
    _modelController.close();
  }

//  Stream<EntryPost> getData(String pid, String uid) {
//    Stream stream1 = database.propertyStream(propertyId: pid);
//    Stream stream2 = database.userStream(userId: uid);
//    return StreamZip([stream1, stream2]);
//  }

//  /// combine List<Job>, List<Entry> into List<EntryJob>
//  Stream<List<EntryPost>> get allEntriesStream => Observable.combineLatest2(
//        database.propertiesStream(),
//        database.usersStream(),
//        _entriesJobsCombiner,
//      );
//
//  Stream<C> createCs(Stream<A> as, Stream<B> bs) =>
//      new StreamZip([as, bs]).map((ab) => new C(ab[0], ab[1]))
  //allPost.data[index].propertyReference
  // allPost.data[index].userReference
//  Stream<EntryPost> getEntrey(String pid, String uid) {
//    database.propertyStream(propertyId: pid);
//    database.userStream(userId: uid);
//  }

  static List<EntryPost> _entriesJobsCombiner(
      List<Property> properties, List<User> users) {
    return properties.map((property) {
      final user = users.firstWhere((user) => user.uid == property.uid);
      return EntryPost(property, user);
    }).toList();
  }
}
