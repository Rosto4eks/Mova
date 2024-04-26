import 'dart:io';

import 'package:mova/features/book/domain/repository/repository.dart';
import 'package:mova/features/service.dart';

class Book {
  late final int id;
  late String name;
  late String author;
  late String file;
  late String image;
  late int price;
  late double position;

  Book(this.id, this.name, this.author, this.file, this.image, this.price,
      this.position);

  Book.fromJson(Map<String, dynamic> data) {
    id = data["id"] as int;
    name = data["name"];
    author = data["author"];
    file = data["file"];
    image = data["image"];
    price = data["price"] as int;
    position = 0;
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

  BookService(this._repository);

  Future<List<Book>> getBooks() {
    return _repository.getBooks();
  }

  List<Book> getLocalBooks() {
    return _repository.getLocalBooks();
  }

  Future saveBook(File file) async {
    await _repository.saveBook(file);
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

  Book getBook(int id) {
    return _repository.getBook(id);
  }
}
