import 'package:bloc/bloc.dart';
import 'package:mo8tarib/app/Screen/dashboard/side_bar_items/about.dart';
import 'package:mo8tarib/app/Screen/dashboard/side_bar_items/connect_us.dart';
import 'package:mo8tarib/app/Screen/dashboard/side_bar_items/home_dash.dart';
import 'package:mo8tarib/app/Screen/dashboard/side_bar_items/my_property.dart';
import 'package:mo8tarib/app/Screen/dashboard/side_bar_items/profile.dart';
import 'package:mo8tarib/app/Screen/dashboard/side_bar_items/reservation.dart';

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

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.DashBoardClickEvent:
        yield HomeDas(onMenuTap);
        break;
      case NavigationEvents.ProfileClickEvent:
        yield Profile(
          onMenuTap,
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
