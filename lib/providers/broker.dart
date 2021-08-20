import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Broker {
  int id;
  String name;

  Broker({required this.id, required this.name});

  Map toJson() => {
        'id': id,
        'name': name,
      };

}

class BrokerProvider with ChangeNotifier {
  List<Broker> _brokers = [];

  List<Broker> get brokers => [..._brokers];

  
  void setBrokers(
    int id, String name) {
    this._brokers.add(Broker(
          id: id,
          name: name,
        ));
    notifyListeners();
  }  

  Future<void> fetchBrokers() async {
    this._brokers = [];
    http.Response response =
        await http.get(Uri.parse("http://stocks.multics.co.tz/public/api/category_traders/broker"));

    try {
      if (response.statusCode == 200) {
        for (var map in jsonDecode(response.body)) {
          setBrokers(
            map['id'],
            map['name']
          );

        }
        // print(response.body);
      }
    } catch (e, _) {
      print(e.toString());
    }
    // print(brokers);
  }
}