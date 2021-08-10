import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Buyer {
  int id;
  String name;

  Buyer({required this.id, required this.name});

  Map toJson() => {
        'id': id,
        'name': name,
      };

}

class BuyerProvider with ChangeNotifier {
  List<Buyer> _buyers = [];

  List<Buyer> get buyers => [..._buyers];

  
  void setBuyers(
    int id, String name) {
    this._buyers.add(Buyer(
          id: id,
          name: name,
        ));
    notifyListeners();
  }  

  Future<void> fetchBuyers() async {
    this._buyers = [];
    http.Response response =
        await http.get(Uri.parse("http://stocks.multics.co.tz/public/api/category_traders/buyer"));

    try {
      if (response.statusCode == 200) {
        for (var map in jsonDecode(response.body)) {
          setBuyers(
            map['id'],
            map['name']
          );

        }
        // print(response.body);
      }
    } catch (e, _) {
      print(e.toString());
    }
    // print(buyers);
  }
}