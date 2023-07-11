import 'package:auto_route/auto_route.dart';
import 'package:connectopia/app/app_router.dart';
import 'package:connectopia/product/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

import '../../../search/presentation/widgets/custom_search_bar.dart';
import '../cubit/category_cubit.dart';
import '../cubit/view_model/category_view_model.dart';
import '../widgets/category_card.dart';

@RoutePage()
class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(context.dynamicHeight(0.1)),
          child: AppBar(
            forceMaterialTransparency: true,
            titleSpacing: 1,
            toolbarHeight: context.dynamicHeight(0.1),
            title: const CustomSearchBar(isButton: true),
          )),
      body: BlocBuilder<CategoryCubit, CategoryViewModel>(
        builder: (context, state) {
          return state.categories != null
              ? SingleChildScrollView(
                  child: Container(
                    padding: context.horizontalPaddingLow,
                    child: Column(
                      children: [
                        const _PageHead(),
                        _SpecialCategory(state),
                        _CategoryGrid(state),
                      ],
                    ),
                  ),
                )
              : const SizedBox();
        },
      ),
    );
  }
}

class _CategoryGrid extends StatelessWidget {
  const _CategoryGrid(this.state);

  final CategoryViewModel state;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 150,
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: state.categories?.length ?? 0,
        itemBuilder: (context, index) {
          return CategoryCard(
            category: state.categoriesWithDetails?[index],
          );
        });
  }
}

class _SpecialCategory extends StatelessWidget {
  const _SpecialCategory(this.state);

  final CategoryViewModel state;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.onlyBottomPaddingNormal,
      height: context.dynamicHeight(0.2),
      child: CategoryCard(
        category: state.categoriesWithDetails?[state.categories!
            .indexWhere((element) => element?.name == "NATURE & ENVIRONMENT")],
      ),
    );
  }
}

class _PageHead extends StatelessWidget {
  const _PageHead();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            padding: context.paddingNormal,
            alignment: Alignment.topLeft,
            child: const TitleText(text: "Categories;")),
        TextButton(
            onPressed: () {
              context.router.push(GroupsRoute());
            },
            child: const Text("See All"))
      ],
    );
  }
}
