import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mova/features/book/domain/repository/repository.dart';
import 'package:mova/features/service.dart';
import 'package:mova/features/users/domain/service.dart';
import 'package:mova/presentation/components/colors.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:path_provider/path_provider.dart';

class Book {
  late final int id;
  late String name;
  late String author;
  late String file;
  late String image;
  late int price;
  late double position;
  late int chapter;

  Book(this.id, this.name, this.author, this.file, this.image, this.price,
      this.position, this.chapter);

  Book.fromJson(Map<String, dynamic> data) {
    id = data["id"] as int;
    name = data["name"];
    author = data["author"];
    file = data["file"];
    image = data["image"];
    price = data["price"] as int;
    position = 0;
    chapter = 0;
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "author": author,
      "file": file,
      "image": image,
      "price": price
    };
  }
}

class BookService extends Service {
  final BookRepository _repository;
  final UserRepository _userRepository;

  BookService(this._repository, this._userRepository);

  Future<List<Book>> getBooks() {
    return _repository.getBooks();
  }

  void purchaseBook(Book book) {
    if (Service.user.gems < book.price) {
      showAchievement("не хапае крышталаў");
      return;
    }
    Service.user.addGems(-book.price);
    Service.user.books.add(book.id);
    _userRepository.localSaveUser(Service.user);
    _userRepository.saveUser(Service.user);
  }

  List<Book> getLocalBooks() {
    List<Book> books = [];
    for (var bookId in Service.user.books) {
      for (var deviceBook in _repository.getLocalBooks()) {
        if (deviceBook.id == bookId) {
          books.add(deviceBook);
          break;
        }
      }
    }
    return books;
  }

  Future removeLocalBook(Book book) async {
    await _repository.removeLocalBook(book);
  }

  Future removeBook(Book book) async {
    if (Service.user.role != "admin") return;
    await _repository.removeBook(book);
  }

  Future saveBook(String name, String author, int price, File file,
      String fileName, File image, String imageName) async {
    var id = await _repository.getNewId();
    var book = Book(id, name, author, fileName, imageName, price, 0, 0);
    await _repository.saveBook(book, file, image);
  }

  void updateBook(Book book) {
    _repository.updateBook(book);
  }

  Future loadBook(int id) async {
    await _repository.loadBook(id);
  }

  Future<String> getImageRef(String image) async {
    return await _repository.getImageRef(image);
  }

  Future isExist(Book book) async {
    var dir = await getApplicationDocumentsDirectory();
    return File("$dir/${book.file}").existsSync() &&
        File("$dir/${book.image}").existsSync();
  }

  Book getBook(int id) {
    return _repository.getBook(id);
  }

  void showAchievement(String text) {
    showOverlayNotification((context) {
      return Card(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: const TextStyle(fontSize: 18, color: black),
              ),
              const Icon(
                Icons.error,
                color: lightRed,
              )
            ],
          ),
        ),
      );
    }, duration: const Duration(seconds: 2));
  }
}
