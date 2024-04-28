import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mova/features/book/domain/repository/dto.dart';
import 'package:mova/features/book/domain/usecase/service.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class BookRepository {
  final storage = FirebaseStorage.instance.ref();
  final db = FirebaseFirestore.instance;
  Box<BookDTO>? bookBox;

  Future<BookRepository> init() async {
    bookBox = await Hive.openBox<BookDTO>("books");
    return this;
  }

  Future<List<Book>> getBooks() async {
    var data = await db.collection("books").get();
    return data.docs.map((doc) => Book.fromJson(doc.data())).toList();
  }

  List<Book> getLocalBooks() {
    return bookBox!.values.map((e) => e.toBook()).toList();
  }

  Future saveBook(Book book, File file, File image) async {
    var item = storage.child(book.file);
    await item.putFile(file);

    item = storage.child(book.image);
    await item.putFile(image);

    db.collection("books").doc("${book.id}").set(book.toJson());
  }

  Future removeLocalBook(Book book) async {
    final appDir = await getApplicationDocumentsDirectory();
    await File("${appDir.path}/${book.file}").delete();
    await File("${appDir.path}/${book.image}").delete();
    await bookBox!.delete(book.id);
  }

  Future removeBook(Book book) async {
    await db.collection("books").doc("${book.id}").delete();
    await storage.child(book.file).delete();
    await storage.child(book.image).delete();
  }

  Future<int> getNewId() async {
    var id = -1;
    await db
        .collection("books")
        .orderBy("id", descending: true)
        .limit(1)
        .get()
        .then((value) => id = value.docs[0].data()["id"]);
    return id + 1;
  }

  Future updateBook(Book book) async {
    bookBox!.put(book.id, BookDTO.fromBook(book));
  }

  Future loadBook(int id) async {
    if (bookBox!.containsKey(id)) return;
    late Book book;
    await db
        .collection("books")
        .doc("$id")
        .get()
        .then((value) => book = Book.fromJson(value.data()!));

    final appDir = await getApplicationDocumentsDirectory();

    var item = storage.child(book.file);
    var url = await item.getDownloadURL();
    var response = await http.get(Uri.parse(url));
    var file = File('${appDir.path}/${book.file}');
    await file.writeAsBytes(response.bodyBytes);

    item = storage.child(book.image);
    url = await item.getDownloadURL();
    response = await http.get(Uri.parse(url));
    file = File('${appDir.path}/${book.image}');
    await file.writeAsBytes(response.bodyBytes);

    bookBox!.put(book.id, BookDTO.fromBook(book));
  }

  Future<String> getImageRef(String image) async {
    return await storage.child(image).getDownloadURL();
  }

  Book getBook(int id) {
    return bookBox!.get(id)!.toBook();
  }
}
