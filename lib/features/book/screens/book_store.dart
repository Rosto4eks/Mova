import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mova/features/book/domain/usecase/service.dart';
import 'package:mova/features/book/providers/book_provider.dart';
import 'package:mova/features/service.dart';
import 'package:mova/features/users/providers/user_provider.dart';
import 'package:mova/presentation/components/colors.dart';
import 'package:provider/provider.dart';

class BookStore extends StatefulWidget {
  const BookStore({super.key});

  @override
  State<BookStore> createState() => _BookStoreState();
}

class _BookStoreState extends State<BookStore> {
  var selectedSort = "сартыроўка";
  var selectedAuthor = "";

  var sorts = {
    "↑ кошт": (Book a, Book b) => a.price.compareTo(b.price),
    "↓ кошт": (Book a, Book b) => -a.price.compareTo(b.price),
    "↑ імя": (Book a, Book b) => a.name.compareTo(b.name),
    "↓ імя": (Book a, Book b) => -a.name.compareTo(b.name),
  };
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BookProvider>(context);
    var books = provider.getLocalBooks();
    var user = Provider.of<UserProvider>(context).getUser();
    return FutureBuilder(
      future: checkConnection(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: black),
          );
        } else if (!snapshot.data!) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "няма злучэння",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700),
              ),
              GestureDetector(
                onTap: () => provider.refresh(),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      color: black, borderRadius: BorderRadius.circular(15)),
                  child: const Text(
                    "абнавіць",
                    style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w700,
                        color: white),
                  ),
                ),
              )
            ],
          );
        } else {
          return FutureBuilder(
            future: provider.getBooks(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(color: black));
              } else {
                var storeBooks = snapshot.data!;
                if (selectedAuthor != "") {
                  storeBooks = storeBooks
                      .where((element) => element.author == selectedAuthor)
                      .toList();
                }
                if (selectedSort != "сартыроўка") {
                  storeBooks.sort(sorts[selectedSort]);
                }
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      color: white,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          DropdownButton<String>(
                            value: selectedSort,
                            items: const [
                              DropdownMenuItem(
                                  value: "сартыроўка",
                                  child: Text("сартыроўка")),
                              DropdownMenuItem(
                                  value: "↑ кошт", child: Text("↑ кошт")),
                              DropdownMenuItem(
                                  value: "↓ кошт", child: Text("↓ кошт")),
                              DropdownMenuItem(
                                  value: "↑ імя", child: Text("↑ імя")),
                              DropdownMenuItem(
                                  value: "↓ імя", child: Text("↓ імя")),
                            ],
                            onChanged: (value) => setState(() {
                              selectedSort = value!;
                            }),
                          ),
                          DropdownButton<String>(
                            value: selectedAuthor,
                            items: [
                              DropdownMenuItem(
                                value: "",
                                child: Text("аўтар"),
                              ),
                              ...snapshot.data!
                                  .map((e) => e.author)
                                  .toSet()
                                  .map(
                                    (e) => DropdownMenuItem(
                                        value: e, child: Text(e)),
                                  )
                            ],
                            onChanged: (value) => setState(() {
                              selectedAuthor = value!;
                            }),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: storeBooks.length,
                        itemBuilder: (context, index) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          height: index == storeBooks.length - 1 ? 575 : 475,
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            children: [
                              FutureBuilder(
                                future: provider
                                    .getImageRef(storeBooks[index].image),
                                builder: (context, snap) {
                                  if (snap.connectionState ==
                                      ConnectionState.waiting) {
                                    return Container(
                                      width: 200,
                                      height: 300,
                                      alignment: Alignment.center,
                                      color: Color.fromARGB(255, 228, 228, 228),
                                      child: const CircularProgressIndicator(
                                          color: black),
                                    );
                                  } else {
                                    return GestureDetector(
                                      onTap: () async {
                                        if (Service.user.role != "admin")
                                          return;
                                        Widget cancelButton = GestureDetector(
                                          child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 10),
                                              child: const Text(
                                                "адмяніць",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w700,
                                                    color: black),
                                              )),
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                        );
                                        Widget continueButton = GestureDetector(
                                          child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 10),
                                              child: const Text(
                                                "выдаліць",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.red),
                                              )),
                                          onTap: () {
                                            provider
                                                .removeBook(storeBooks[index])
                                                .then((value) =>
                                                    provider.refresh());
                                            Navigator.pop(context);
                                          },
                                        ); // set up the AlertDialog
                                        AlertDialog alert = AlertDialog(
                                          backgroundColor: lightGrey,
                                          surfaceTintColor: lightGrey,
                                          title: Text("Пацверджанне"),
                                          content: Text(
                                              "Выдаліць з крамы кнігу '${storeBooks[index].name}'?"),
                                          actionsAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          actions: [
                                            cancelButton,
                                            continueButton,
                                          ],
                                        );
                                        showCupertinoDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return alert;
                                          },
                                        );
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(snap.data!,
                                            width: 200, loadingBuilder:
                                                (context, child,
                                                    loadingProgress) {
                                          if (loadingProgress == null)
                                            return child;
                                          else {
                                            return Container(
                                              color: lightGrey,
                                              width: 200,
                                              height: 300,
                                            );
                                          }
                                        }),
                                      ),
                                    );
                                  }
                                },
                              ),
                              Container(
                                width: 300,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  storeBooks[index].name,
                                  style: const TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: Text(storeBooks[index].author),
                              ),
                              !user.books.contains(storeBooks[index].id)
                                  ? BuyButton(storeBooks[index])
                                  : books.indexWhere((element) =>
                                              element.id ==
                                              storeBooks[index].id) ==
                                          -1
                                      ? DownloadButton(storeBooks[index])
                                      : Container(
                                          alignment: Alignment.center,
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 20),
                                          child: const Text(
                                            "дадана",
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              color: grey,
                                            ),
                                          ),
                                        ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          );
        }
      },
    );
  }

  Future<bool> checkConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi);
  }
}

class BuyButton extends StatefulWidget {
  final Book book;
  const BuyButton(this.book, {super.key});

  @override
  State<BuyButton> createState() => _BuyButtonState();
}

class _BuyButtonState extends State<BuyButton> {
  var downloadStarted = false;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BookProvider>(context);

    return downloadStarted
        ? Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: const CircularProgressIndicator(
              color: black,
            ),
          )
        : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            GestureDetector(
              onTap: () async {
                var connectivityResult =
                    await Connectivity().checkConnectivity();
                if (connectivityResult.contains(ConnectivityResult.mobile) ||
                    connectivityResult.contains(ConnectivityResult.wifi)) {
                  provider.purchaseBook(widget.book);
                  provider
                      .loadBook(widget.book.id)
                      .then((value) => provider.refresh());
                  setState(() {
                    downloadStarted = true;
                  });
                }
              },
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    color: black, borderRadius: BorderRadius.circular(15)),
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Text(
                  "дадаць",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: white,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 2),
              child: Text(
                "${widget.book.price}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Image.asset(
              "assets/images/coin.png",
              width: 20,
            )
          ]);
  }
}

class DownloadButton extends StatefulWidget {
  final Book book;
  const DownloadButton(this.book, {super.key});

  @override
  State<DownloadButton> createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton> {
  var downloadStarted = false;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BookProvider>(context);
    return downloadStarted
        ? Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: const CircularProgressIndicator(
              color: black,
            ),
          )
        : GestureDetector(
            onTap: () async {
              var connectivityResult = await Connectivity().checkConnectivity();
              if (connectivityResult.contains(ConnectivityResult.mobile) ||
                  connectivityResult.contains(ConnectivityResult.wifi)) {
                provider
                    .loadBook(widget.book.id)
                    .then((value) => provider.refresh());
                setState(() {
                  downloadStarted = true;
                });
              }
            },
            child: Container(
              width: 200,
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  color: black, borderRadius: BorderRadius.circular(15)),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: const Icon(
                Icons.download,
                color: white,
              ),
            ),
          );
  }
}
