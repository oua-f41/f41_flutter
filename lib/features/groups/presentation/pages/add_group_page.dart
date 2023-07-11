import 'package:auto_route/auto_route.dart';
import 'package:connectopia/features/category/presentation/cubit/category_cubit.dart';
import 'package:connectopia/features/category/presentation/cubit/view_model/category_view_model.dart';
import 'package:connectopia/features/groups/presentation/cubit/add_group_cubit.dart';
import 'package:connectopia/features/groups/presentation/cubit/view_model/add_group_view_model.dart';
import 'package:connectopia/product/constants/image_constants.dart';
import 'package:connectopia/product/widgets/dropdown_form_field.dart';
import 'package:connectopia/product/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

@RoutePage()
class AddGroupPage extends StatelessWidget with AutoRouteWrapper {
  const AddGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
      ),
      body: SingleChildScrollView(
        child: Container(
            alignment: Alignment.center,
            padding: context.horizontalPaddingNormal,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  padding: context.paddingMedium,
                  child: AnimatedContainer(
                    duration: context.durationLow,
                    height:
                        context.isKeyBoardOpen ? 0 : context.dynamicHeight(0.2),
                    child: Image.asset(
                      ImageConstants.logo.imagePath,
                    ),
                  ),
                ),
                BlocBuilder<AddGroupCubit, AddGroupViewModel>(
                  builder: (context, state) {
                    return Form(
                      key: state.formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              padding: context.verticalPaddingLow,
                              alignment: Alignment.centerLeft,
                              child: const TitleText(text: "Add Group ;")),
                          Container(
                            padding: context.verticalPaddingLow,
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter group name';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                context
                                    .read<AddGroupCubit>()
                                    .setGroupName(value);
                              },
                              decoration: const InputDecoration(
                                label: Text("Group Name"),
                              ),
                            ),
                          ),
                          Container(
                            padding: context.verticalPaddingLow,
                            child: TextFormField(
                              minLines: 2,
                              maxLines: 8,
                              maxLength: 1000,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter group description';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                context
                                    .read<AddGroupCubit>()
                                    .setGroupDescription(value);
                              },
                              decoration: InputDecoration(
                                  counterText: state.groupRequest.description
                                              .isNotNullOrNoEmpty ==
                                          true
                                      ? "${state.groupRequest.description?.length}/${1000}"
                                      : "",
                                  label: const Text("Group Description"),
                                  alignLabelWithHint: true),
                            ),
                          ),
                          Container(
                            padding: context.verticalPaddingLow,
                            child: DropdownFormField(
                                onTap: () async {
                                  final category = await showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return BlocBuilder<CategoryCubit,
                                          CategoryViewModel>(
                                        builder: (context, state) {
                                          return ListView.builder(
                                            itemCount: state.categories?.length,
                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                title: Text(state
                                                        .categories?[index]
                                                        ?.name ??
                                                    ""),
                                                onTap: () {
                                                  context.pop(
                                                      state.categories?[index]);
                                                },
                                              );
                                            },
                                          );
                                        },
                                      );
                                    },
                                  );
                                  if (category != null) {
                                    context
                                        .read<AddGroupCubit>()
                                        .setGroupCategoryId(category);
                                  }
                                },
                                label: state.selectedCategory?.name ??
                                    "Select Category"),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool isSuccess = await context.read<AddGroupCubit>().addGroup();
          if (isSuccess) {
            context.router.pop(true);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
        create: (context) => AddGroupCubit()..init(), child: this);
  }
}
