import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mo8tarib/app/Screen/dashboard/profile/post_model.dart';
import 'package:mo8tarib/app/Screen/property/add_propert_model.dart';
import 'package:mo8tarib/services/data_base.dart';

class GoHomeBloc {
  GoHomeBloc({@required this.database});

  final Database database;
  final StreamController<List<PostModel>> _modelController =
      StreamController<List<PostModel>>();
  Stream<List<PostModel>> get modelStream => _modelController.stream;
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

}
