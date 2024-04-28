import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mova/features/book/providers/add_book_provider.dart';
import 'package:mova/features/book/providers/book_provider.dart';
import 'package:mova/presentation/components/colors.dart';
import 'package:provider/provider.dart';

class AddBookPage extends StatelessWidget {
  const AddBookPage({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AddBookProvider>(context);
    var bookProvider = Provider.of<BookProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: color4,
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
            color: white, borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Text(
              provider.error,
              style: const TextStyle(
                color: Color.fromARGB(255, 236, 73, 73),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: Material(
                color: Colors.transparent,
                child: TextField(
                  maxLength: 50,
                  onChanged: (val) {
                    provider.setName(val);
                  },
                  minLines: 1,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  cursorColor: black,
                  style: const TextStyle(
                    fontSize: 22,
                    color: black,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    fillColor: black,
                    border: const UnderlineInputBorder(),
                    focusedBorder: const UnderlineInputBorder(),
                    enabledBorder: const UnderlineInputBorder(),
                    hintText: "імя",
                    hintStyle: TextStyle(color: black.withOpacity(0.4)),
                    contentPadding: const EdgeInsets.all(10),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: Material(
                color: Colors.transparent,
                child: TextField(
                  maxLength: 50,
                  onChanged: (val) {
                    provider.setAuthor(val);
                  },
                  minLines: 1,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  cursorColor: black,
                  style: const TextStyle(
                    fontSize: 22,
                    color: black,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    fillColor: black,
                    border: const UnderlineInputBorder(),
                    focusedBorder: const UnderlineInputBorder(),
                    enabledBorder: const UnderlineInputBorder(),
                    hintText: "аўтар",
                    hintStyle: TextStyle(color: black.withOpacity(0.4)),
                    contentPadding: const EdgeInsets.all(10),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: Material(
                color: Colors.transparent,
                child: TextField(
                  maxLength: 4,
                  onChanged: (val) {
                    provider.setPrice(int.tryParse(val));
                  },
                  minLines: 1,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  cursorColor: black,
                  style: const TextStyle(
                    fontSize: 22,
                    color: black,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    fillColor: black,
                    border: const UnderlineInputBorder(),
                    focusedBorder: const UnderlineInputBorder(),
                    enabledBorder: const UnderlineInputBorder(),
                    hintText: "кошт",
                    hintStyle: TextStyle(color: black.withOpacity(0.4)),
                    contentPadding: const EdgeInsets.all(10),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                var file =
                    await FilePicker.platform.pickFiles(type: FileType.image);
                if (file != null) {
                  provider.setImage(
                      File(file.files[0].path!), file.files[0].name);
                }
              },
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                        color: black, borderRadius: BorderRadius.circular(15)),
                    child: Text(
                      "дадаць малюнак",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: white),
                    ),
                  ),
                  if (provider.imagename.isNotEmpty)
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Icon(
                        Icons.check_circle,
                        color: lightGreen,
                        size: 30,
                      ),
                    )
                ],
              ),
            ),
            GestureDetector(
              onTap: () async {
                var file = await FilePicker.platform.pickFiles(
                    type: FileType.custom, allowedExtensions: ["epub"]);
                if (file != null) {
                  provider.setEpub(
                      File(file.files[0].path!), file.files[0].name);
                }
              },
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                        color: black, borderRadius: BorderRadius.circular(15)),
                    child: Text(
                      "дадаць файл",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: white),
                    ),
                  ),
                  if (provider.filename.isNotEmpty)
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Icon(
                        Icons.check_circle,
                        color: lightGreen,
                        size: 30,
                      ),
                    )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: GestureDetector(
                onTap: () async {
                  var connectivityResult =
                      await Connectivity().checkConnectivity();
                  if (connectivityResult.contains(ConnectivityResult.mobile) ||
                      connectivityResult.contains(ConnectivityResult.wifi)) {
                    showDialog(
                        // ignore: use_build_context_synchronously
                        context: context,
                        builder: (context) => const Center(
                              child: CircularProgressIndicator(
                                color: lightGreen,
                              ),
                            ),
                        barrierDismissible: false);
                    bookProvider
                        .saveBook(
                      provider.name,
                      provider.author,
                      provider.price,
                      provider.epub,
                      provider.filename,
                      provider.image,
                      provider.imagename,
                    )
                        .then(
                      (value) {
                        Navigator.pop(context);
                        if (value == "") {
                          bookProvider.refresh();
                          Navigator.pop(context);
                        } else {
                          provider.setError(value);
                        }
                      },
                    );
                  } else {
                    provider.setError("няма злучэння");
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: black, borderRadius: BorderRadius.circular(15)),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: const Text(
                    "дадаць",
                    style: TextStyle(fontSize: 20, color: white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
