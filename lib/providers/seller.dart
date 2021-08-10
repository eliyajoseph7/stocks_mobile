import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Seller {
  int id;
  String name;

  Seller({required this.id, required this.name});

  Map toJson() => {
        'id': id,
        'name': name,
      };

}

class SellerProvider with ChangeNotifier {
  List<Seller> _sellers = [];
  List _sellersNames = [];

  List<Seller> get sellers => [..._sellers];
  List get sellersNames => [..._sellersNames];

  
  void setSellers(
      int id, String name) {
    this._sellers.add(Seller(
          id: id,
          name: name,
        ));
    notifyListeners();
  }  

  void setSellersNames(
      String name) {
    this._sellersNames.add(
          name,
        );
    notifyListeners();
  }

  int setSellerId(String seller) {
    final theSeller = sellers.where((element) => element.name == seller).first;

    return theSeller.id;
  }
  
  Future<void> fetchSellers() async {
    this._sellers = [];
    http.Response response =
        await http.get(Uri.parse("http://stocks.multics.co.tz/public/api/category_traders/seller"));

    try {
      if (response.statusCode == 200) {
        for (var map in jsonDecode(response.body)) {
          setSellers(
            map['id'],
            map['name']
          );

          setSellersNames(map['name']);
        }
        // print(response.body);
      }
    } catch (e, _) {
      print(e.toString());
    }
    // print(sellers);
  }
}