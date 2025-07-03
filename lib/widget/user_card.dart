import 'package:flutter/material.dart';
import 'package:user_app/module/model/user_model.dart';

class UserCard extends StatelessWidget {
  final VoidCallback onTap;
  final UserModel user;
  const UserCard({super.key, required this.user, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(user.photo??""),
        ),
        title: Text("${user.name?.toString()}",),
        subtitle: Text("${user.email}"),
        onTap: onTap,
      ),
    );
  }
}