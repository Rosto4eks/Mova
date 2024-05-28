import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mova/presentation/components/colors.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:ping_discover_network_v2/ping_discover_network_v2.dart';

class TransalteProvider extends ChangeNotifier {
  String serverAddress = "";
  double? progressValue = 0;
  final int port = 1337;

  String translate = "";

  TransalteProvider() {
    findServer();
  }

  Future findServer() async {
    var addrs = [];

    var list = await NetworkInterface.list();
    for (var addresses in list) {
      for (var addr in addresses.addresses) {
        var index = addr.address.lastIndexOf('.');
        if (index == -1) {
          continue;
        }
        addrs.add(addr.address.substring(0, addr.address.lastIndexOf('.')));
      }
    }
    for (var addr in addrs) {
      final stream = NetworkAnalyzer.discover2(
        addr,
        port,
        timeout: const Duration(milliseconds: 5000),
      );

      stream.listen((NetworkAddress adr) {
        if (adr.exists) {
          serverAddress = adr.ip;
        }
      });
    }
  }

  Future getTranslate(text) async {
    if (serverAddress.isEmpty) {
      findServer();
      showError("няма злучэння з серверам");
      return;
    }
    progressValue = null;
    notifyListeners();
    final url = Uri.parse('http://$serverAddress:1337?text=$text');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        translate = jsonDecode(utf8.decode(response.bodyBytes))["message"];
        notifyListeners();
      }
    } catch (e) {
      showError("няма злучэння з серверам");
      return;
    } finally {
      progressValue = 0;
      notifyListeners();
    }
  }

  void refresh() {
    notifyListeners();
  }
}

void showError(String text) {
  showOverlayNotification((context) {
    return Card(
      color: Colors.red,
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
              color: black,
            )
          ],
        ),
      ),
    );
  }, duration: const Duration(seconds: 2));
}
