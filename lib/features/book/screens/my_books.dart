import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mova/features/book/providers/book_provider.dart';
import 'package:mova/features/book/screens/book_viewer_page.dart';
import 'package:mova/presentation/components/colors.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class MyBooks extends StatelessWidget {
  const MyBooks({super.key});

  Future<String> _getAppDirectory() async {
    var folder = await getApplicationDocumentsDirectory();
    return folder.path;
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BookProvider>(context);
    var books = provider.getLocalBooks();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.only(bottom: 100),
      child: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) => Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              FutureBuilder(
                future: _getAppDirectory(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(color: black);
                  } else {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        File("${snapshot.data!}/${books[index].image}"),
                        width: 200,
                      ),
                    );
                  }
                },
              ),
              Container(
                width: 300,
                margin: const EdgeInsets.symmetric(vertical: 15),
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
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                      color: black, borderRadius: BorderRadius.circular(15)),
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
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
    );
  }
}
