import 'package:hive/hive.dart';
import 'package:mova/features/book/domain/usecase/service.dart';

part 'dto.g.dart';

@HiveType(typeId: 4)
class BookDTO extends HiveObject {
  @HiveField(0)
  late int id;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late String author;

  @HiveField(3)
  late String file;

  @HiveField(4)
  late String image;

  @HiveField(5)
  late int price;

  @HiveField(6)
  late double position;

  @HiveField(7)
  late int chapter;

  BookDTO() {
    id = -1;
    name = "";
    author = "";
    file = "";
    image = "";
    price = 0;
  }

  BookDTO.fromBook(Book book) {
    id = book.id;
    name = book.name;
    author = book.author;
    file = book.file;
    image = book.image;
    price = book.price;
    position = book.position;
    chapter = book.chapter;
  }

  Book toBook() {
    return Book(id, name, author, file, image, price, position, chapter);
  }
}
