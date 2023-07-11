import 'package:auto_route/auto_route.dart';

import '../../../../../core/presentation/base_view_model.dart';
import '../../../../../product/models/core_models/event.dart';

class MainViewModel extends BaseViewModel {
  TabsRouter? tabsRouter;

  MainViewModel({
    super.isLoading,
    this.tabsRouter,
  });

  MainViewModel copyWith({
    bool? isLoading,
    TabsRouter? tabsRouter,
  }) {
    return MainViewModel(
      isLoading: isLoading ?? this.isLoading,
      tabsRouter: tabsRouter ?? this.tabsRouter,
    );
  }

  @override
  List<Object?> get props => [isLoading, tabsRouter];
}
