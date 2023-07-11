import 'package:auto_route/auto_route.dart';
import 'package:connectopia/features/category/domain/models/response/category_response.dart';
import 'package:connectopia/features/groups/presentation/cubit/edit_group_cubit.dart';
import 'package:connectopia/features/groups/presentation/cubit/view_model/edit_group_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

import '../../../../product/constants/image_constants.dart';
import '../../../../product/models/core_models/category.dart';
import '../../../../product/widgets/dropdown_form_field.dart';
import '../../../../product/widgets/title_text.dart';
import '../../../category/presentation/cubit/category_cubit.dart';
import '../../../category/presentation/cubit/view_model/category_view_model.dart';
import '../../domain/models/response/group_response.dart';

@RoutePage()
class EditGroupPage extends StatelessWidget with AutoRouteWrapper {
  const EditGroupPage(
      {super.key, required this.updateGroupRequest, required this.category});

  final GroupResponse updateGroupRequest;
  final Category category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Edit Group"),
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
                      height: context.isKeyBoardOpen
                          ? 0
                          : context.dynamicHeight(0.2),
                      child: Image.asset(
                        ImageConstants.logo.imagePath,
                      ),
                    ),
                  ),
                  BlocBuilder<EditGroupCubit, EditGroupViewModel>(
                    bloc: context.read<EditGroupCubit>(),
                    builder: (context, state) {
                      return Form(
                        key: state.formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                                padding: context.verticalPaddingLow,
                                alignment: Alignment.centerLeft,
                                child: const TitleText(text: "Edit Group ;")),
                            Container(
                              padding: context.verticalPaddingLow,
                              child: TextFormField(
                                initialValue: state.updateGroupRequest?.name,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter group name';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  context
                                      .read<EditGroupCubit>()
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
                                initialValue:
                                    state.updateGroupRequest?.description,
                                minLines: 2,
                                maxLines: 8,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter group description';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  context
                                      .read<EditGroupCubit>()
                                      .setGroupDescription(value);
                                },
                                decoration: const InputDecoration(
                                    label: Text("Group Description"),
                                    alignLabelWithHint: true),
                              ),
                            ),
                            Container(
                              padding: context.verticalPaddingLow,
                              child: DropdownFormField(
                                  onTap: () async {
                                    final response = await showModalBottomSheet<
                                        CategoryResponse>(
                                      context: context,
                                      builder: (context) {
                                        return BlocBuilder<CategoryCubit,
                                            CategoryViewModel>(
                                          builder: (context, state) {
                                            return ListView.builder(
                                              itemCount:
                                                  state.categories?.length,
                                              itemBuilder: (context, index) {
                                                return ListTile(
                                                  title: Text(state
                                                          .categories?[index]
                                                          ?.name ??
                                                      ""),
                                                  onTap: () {
                                                    context.pop(state
                                                        .categories![index]);
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        );
                                      },
                                    );
                                    if (response != null) {
                                      context
                                          .read<EditGroupCubit>()
                                          .setGroupCategoryId(response);
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
            bool isSuccess = await context.read<EditGroupCubit>().updateGroup();
            if (isSuccess) {
              context.router.pop(true);
            }
          },
          child: const Icon(Icons.done),
        ));
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => EditGroupCubit()
        ..init(request: updateGroupRequest, category: category),
      child: this,
    );
  }
}
