import '../../../../../core/presentation/base_view_model.dart';
import '../../../../groups/domain/models/response/group_response.dart';

class SearchViewModel extends BaseViewModel {
  List<GroupResponse?>? allGroups;
  List<GroupResponse?>? searchResult;

  SearchViewModel({this.allGroups, this.searchResult});

  SearchViewModel copyWith(
      {List<GroupResponse?>? allGroups, List<GroupResponse?>? searchResult}) {
    return SearchViewModel(
        allGroups: allGroups ?? this.allGroups,
        searchResult: searchResult ?? this.searchResult);
  }

  @override
  List<Object?> get props => [allGroups, searchResult];
}
