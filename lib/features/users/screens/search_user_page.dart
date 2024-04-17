import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mova/features/users/domain/service.dart';
import 'package:mova/features/users/providers/user_provider.dart';
import 'package:mova/features/users/screens/user_page.dart';
import 'package:mova/presentation/components/colors.dart';
import 'package:provider/provider.dart';

class SearchUserPage extends StatefulWidget {
  const SearchUserPage({super.key});

  @override
  State<SearchUserPage> createState() => _SearchUserPageState();
}

class _SearchUserPageState extends State<SearchUserPage> {
  var users = List<User>.empty();
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: color4,
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 110, horizontal: 20),
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
            color: white, borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: Material(
                color: Colors.transparent,
                child: TextField(
                  maxLength: 20,
                  onSubmitted: (value) async {
                    var res = users = await provider.getUsersByName(value);
                    setState(() {
                      users = res;
                    });
                  },
                  minLines: 1,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  cursorColor: black,
                  style: const TextStyle(
                    fontSize: 22,
                    color: black,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    fillColor: black,
                    border: const UnderlineInputBorder(),
                    focusedBorder: const UnderlineInputBorder(),
                    enabledBorder: const UnderlineInputBorder(),
                    hintText: "імя",
                    hintStyle: TextStyle(color: black.withOpacity(0.4)),
                    contentPadding: const EdgeInsets.all(10),
                  ),
                ),
              ),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) => GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) =>
                                      UserPage(users[index]))),
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 30),
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  users[index].name,
                                  style: const TextStyle(fontSize: 18),
                                ),
                                Text(
                                  "${users[index].progress} адз.",
                                  style: const TextStyle(fontSize: 18),
                                ),
                                Icon(Icons.search)
                              ],
                            ),
                          ),
                        )))
          ],
        ),
      ),
    );
  }
}
