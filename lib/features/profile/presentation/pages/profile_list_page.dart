import 'package:auto_route/auto_route.dart';
import 'package:connectopia/app/app_router.dart';
import 'package:connectopia/product/di/injection.dart';
import 'package:connectopia/product/widgets/title_text.dart';
import 'package:flutter/material.dart';

import '../../../../product/constants/image_constants.dart';
import '../../../../product/models/core_models/user.dart';

@RoutePage()
class ProfileListPage extends StatelessWidget {
  const ProfileListPage({super.key, required this.users, this.title});

  final List<User?> users;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title ?? "Users"),
        ),
        body: users.isEmpty
            ? const Center(child: TitleText(text: "No User"))
            : ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      getIt
                          .get<AppRouter>()
                          .push(ProfileRoute(user: users[index] ?? User()));
                    },
                    child: ListTile(
                        leading: SizedBox(
                          height: 50,
                          width: 50,
                          child: ClipOval(
                            child: Image.network(
                                users[index]?.profilePhotoUrl ?? "",
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                  ImageConstants.defaultProfilePhoto.imagePath,
                                  fit: BoxFit.cover);
                            }),
                          ),
                        ),
                        title: Text(users[index]?.fullName ?? ""),
                        subtitle: Text("@${users[index]?.userName ?? ""}"),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded)
                        //TODO : Add Follow button
                        /* TextButton(
                        style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            elevation: 0,
                            foregroundColor: Colors.transparent),
                        onPressed: () {},
                        child: Card(
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 27, vertical: 9),
                              child: const Text("Follow")),
                        ),
                      ),*/
                        ),
                  );
                },
              ));
  }
}
