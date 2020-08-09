import 'package:bloc/bloc.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mo8tarib/Screen/dashboard/about.dart';
import 'package:mo8tarib/Screen/dashboard/connect_us.dart';
import 'package:mo8tarib/Screen/dashboard/my_property.dart';
import 'package:mo8tarib/Screen/dashboard/home1.dart';
import 'package:mo8tarib/Screen/dashboard/home_board.dart';
import 'package:mo8tarib/Screen/dashboard/profile.dart';
import 'package:mo8tarib/Screen/dashboard/reservation.dart';

enum NavigationEvents {
  DashBoardClickEvent,
  ProfileClickEvent,
  FlatClickEvent,
  ReservationClickEvent,
  AboutClickEvent,
  ConnectUsEvent
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  final Function onMenuTap;

  NavigationBloc(this.onMenuTap) : super(HomeDas(onMenuTap));

//  @override
//  NavigationStates get initialState => HomeDas(
//        onMenuTap: onMenuTap,
//      );

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.DashBoardClickEvent:
        yield HomeDas(onMenuTap);
        break;
      case NavigationEvents.ProfileClickEvent:
        yield Profile(
           onMenuTap
        );
        break;
      case NavigationEvents.FlatClickEvent:
        yield MyProperty(
          onMenuTap: onMenuTap,
        );
        break;
      case NavigationEvents.ReservationClickEvent:
        yield Reservation(
          onMenuTap: onMenuTap,
        );
        break;
      case NavigationEvents.AboutClickEvent:
        yield About(
          onMenuTap: onMenuTap,
        );
        break;
      case NavigationEvents.ConnectUsEvent:
        yield ConnectUs(
          onMenuTap: onMenuTap,
        );
        break;
    }
  }
}
