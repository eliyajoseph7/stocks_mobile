import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AllMarkets {
  int id;
  String name;

  AllMarkets({required this.id, required this.name});

  Map toJson() => {
        'id': id,
        'name': name,
      };

}

class AllMarketsProvider with ChangeNotifier {
  List<AllMarkets> _markets = [];

  List<AllMarkets> get markets => [..._markets];

  
  void setMarkets(
      int id, String name) {
    this._markets.add(AllMarkets(
          id: id,
          name: name,
        ));
    notifyListeners();
  }  

  
  Future<void> fetchMarkets() async {
    this._markets = [];
    http.Response response =
        await http.get(Uri.parse("http://stocks.multics.co.tz/public/api/markets"));

    try {
      if (response.statusCode == 200) {
        for (var map in jsonDecode(response.body)[0]) {
          setMarkets(
            map['id'],
            map['name']
          );

        }
        // print(response.body);
      }
    } catch (e, _) {
      print(e.toString());
    }
    // print(markets);
  }
}