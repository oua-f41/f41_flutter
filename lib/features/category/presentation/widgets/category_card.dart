import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:skeletons/skeletons.dart';

import '../../../../app/app_router.dart';
import '../../domain/models/response/category_details_response.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    this.category,
  });

  final CategoryDetailsResponse? category;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.router.push(GroupsRoute(currentCategory: category));
      },
      borderRadius: BorderRadius.circular(30),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: context.colorScheme.shadow.withOpacity(0.1),
              blurRadius: 5.0,
            ),
          ],
          borderRadius: BorderRadius.circular(30),
          border:
              Border.all(color: context.colorScheme.outline.withOpacity(0.2)),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            _CardImage(category: category),
            _CardTitle(category: category),
          ],
        ),
      ),
    );
  }
}

class _CardImage extends StatelessWidget {
  const _CardImage({
    required this.category,
  });

  final CategoryDetailsResponse? category;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: category?.photoUrl?.isNotNullOrNoEmpty == true
            ? Image.network(
                category?.photoUrl ?? "",
                height: 500,
                fit: BoxFit.cover,
                color: Colors.black.withOpacity(0.7),
                colorBlendMode: BlendMode.darken,
                loadingBuilder: (context, child, loadingProgress) {
                  return loadingProgress == null
                      ? child
                      : const SkeletonAvatar();
                },
              )
            : const SizedBox());
  }
}

class _CardTitle extends StatelessWidget {
  const _CardTitle({
    required this.category,
  });

  final CategoryDetailsResponse? category;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: AutoSizeText(
      category?.name ?? "",
      textAlign: TextAlign.center,
      minFontSize: 13,
      maxFontSize: 20,
      maxLines: 2,
      style: context.textTheme.headlineSmall?.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        backgroundColor: Colors.black,
      ),
    ));
  }
}
