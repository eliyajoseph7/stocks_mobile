import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Region {
  int regionId;
  String regionName;

  Region({required this.regionId, required this.regionName});

  Map toJson() => {
        'regionId': regionId,
        'regionName': regionName,
      };

}

class District {
  int districtId;
  String districtName;

  District({required this.districtId, required this.districtName});

  Map toJson() => {
        'districtId': districtId,
        'districtName': districtName,
      };

}

class Ward {
  int wardId;
  String wardName;

  Ward({required this.wardId, required this.wardName});

  Map toJson() => {
        'wardId': wardId,
        'wardName': wardName,
      };

}

class Village {
  int villageId;
  String villageName;

  Village({required this.villageId, required this.villageName});

  Map toJson() => {
        'villageId': villageId,
        'villageName': villageName,
      };

}

class LocationProvider with ChangeNotifier {
  List<Region> _regions = [];
  List _regionsNames = [];

  List<District> _districts = [];
  List _districtsNames = [];

  List<Ward> _wards = [];
  List _wardsNames = [];

  List<Village> _villages = [];
  List _villagesNames = [];

  List<Region> get regions => [..._regions];
  List get regionsNames => [..._regionsNames];

  List<District> get districts => [..._districts];
  List get districtsNames => [..._districtsNames];

  List<Ward> get wards => [..._wards];
  List get wardsNames => [..._wardsNames];

  List<Village> get villages => [..._villages];
  List get villagesNames => [..._villagesNames];

  
  void setRegions(
      int id, String name) {
    this._regions.add(Region(
          regionId: id,
          regionName: name,
        ));
    notifyListeners();
  }
  
  void setDistricts(
      int id, String name) {
    this._districts.add(District(
          districtId: id,
          districtName: name,
        ));
    notifyListeners();
  }
  
  void setWards(
      int id, String name) {
    this._wards.add(Ward(
          wardId: id,
          wardName: name,
        ));
    notifyListeners();
  }
  
  void setVillages(
      int id, String name) {
    this._villages.add(Village(
          villageId: id,
          villageName: name,
        ));
    notifyListeners();
  }
  
  Future<void> fetchRegions() async {
    this._regions = [];
    http.Response response =
        await http.get(Uri.parse("http://stocks.multics.co.tz/public/api/regions"));

    try {
      if (response.statusCode == 200) {
        for (var map in jsonDecode(response.body)) {
          setRegions(
            map['id'],
            map['name']
          );

        }
        // print(response.body);
      }
    } catch (e, _) {
      print(e.toString());
    }
    // print(regions);
  }

  Future<void> fetchDistricts(String region) async {
    print(region);
    this._districts = [];
    http.Response response =
        await http.get(Uri.parse("http://stocks.multics.co.tz/public/api/districts/" + region));

    try {
      if (response.statusCode == 200) {
        for (var map in jsonDecode(response.body)) {
          setDistricts(
            map['id'],
            map['name']
          );

        }
        // print(response.body);
      }
    } catch (e, _) {
      print(e.toString());
    }
    // print(districts);
  }

  Future<void> fetchWards(String district) async {
    this._wards = [];
    http.Response response =
        await http.get(Uri.parse("http://stocks.multics.co.tz/public/api/wards/" + district));

    try {
      if (response.statusCode == 200) {
        for (var map in jsonDecode(response.body)) {
          setWards(
            map['id'],
            map['name']
          );

        }
        // print(response.body);
      }
    } catch (e, _) {
      print(e.toString());
    }
  }

  Future<void> fetchvillage(String ward) async {
    this._villages = [];
    http.Response response =
        await http.get(Uri.parse("http://stocks.multics.co.tz/public/api/villages/" + ward));

    try {
      if (response.statusCode == 200) {
        for (var map in jsonDecode(response.body)) {
          setVillages(
            map['id'],
            map['name']
          );

        }
        // print(response.body);
      }
    } catch (e, _) {
      print(e.toString());
    }
  }
}