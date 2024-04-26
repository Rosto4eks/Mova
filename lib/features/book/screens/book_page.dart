import 'package:flutter/material.dart';
import 'package:mova/features/book/screens/book_store.dart';
import 'package:mova/features/book/screens/my_books.dart';
import 'package:mova/presentation/components/colors.dart';

class BookPage extends StatefulWidget {
  const BookPage({super.key});

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  var widgets = [
    const MyBooks(),
    const BookStore(),
  ];
  var selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lightGrey,
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              alignment: Alignment.bottomCenter,
              height: 100,
              color: white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () => setState(() {
                      selectedIndex = 0;
                    }),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 100),
                      decoration: BoxDecoration(
                          border: selectedIndex == 0
                              ? const Border(
                                  bottom: BorderSide(color: black, width: 2),
                                )
                              : null),
                      child: const Text(
                        "мае кнігі",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => setState(() {
                      selectedIndex = 1;
                    }),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 100),
                      decoration: BoxDecoration(
                          border: selectedIndex == 1
                              ? const Border(
                                  bottom: BorderSide(color: black, width: 2),
                                )
                              : null),
                      child: const Text(
                        "крама",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: widgets[selectedIndex]),
          ],
        ));
  }
}
