import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AllWarehouse {
  int id;
  String name;

  AllWarehouse({required this.id, required this.name});

  Map toJson() => {
        'id': id,
        'name': name,
      };

}

class AllWarehouseProvider with ChangeNotifier {
  List<AllWarehouse> _warehouses = [];

  bool loading = false;

  List<AllWarehouse> get warehouses => [..._warehouses];
  bool get isLoading => loading;

  
  void setWarehouses(
      int id, String name) {
    this._warehouses.add(AllWarehouse(
          id: id,
          name: name,
        ));
    notifyListeners();
  }  

  void setLoading() {
    this.loading = !this.loading;
  }
  
  Future<void> fetchWarehouses() async {
    this._warehouses = [];
    http.Response response =
        await http.get(Uri.parse("http://stocks.multics.co.tz/public/api/warehouse"));

    try {
      if (response.statusCode == 200) {
        for (var map in jsonDecode(response.body)) {
          setWarehouses(
            map['id'],
            map['name']
          );

        }
        // print(response.body);
      }
    } catch (e, _) {
      print(e.toString());
    }
    // print(warehouses);
  }

  void receiveInWarehouses(data, context) async {
    try {
      var response = await http.post(
          Uri.parse("http://stocks.multics.co.tz/public/api/receive-in-warehouse"),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'accept': 'application/json'
          },
          body: data);

      print(response.statusCode);
      if (response.statusCode == 200) {
        setLoading();
        Navigator.pop(context);
        final snackBar = SnackBar(
            content: Text(
                'Commodity received successfully'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (response.statusCode == 401) {
        setLoading();
        Navigator.pop(context);
        final snackBar = SnackBar(
            content: Text(
                'Quantity exceeded the warehouse capacity'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
    catch(e) {
      print(e.toString());
    }
  }
}