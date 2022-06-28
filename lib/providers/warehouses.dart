import 'package:csdynamics/screens/stock_warehouse.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AllWarehouse {
  int id;
  String name;

  AllWarehouse({required this.id, required this.name});

  Map toJson() => {
        'id': id,
        'name': name,
      };

}

class StockWarehouse {
  String date;
  String seller;
  String crop;
  int quantity;
  String quality;
  double buyingPrice;
  String srcRegion;

  StockWarehouse({required this.date, required this.seller, required this.crop, 
  required this.quality, required this.quantity, required this.srcRegion, required this.buyingPrice});

  Map toJson() => {
        'date': date,
        'seller': seller,
        'crop': crop,
        'quantity': quantity,
        'quality': quality,
        'buyingPrice': buyingPrice,
        'srcRegion': srcRegion,
      };

}

class ReleasedStockWarehouse { 
  String date;
  String buyer;
  String crop;
  int quantity;
  String quality;
  double buyingPrice;
  String destRegion;

  ReleasedStockWarehouse({required this.date, required this.buyer, required this.crop, 
  required this.quality, required this.quantity, required this.destRegion, required this.buyingPrice});

  Map toJson() => {
        'date': date,
        'buyer': buyer,
        'crop': crop,
        'quantity': quantity,
        'quality': quality,
        'buyingPrice': buyingPrice,
        'destRegion': destRegion,
      };

}

class AllWarehouseProvider with ChangeNotifier {
  List<AllWarehouse> _warehouses = [];
  List<AllWarehouse> _sourceWarehouses = [];

  
  List<StockWarehouse> _myStock = [];

  List<ReleasedStockWarehouse> _myReleasedStock = [];

  bool loading = false;
  bool success = false;

  List<AllWarehouse> get warehouses => [..._warehouses];
  List<AllWarehouse> get sourceWarehouses => [..._sourceWarehouses];
  List<StockWarehouse> get myStock => [..._myStock];

  List<ReleasedStockWarehouse> get myReleasedStock => [..._myReleasedStock];
  bool get isLoading => loading;
  bool get isSuccess => success;

  
  void setWarehouses(
      int id, String name) {
    this._warehouses.add(AllWarehouse(
          id: id,
          name: name,
        ));
    notifyListeners();
  }  
  
  void setSourceWarehouses(
      int id, String name) {
    this._sourceWarehouses.add(AllWarehouse(
          id: id,
          name: name,
        ));
    notifyListeners();
  }  

  void setMyWarehouseStock(
      String date,
      String seller,
      String crop,
      int quantity,
      String quality,
      double buyingPrice,
      String srcRegion) {
    this._myStock.add(StockWarehouse(
      date: date, 
      seller: seller, 
      crop: crop, 
      quality: quality, 
      quantity: quantity, buyingPrice: buyingPrice, srcRegion: srcRegion
          
        ));
    notifyListeners();
  }  

  
  void setMyReleasedWarehouseStock(
      String date,
      String buyer,
      String crop,
      int quantity,
      String quality,
      double buyingPrice,
      String destRegion) {
    this._myReleasedStock.add(ReleasedStockWarehouse(
      date: date, 
      buyer: buyer, 
      crop: crop, 
      quality: quality, 
      quantity: quantity, buyingPrice: buyingPrice, destRegion: destRegion
          
        ));
    notifyListeners();
  }  

  void setLoading() {
    this.loading = !this.loading;
    notifyListeners();
  }

  void setSuccess(bool value) {
    this.success = value;
    notifyListeners();
  }
  
  Future<void> fetchWarehouses() async {
    SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
    this._warehouses = [];
    var token = sharedPreferences.getString('token');
    http.Response response =
        await http.get(Uri.parse("http://stocks.multics.co.tz/public/api/app/warehouses/" + token.toString()));

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

  Future<void> fetchSourceWarehouses(String district) async {
    this._sourceWarehouses = [];
    http.Response response =
        await http.get(Uri.parse("http://stocks.multics.co.tz/public/api/area-warehouses/" + district));

    try {
      if (response.statusCode == 200) {
        for (var map in jsonDecode(response.body)) {
          setSourceWarehouses(
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
        if (jsonDecode(response.body)['resp'] != 'failed') {
          setSuccess(false);
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context)=> AvailableStock()));
          final snackBar = SnackBar(
              content: Text(
                  'Commodity received successfully'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }else {
          setLoading(); 
          final snackBar = SnackBar(
              content: Text(
                  'Quantity exceeded the warehouse capacity'),
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

  void releaseFromWarehouses(data, context) async {
    try {
      var response = await http.post(
          Uri.parse("http://stocks.multics.co.tz/public/api/app/release_from_warehouse"),
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
            setSuccess(false);
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context)=> AvailableStock()));
            final snackBar = SnackBar(
                content: Text(
                    'Commodity released successfully'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else {
            final snackBar = SnackBar(
                content: Text(
                    'Nothing is in the warehouse for release'),
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

  Future<void> getWarehouseStock() async {
    SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
    this._myStock = [];
    this._myReleasedStock = [];
    var token = sharedPreferences.getString('token');
    http.Response response =
        await http.get(Uri.parse("http://stocks.multics.co.tz/public/api/app/stock_warehouses/" + token.toString()));

    try {
      if (response.statusCode == 200) {
        for (var map in jsonDecode(response.body)[0]) {
          setMyWarehouseStock(
            map['date1'],
            map['seller'],
            map['crop'],
            map['quantity'],
            map['quality'],
            map['buying_price'].toDouble(),
            map['region']
          );
        }    
        for (var map in jsonDecode(response.body)[1]) {
          setMyReleasedWarehouseStock(
            map['date1'],
            map['buyer'],
            map['crop'],
            map['quantity'],
            map['quality'],
            map['buying_price'].toDouble(),
            map['region']
          );
        }
          setSuccess(false);
        // print(response.body);
      }
    } catch (e, _) {
      print(e.toString());
    }
    // print(Warehouses);
  }

}