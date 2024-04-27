import 'dart:io';

import 'package:epub_kit/epub_kit.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mova/features/book/domain/usecase/service.dart';

class BookProvider extends ChangeNotifier {
  final BookService _service;

  BookProvider(this._service);

  Future<List<Book>> getBooks() async {
    return _service.getBooks();
  }

  List<Book> getLocalBooks() {
    return _service.getLocalBooks();
  }

  Future saveBook(FilePickerResult res) async {
    await _service.saveBook(File(res.files.single.path!));
  }

  Future loadBook(int id) async {
    await _service.loadBook(id);
  }

  void updateBook(Book book, double position) {
    book.position = position;
    _service.updateBook(book);
  }

  void purchaseBook(Book book) {
    _service.purchaseBook(book);
  }

  Book getBook(int id) {
    return _service.getBook(id);
  }

  Future<List<String>> getText(String path) async {
    List<int> bytes = await File(path).readAsBytes();
    EpubBookRef epubBook = await EpubReader.openBook(bytes);
    var cont = await EpubReader.readTextContentFiles(epubBook.content!.html!);
    List<String> htmlList = [];
    for (var value in cont.values) {
      htmlList.add(value.content!);
    }
    return htmlList;
  }

  Future<String> getImageRef(String image) async {
    return await _service.getImageRef(image);
  }

  void refresh() {
    notifyListeners();
  }
}
