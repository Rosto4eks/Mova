import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mova/features/book/providers/book_provider.dart';
import 'package:mova/presentation/components/colors.dart';
import 'package:provider/provider.dart';

class BookStore extends StatelessWidget {
  const BookStore({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BookProvider>(context);
    var books = provider.getLocalBooks();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.only(bottom: 100),
      child: FutureBuilder(
        future: provider.getBooks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: black));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) => Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    FutureBuilder(
                      future: provider.getImageRef(snapshot.data![index].image),
                      builder: (context, snap) {
                        if (snap.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator(color: black);
                        } else {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              snap.data!,
                              width: 200,
                            ),
                          );
                        }
                      },
                    ),
                    Container(
                      width: 300,
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        snapshot.data![index].name,
                        style: const TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(snapshot.data![index].author),
                    ),
                    books.indexWhere((element) =>
                                element.id == snapshot.data![index].id) ==
                            -1
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                GestureDetector(
                                  onTap: () async {
                                    var connectivityResult =
                                        await Connectivity()
                                            .checkConnectivity();
                                    if (connectivityResult.contains(
                                            ConnectivityResult.mobile) ||
                                        connectivityResult.contains(
                                            ConnectivityResult.wifi)) {
                                      showDialog(
                                          // ignore: use_build_context_synchronously
                                          context: context,
                                          builder: (context) => const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: lightGreen,
                                                ),
                                              ),
                                          barrierDismissible: false);
                                      await provider
                                          .loadBook(snapshot.data![index].id);
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    decoration: BoxDecoration(
                                        color: black,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 20),
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
                                    "${snapshot.data![index].price}",
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
                              ])
                        : Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(vertical: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15)),
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 20),
                            child: Text(
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
            );
          }
        },
      ),
    );
  }
}
