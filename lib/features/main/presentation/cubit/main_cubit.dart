import 'package:auto_route/auto_route.dart';
import 'package:connectopia/app/app_router.dart';
import 'package:connectopia/app/base_cubit.dart';
import 'package:connectopia/features/main/presentation/cubit/view_model/main_view_model.dart';
import 'package:connectopia/features/main/presentation/cubit/view_model/route_enums.dart';
import 'package:connectopia/product/di/injection.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainCubit extends BaseCubit<MainViewModel> {
  MainCubit() : super(MainViewModel());

  void setTabsRouter(TabsRouter tabsRouter) {
    if (tabsRouter.activeIndex == RouteEnums.profile.index) {
      if (FirebaseAuth.instance.currentUser == null) {
        getIt.get<AppRouter>().replace(const MainLoginRoute());
        return;
      }
    }
    emit(state.copyWith(tabsRouter: tabsRouter));
  }

  void navigateToMaps() {
    state.tabsRouter?.setActiveIndex(RouteEnums.maps.index);
  }

  void navigateHome() {
    state.tabsRouter?.setActiveIndex(RouteEnums.home.index);
  }

  void navigateToDiscover() {
    state.tabsRouter?.setActiveIndex(RouteEnums.discover.index);
  }

  void navigateToProfile() {
    state.tabsRouter?.setActiveIndex(RouteEnums.profile.index);
  }
}
