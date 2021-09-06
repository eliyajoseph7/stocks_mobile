import 'package:csdynamics/screens/stock_market.dart';
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
class StockMarket {
  String date;
  String broker;
  String crop;
  int quantity;
  String quality;
  double wholesale;
  double retail;

  StockMarket({required this.date, required this.broker, required this.crop, 
  required this.quality, required this.quantity, required this.retail, required this.wholesale});

  Map toJson() => {
        'date': date,
        'broker': broker,
        'crop': crop,
        'quantity': quantity,
        'quality': quality,
        'wholesale': wholesale,
        'retail': retail,
      };

}

class ReleasedStockMarket {
  String date;
  String buyer;
  String crop;
  int quantity;
  String quality;
  double buyingPrice;
  String destRegion;

  ReleasedStockMarket({required this.date, required this.buyer, required this.crop, 
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

class AllMarketsProvider with ChangeNotifier {
  List<AllMarkets> _markets = [];
  List<AllMarkets> _sourceMarkets = [];
  List<StockMarket> _myStock = [];

  List<ReleasedStockMarket> _myReleasedStock = [];


  bool loading = false;
  bool success = false;
  
  List<AllMarkets> get markets => [..._markets];
  List<AllMarkets> get sourceMarkets => [..._sourceMarkets];
  List<StockMarket> get myStock => [..._myStock];

  List<ReleasedStockMarket> get myReleasedStock => [..._myReleasedStock];
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
  void setMyMarketStock(
      String date,
      String broker,
      String crop,
      int quantity,
      String quality,
      double wholesale,
      double retail) {
    this._myStock.add(StockMarket(
      date: date, 
      broker: broker, 
      crop: crop, 
      quality: quality, 
      quantity: quantity, wholesale: wholesale, retail: retail
          
        ));
    notifyListeners();
  }  

  
  void setMyReleasedMarketStock(
      String date,
      String buyer,
      String crop,
      int quantity,
      String quality,
      double buyingPrice,
      String destRegion) {
    this._myReleasedStock.add(ReleasedStockMarket(
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
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context)=> AvailableStock()));
        if (jsonDecode(response.body)['resp'] != 'failed') {
          setSuccess(false);
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

 
  Future<void> getMyMarketStock() async {
    SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
    this._myStock = [];
    this._myReleasedStock = [];
    var token = sharedPreferences.getString('token');
    http.Response response =
        await http.get(Uri.parse("http://stocks.multics.co.tz/public/api/app/stock_markets/" + token.toString()));

    try {
      if (response.statusCode == 200) {
        for (var map in jsonDecode(response.body)[0]) {
          setMyMarketStock(
            map['date1'],
            map['broker'],
            map['crop'],
            map['quantity'],
            map['quality'],
            map['total_price'].toDouble(),
            map['retail_price'].toDouble()
          );
        }    
        for (var map in jsonDecode(response.body)[1]) {
          setMyReleasedMarketStock(
            map['date1'],
            map['buyer'],
            map['crop'],
            map['quantity'],
            map['quality'],
            map['buying_price'].toDouble(),
            map['region']
          );
          setSuccess(false);
        }
        // print(response.body);
      }
    } catch (e, _) {
      print(e.toString());
    }
    // print(markets);
  }

}