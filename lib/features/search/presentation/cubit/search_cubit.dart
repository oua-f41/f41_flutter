import 'package:connectopia/app/base_cubit.dart';

import '../../../../app/connectopia_app_cubit.dart';
import '../../../../product/di/injection.dart';
import '../../../groups/data/repositories/group_repository.dart';
import 'view_model/search_view_model.dart';

class SearchCubit extends BaseCubit<SearchViewModel> {
  SearchCubit() : super(SearchViewModel());

  late final IGroupRepository _groupRepository;

  Future<void> init() async {
    _groupRepository = getIt.get<IGroupRepository>();
    await getAllGroups();
  }

  void changeSearchKey(String? searchKey) {
    if (searchKey != null && searchKey.isNotEmpty) {
      final searchResult = state.allGroups
          ?.where((element) =>
              element?.name?.toLowerCase().contains(searchKey.toLowerCase()) ??
              false)
          .toList();
      emit(state.copyWith(searchResult: searchResult));
    } else {
      emit(state.copyWith(searchResult: null));
    }
  }

  Future<void> getAllGroups() async {
    getIt.get<ConnectopiaAppCubit>().changeIsLoading();
    final groups = await _groupRepository.getAll();
    emit(state.copyWith(allGroups: groups, searchResult: []));
    getIt.get<ConnectopiaAppCubit>().changeIsLoading();
  }
}
