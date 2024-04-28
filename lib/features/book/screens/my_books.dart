import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mova/features/book/domain/usecase/service.dart';
import 'package:mova/features/book/providers/book_provider.dart';
import 'package:mova/features/book/screens/book_viewer_page.dart';
import 'package:mova/presentation/components/colors.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class MyBooks extends StatefulWidget {
  const MyBooks({super.key});

  @override
  State<MyBooks> createState() => _MyBooksState();
}

class _MyBooksState extends State<MyBooks> {
  var selectedSort = "сартыроўка";
  var selectedAuthor = "";

  var sorts = {
    "↑ імя": (Book a, Book b) => a.name.compareTo(b.name),
    "↓ імя": (Book a, Book b) => -a.name.compareTo(b.name),
  };

  Future<String> _getAppDirectory() async {
    var folder = await getApplicationDocumentsDirectory();
    return folder.path;
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BookProvider>(context);
    var books = provider.getLocalBooks();
    if (selectedAuthor != "") {
      books =
          books.where((element) => element.author == selectedAuthor).toList();
    }
    if (selectedSort != "сартыроўка") {
      books.sort(sorts[selectedSort]);
    }
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          color: white,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DropdownButton<String>(
                value: selectedSort,
                items: const [
                  DropdownMenuItem(
                      value: "сартыроўка", child: Text("сартыроўка")),
                  DropdownMenuItem(value: "↑ імя", child: Text("↑ імя")),
                  DropdownMenuItem(value: "↓ імя", child: Text("↓ імя")),
                ],
                onChanged: (value) => setState(() {
                  selectedSort = value!;
                }),
              ),
              DropdownButton<String>(
                value: selectedAuthor,
                items: [
                  DropdownMenuItem(
                    value: "",
                    child: Text("аўтар"),
                  ),
                  ...provider.getLocalBooks().map((e) => e.author).toSet().map(
                        (e) => DropdownMenuItem(value: e, child: Text(e)),
                      )
                ],
                onChanged: (value) => setState(() {
                  selectedAuthor = value!;
                }),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) => Container(
                height: index == books.length - 1 ? 600 : 500,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    FutureBuilder(
                      future: _getAppDirectory(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator(color: black);
                        } else {
                          return GestureDetector(
                            onTap: () async {
                              Widget cancelButton = GestureDetector(
                                child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    child: const Text(
                                      "адмяніць",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: black),
                                    )),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              );
                              Widget continueButton = GestureDetector(
                                child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    child: const Text(
                                      "выдаліць",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.red),
                                    )),
                                onTap: () {
                                  provider
                                      .removeLocalBook(books[index])
                                      .then((value) => provider.refresh());
                                  Navigator.pop(context);
                                },
                              ); // set up the AlertDialog
                              AlertDialog alert = AlertDialog(
                                backgroundColor: lightGrey,
                                surfaceTintColor: lightGrey,
                                title: Text("Пацверджанне"),
                                content: Text(
                                    "Выдаліць з прылады кнігу '${books[index].name}'?"),
                                actionsAlignment:
                                    MainAxisAlignment.spaceBetween,
                                actions: [
                                  cancelButton,
                                  continueButton,
                                ],
                              );
                              showCupertinoDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return alert;
                                },
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child:
                                  File("${snapshot.data!}/${books[index].image}")
                                          .existsSync()
                                      ? Image.file(
                                          File(
                                              "${snapshot.data!}/${books[index].image}"),
                                          width: 200,
                                        )
                                      : Container(
                                          width: 200,
                                          height: 300,
                                          color: grey,
                                        ),
                            ),
                          );
                        }
                      },
                    ),
                    Container(
                      width: 300,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        books[index].name,
                        style: const TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(books[index].author),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) {
                              return BookViewerPage(books[index].id);
                            },
                          ),
                        );
                      },
                      child: Container(
                        width: 200,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            color: black,
                            borderRadius: BorderRadius.circular(15)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 20),
                        child: const Text(
                          "чытаць",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
