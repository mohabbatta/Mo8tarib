import 'package:bloc/bloc.dart';
import 'package:mo8tarib/app/Screen/dashboard/about_us/about_us.dart';
import 'package:mo8tarib/app/Screen/dashboard/connect_us/connect_us.dart';
import 'package:mo8tarib/app/Screen/dashboard/home_layout/home_layout.dart';
import 'package:mo8tarib/app/Screen/dashboard/property/my_property.dart';
import 'package:mo8tarib/app/Screen/dashboard/profile/profile.dart';
import 'package:mo8tarib/app/Screen/dashboard/rservation/reservation.dart';
import 'package:mo8tarib/app/Screen/dashboard/settings/setting_page.dart';

enum NavigationEvents {
  DashBoardClickEvent,
  ProfileClickEvent,
  FlatClickEvent,
  ReservationClickEvent,
  SettingClickEvent,
  AboutClickEvent,
  ConnectUsEvent
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  final Function onMenuTap;

  NavigationBloc(this.onMenuTap) : super(HomeLayout(onMenuTap));

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.DashBoardClickEvent:
        yield HomeLayout(onMenuTap);
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
      case NavigationEvents.SettingClickEvent:
        yield SettingPage(
          onMenuTap: onMenuTap,
        );
        break;
      case NavigationEvents.AboutClickEvent:
        yield AboutUs(
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
