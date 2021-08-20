import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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
  List<AllMarkets> _sourceMarkets = [];


  bool loading = false;
  bool success = false;
  
  List<AllMarkets> get markets => [..._markets];
  List<AllMarkets> get sourceMarkets => [..._sourceMarkets];
  bool get isLoading => loading;
  bool get isSuccess => success;

  
  void setMarkets(
      int id, String name) {
    this._markets.add(AllMarkets(
          id: id,
          name: name,
        ));
    notifyListeners();
  } 
  
  void setSourceMarkets(
      int id, String name) {
    this._sourceMarkets.add(AllMarkets(
          id: id,
          name: name,
        ));
    notifyListeners();
  }  


  void setLoading() {
    this.loading = !this.loading;
    notifyListeners();
  }

  void setSuccess() {
    this.success = !this.success;
    notifyListeners();
  }
  
  Future<void> fetchMarkets() async {
    SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
    this._markets = [];
    var token = sharedPreferences.getString('token');
    http.Response response =
        await http.get(Uri.parse("http://stocks.multics.co.tz/public/api/app/markets/" + token.toString()));

    try {
      if (response.statusCode == 200) {
        for (var map in jsonDecode(response.body)) {
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

  
  Future<void> fetchSourceMarkets(String district) async {
    this._sourceMarkets = [];
    http.Response response =
        await http.get(Uri.parse("http://stocks.multics.co.tz/public/api/area_markets/" + district));

    try {
      if (response.statusCode == 200) {
        for (var map in jsonDecode(response.body)) {
          setSourceMarkets(
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

  void receiveInMarket(data, context) async {
    try {
      var response = await http.post(
          Uri.parse("http://stocks.multics.co.tz/public/api/receive-in-market"),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'accept': 'application/json'
          },
          body: data);

      print(response.statusCode);
      if (response.statusCode == 200) {
        setLoading();
        Navigator.pop(context);
        if (jsonDecode(response.body)['resp'] != 'failed') {
          setSuccess();
          final snackBar = SnackBar(
              content: Text(
                  'Commodity received successfully'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } 
    }
    catch(e) {
      print(e.toString());
      Navigator.pop(context);
      final snackBar = SnackBar(
        content: Text(
            'something went wrong'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

   void releaseFromMarket(data, context) async {
    try {
      var response = await http.post(
          Uri.parse("http://stocks.multics.co.tz/public/api/app/release_from_market"),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'accept': 'application/json'
          },
          body: data);

      print(response.statusCode);
      if (response.statusCode == 200) {
        setLoading();
        Navigator.pop(context);
        if (jsonDecode(response.body)['resp'] != 'failed') {
          if (jsonDecode(response.body)['resp'] != 'nothing') {
            setSuccess();
            final snackBar = SnackBar(
                content: Text(
                    'Commodity released successfully'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else {
            final snackBar = SnackBar(
                content: Text(
                    'Nothing is in the market for release'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        }else {
          setLoading();
          final snackBar = SnackBar(
              content: Text(
                  'Quantity exceeded the available amount'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } 
    }
    catch(e) {
      print(e.toString());
      Navigator.pop(context);
      final snackBar = SnackBar(
        content: Text(
            'something went wrong'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

}