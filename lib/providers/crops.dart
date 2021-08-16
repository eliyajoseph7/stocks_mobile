import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Crop {
  int id;
  String name;

  Crop({required this.id, required this.name});

  Map toJson() => {
        'id': id,
        'name': name,
      };

}

class CropProvider with ChangeNotifier {
  List<Crop> _crops = [];

  List<Crop> get crops => [..._crops];

  
  void setcrops(
      int id, String name) {
    this._crops.add(Crop(
          id: id,
          name: name,
        ));
    notifyListeners();
  }  

  
  Future<void> fetchCrops(String trader) async {
    this._crops = [];
    http.Response response =
        await http.get(Uri.parse("http://stocks.multics.co.tz/public/api/app/crops/" + trader));

    try {
      if (response.statusCode == 200) {
        for (var map in jsonDecode(response.body)) {
          setcrops(
            map['id'],
            map['name']
          );

        }
        // print(response.body);
      }
    } catch (e, _) {
      print(e.toString());
    }
    // print(crops);
  }
}