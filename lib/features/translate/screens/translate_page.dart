import "package:flutter/material.dart";
import "package:mova/features/translate/providers/translate_provider.dart";
import "package:mova/presentation/components/colors.dart";
import "package:provider/provider.dart";

class TranslatePage extends StatefulWidget {
  const TranslatePage({super.key});

  @override
  State<TranslatePage> createState() => _TranslateState();
}

class _TranslateState extends State<TranslatePage> {
  String text = "";

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<TransalteProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: lightGrey,
      body: GestureDetector(
        onTap: () => provider.getTranslate(text),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Material(
                    color: Colors.transparent,
                    child: TextField(
                      maxLength: 200,
                      onChanged: (val) {
                        setState(() {
                          text = val;
                        });
                      },
                      minLines: 1,
                      maxLines: 10,
                      textAlign: TextAlign.justify,
                      cursorColor: black,
                      style: const TextStyle(
                        fontSize: 18,
                        color: black,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        fillColor: black,
                        border: const UnderlineInputBorder(),
                        focusedBorder: const UnderlineInputBorder(),
                        enabledBorder: const UnderlineInputBorder(),
                        hintText: "перавесці...",
                        hintStyle: TextStyle(color: black.withOpacity(0.4)),
                        contentPadding: const EdgeInsets.all(10),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: LinearProgressIndicator(
                    value: provider.progressValue,
                    color: color4,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: black, borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    "перавесці",
                    style: TextStyle(color: white, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
              ]),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Text(
                  provider.translate,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.justify,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
