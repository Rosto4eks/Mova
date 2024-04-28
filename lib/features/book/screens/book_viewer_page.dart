import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mova/features/book/providers/book_provider.dart';
import 'package:mova/presentation/components/colors.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class BookViewerPage extends StatefulWidget {
  final int id;
  const BookViewerPage(this.id, {super.key});

  @override
  State<BookViewerPage> createState() => _BookViewerPageState();
}

class _BookViewerPageState extends State<BookViewerPage> {
  Future<List<String>> _getText(context) async {
    final directory = await getApplicationDocumentsDirectory();
    var provider = Provider.of<BookProvider>(context, listen: false);
    var book = provider.getBook(widget.id);
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
    var book = provider.getBook(widget.id);
    var controller = ScrollController(initialScrollOffset: book.position);
    return FutureBuilder(
      future: _getText(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Container(
                color: white,
                alignment: Alignment.center,
                child: const Text(
                  "загрузка",
                  style: TextStyle(
                    color: black,
                    fontWeight: FontWeight.w500,
                    fontSize: 23,
                  ),
                )),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Column(children: [
                Text(book.name),
                LinearProgressIndicator(
                  value: book.chapter.toDouble() /
                      (snapshot.data!.length.toDouble() - 1),
                  color: lightGreen,
                ),
              ]),
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
                        data: snapshot.data![book.chapter],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          book.chapter > 0
                              ? GestureDetector(
                                  onTap: () => setState(() {
                                    book.chapter = 0;
                                    provider.updateBook(book, 0);
                                  }),
                                  child: Container(
                                    child: Icon(
                                      Icons.keyboard_double_arrow_left,
                                      size: 30,
                                    ),
                                  ),
                                )
                              : Container(),
                          book.chapter > 0
                              ? GestureDetector(
                                  onTap: () => setState(() {
                                    book.chapter--;
                                    provider.updateBook(book, 0);
                                  }),
                                  child: Container(
                                    child: Icon(
                                      Icons.keyboard_arrow_left,
                                      size: 30,
                                    ),
                                  ),
                                )
                              : Container(),
                          book.chapter < snapshot.data!.length - 1
                              ? GestureDetector(
                                  onTap: () => setState(() {
                                    book.chapter++;
                                    provider.updateBook(book, 0);
                                  }),
                                  child: Container(
                                    child: Icon(
                                      Icons.keyboard_arrow_right,
                                      size: 30,
                                    ),
                                  ),
                                )
                              : Container(),
                          book.chapter < snapshot.data!.length - 1
                              ? GestureDetector(
                                  onTap: () => setState(() {
                                    book.chapter = snapshot.data!.length - 1;
                                    provider.updateBook(book, 0);
                                  }),
                                  child: Container(
                                    child: Icon(
                                      Icons.keyboard_double_arrow_right,
                                      size: 30,
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
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
