import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:connectopia/product/constants/image_constants.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../../../app/app_router.dart';
import '../../../../app/connectopia_app_cubit.dart';
import '../../../../product/di/injection.dart';
import '../../../../product/models/core_models/group.dart';

class GroupCard extends StatelessWidget {
  const GroupCard({
    super.key,
    required this.group,
  });

  final Group? group;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.dynamicWidth(0.5), //card boyutu
      height: context.dynamicHeight(0.3),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          foregroundColor: Colors.transparent,
        ),
        onPressed: () {
          if (group?.id != null) {
            context.router.push(GroupDetailRoute(group: group));
          }
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
          shadowColor: context.colorScheme.outlineVariant,
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    flex: 1, //üstteki resimli bölgenin kapladığı alan
                    child: SizedBox(
                      width: context.dynamicWidth(0.5),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(15)),
                        child: Hero(
                          tag: "${group?.category?.photoUrl}${group?.id}",
                          child: group?.category?.photoUrl
                                      ?.isNotNullOrNoEmpty ==
                                  true
                              ? Image.network(
                                  group?.category?.photoUrl ?? '',
                                  fit: BoxFit.cover,
                                  color: Colors.black.withOpacity(0.4),
                                  colorBlendMode: BlendMode.darken,
                                )
                              : Image.asset(
                                  ImageConstants.defaultProfilePhoto.imagePath),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      width: context.dynamicWidth(0.5),
                      decoration: BoxDecoration(
                        color: getIt
                                    .get<ConnectopiaAppCubit>()
                                    .state
                                    .themeMode ==
                                ThemeMode.light
                            ? context.randomColor.shade100
                            : context.randomColor
                                .shade900 /* context.colorScheme.primaryContainer */,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                      child: Padding(
                        padding: context.onlyTopPaddingMedium,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: context.dynamicHeight(0.05),
                              padding: context.horizontalPaddingNormal,
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  group?.name ?? '',
                                  textAlign: TextAlign.center,
                                  style: context.textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textScaleFactor: 50,
                                ),
                              ),
                            ),
                            Container(
                              padding: context.horizontalPaddingLow,
                              child: AutoSizeText(
                                group?.description ?? '',
                                style: context.textTheme.headlineMedium
                                    ?.copyWith(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500),
                                textAlign: TextAlign.start,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                child: Container(
                  margin: context.onlyBottomPaddingHigh,
                  width: 60,
                  height: 60,
                  child: Hero(
                    transitionOnUserGestures: true,
                    createRectTween: (begin, end) {
                      return MaterialRectCenterArcTween(
                        begin: begin,
                        end: end,
                      );
                    },
                    tag: "${group?.iconUrl}${group?.id}",
                    child: ClipOval(
                      child: group?.iconUrl?.isNotEmpty == true
                          ? Image.network(
                              group?.iconUrl ?? "",
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              ImageConstants.defaultGroupPhoto.imagePath,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
