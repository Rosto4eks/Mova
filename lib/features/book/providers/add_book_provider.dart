import 'dart:io';

import 'package:flutter/material.dart';

class AddBookProvider extends ChangeNotifier {
  File? _epub;
  File? _image;
  String _name = "";
  String _author = "";
  int _price = -1;
  String _filename = "";
  String _imagename = "";
  String _error = "";

  File? get epub => _epub;
  File? get image => _image;
  String get name => _name;
  String get author => _author;
  String get filename => _filename;
  String get imagename => _imagename;
  int get price => _price;
  String get error => _error;

  void clear() {
    _epub = null;
    _image = null;
    _name = "";
    _author = "";
    _price = -1;
    _filename = "";
    _imagename = "";
    _error = "";
  }

  void setError(String error) {
    _error = error;
    notifyListeners();
  }

  void setEpub(File file, String name) {
    _epub = file;
    _filename = name;
    notifyListeners();
  }

  void setImage(File file, String name) {
    _image = file;
    _imagename = name;
    notifyListeners();
  }

  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  void setAuthor(String author) {
    _author = author;
    notifyListeners();
  }

  void setPrice(int? price) {
    if (price == null) {
      _price = 0;
    } else {
      _price = price;
    }
    notifyListeners();
  }

  void refresh() {
    notifyListeners();
  }
}
