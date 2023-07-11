import 'package:auto_route/auto_route.dart';
import 'package:connectopia/app/app_router.dart';
import 'package:connectopia/features/search/presentation/cubit/search_cubit.dart';
import 'package:connectopia/features/search/presentation/cubit/view_model/search_view_model.dart';
import 'package:connectopia/product/constants/image_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

import '../../../../product/models/core_models/group.dart';
import '../widgets/custom_search_bar.dart';

@RoutePage()
class SearchPage extends StatelessWidget with AutoRouteWrapper {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(context.dynamicHeight(0.1)),
          child: AppBar(
            automaticallyImplyLeading: false,
            forceMaterialTransparency: true,
            titleSpacing: 1,
            toolbarHeight: context.dynamicHeight(0.1),
            title: const CustomSearchBar(isButton: false),
            actions: [
              TextButton(
                  onPressed: () {
                    context.router.pop();
                  },
                  child: const Text("Cancel"))
            ],
          )),
      body: BlocBuilder<SearchCubit, SearchViewModel>(
        builder: (context, state) {
          return Container(
              child: ListView.builder(
            itemCount: state.searchResult?.length ?? 0,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Group group = Group(
                      id: state.searchResult?[index]?.id,
                      categoryId: state.searchResult?[index]?.categoryId,
                      createdAt: state.searchResult?[index]?.createdAt,
                      description: state.searchResult?[index]?.description,
                      userId: state.searchResult?[index]?.userId,
                      iconUrl: state.searchResult?[index]?.iconUrl,
                      name: state.searchResult?[index]?.name,
                      category: state.searchResult?[index]?.category,
                      owner: state.searchResult?[index]?.owner);
                  context.router.push(GroupDetailRoute(group: group));
                },
                child: ListTile(
                  leading: Hero(
                      tag:
                          "${state.searchResult?[index]?.iconUrl}${state.searchResult?[index]?.id}",
                      child: state.searchResult?[index]?.iconUrl
                                  .isNotNullOrNoEmpty ==
                              true
                          ? ClipOval(
                              child: Image.network(
                              state.searchResult?[index]?.iconUrl ?? "",
                              width: 35,
                              height: 35,
                              fit: BoxFit.cover,
                            ))
                          : ClipOval(
                              child: Image.asset(
                              ImageConstants.defaultGroupPhoto.imagePath,
                              width: 35,
                              height: 35,
                              fit: BoxFit.cover,
                            ))),
                  title: Text("${state.searchResult?[index]?.name}"),
                ),
              );
            },
          ));
        },
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit()..init(),
      child: this,
    );
  }
}
