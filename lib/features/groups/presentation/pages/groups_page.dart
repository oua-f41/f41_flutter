import 'package:auto_route/auto_route.dart';
import 'package:connectopia/features/category/domain/models/response/category_details_response.dart';
import 'package:connectopia/features/groups/presentation/cubit/groups_cubit.dart';
import 'package:connectopia/features/groups/presentation/cubit/view_model/groups_view_model.dart';
import 'package:connectopia/features/groups/presentation/widgets/group_grid.dart';
import 'package:connectopia/features/groups/presentation/widgets/group_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

import '../../../category/presentation/cubit/category_cubit.dart';
import '../../../category/presentation/cubit/view_model/category_view_model.dart';
import '../../../search/presentation/widgets/custom_search_bar.dart';

@RoutePage()
class GroupsPage extends StatelessWidget with AutoRouteWrapper {
  const GroupsPage({super.key, this.currentCategory});

  final CategoryDetailsResponse? currentCategory;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                pinned: true,
                floating: true,
                forceMaterialTransparency: true,
                titleSpacing: 1,
                toolbarHeight: context.dynamicHeight(0.1),
                title: const CustomSearchBar(isButton: true),
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(context.dynamicHeight(0.09)),
                  child: Container(
                    color: context.colorScheme.background,
                    child: SizedBox(
                      height: context.dynamicHeight(0.09),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Container(
                              padding: context.paddingLow,
                              alignment: Alignment.centerLeft,
                              child: context
                                          .watch<GroupsCubit>()
                                          .state
                                          .currentCategory
                                          ?.id ==
                                      null
                                  ? ElevatedButton(
                                      onPressed: () {},
                                      child: const Text("All"),
                                    )
                                  : OutlinedButton(
                                      onPressed: () {
                                        context
                                            .read<GroupsCubit>()
                                            .getAllGroups();
                                      },
                                      child: const Text("All"),
                                    ),
                            ),
                            BlocBuilder<CategoryCubit, CategoryViewModel>(
                              builder: (context, state) {
                                return ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      state.categoriesWithDetails?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      padding: context.paddingLow,
                                      alignment: Alignment.centerLeft,
                                      child: context
                                                  .watch<GroupsCubit>()
                                                  .state
                                                  .currentCategory ==
                                              state
                                                  .categoriesWithDetails?[index]
                                          ? ElevatedButton(
                                              onPressed: () {},
                                              child: Text(state
                                                      .categoriesWithDetails?[
                                                          index]
                                                      ?.name ??
                                                  ""),
                                            )
                                          : OutlinedButton(
                                              onPressed: () {
                                                context
                                                    .read<GroupsCubit>()
                                                    .changeCategory(state
                                                            .categoriesWithDetails?[
                                                        index]);
                                              },
                                              child: Text(state
                                                      .categoriesWithDetails?[
                                                          index]
                                                      ?.name ??
                                                  ""),
                                            ),
                                    );
                                  },
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: Container(
            padding: context.paddingLow,
            child: BlocBuilder<GroupsCubit, GroupsViewModel>(
              builder: (context, state) {
                return state.isLoading
                    ? const GroupLoading()
                    : GroupGrid(groups: state.groups);
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GroupsCubit()..init(currentCategory: currentCategory),
      child: this,
    );
  }
}
