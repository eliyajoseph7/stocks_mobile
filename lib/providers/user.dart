import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {

  UserProvider() {
    loadPreferences();
  }
  List<String> permissions = [];

  List<String> get myPermissions => [...permissions];
  
  void setPermissions(
    List perms) {
    this.permissions = [];
    for (var i = 0; i < perms.length; i++) {
      this.permissions.add(perms[i]);
    }
    notifyListeners();
    savePreferences();
    // print(permissions);
  }  


  savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('permissions', myPermissions);
  }

  loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var permissions = prefs.getStringList('permissions');

  print(permissions);
    if (permissions != null) {
      setPermissions(permissions);
      // this.permissions = permissions;
    }
  }

 }