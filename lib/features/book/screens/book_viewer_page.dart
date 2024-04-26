import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mova/features/book/providers/book_provider.dart';
import 'package:mova/presentation/components/colors.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class BookViewerPage extends StatelessWidget {
  final int id;
  const BookViewerPage(this.id, {super.key});

  Future<String> _getText(context) async {
    final directory = await getApplicationDocumentsDirectory();
    var provider = Provider.of<BookProvider>(context, listen: false);
    var book = provider.getBook(id);
    var text = await provider.getText("${directory.path}/${book.file}");
    return text;
  }

  Future<String> _getAppDirectory() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BookProvider>(context, listen: false);
    var book = provider.getBook(id);
    var controller = ScrollController(initialScrollOffset: book.position);
    return FutureBuilder(
      future: _getText(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(color: black);
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Center(child: Text(book.name)),
            ),
            body: PopScope(
              onPopInvoked: (_) {
                provider.updateBook(book, controller.offset);
              },
              child: SingleChildScrollView(
                controller: controller,
                child: Column(
                  children: [
                    FutureBuilder(
                        future: _getAppDirectory(),
                        builder: (context, snap) {
                          if (snap.connectionState == ConnectionState.waiting) {
                            return const CircularProgressIndicator(
                                color: black);
                          } else {
                            return Image.file(
                                File("${snap.data}/${book.image}"));
                          }
                        }),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                      child: Html(
                        data: snapshot.data,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
