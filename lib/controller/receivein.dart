import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:csdynamics/receiveinModel.dart';
import 'databasehelper.dart';

class Controller {
  final conn = SqfliteDatabaseHelper.instance;

  static Future<bool> isInternet()async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      if (await DataConnectionChecker().hasConnection) {
        print("Mobile data detected & internet connection confirmed.");
        return true;
      }else{
        print('No internet :( Reason:');
        return false;
      }
    } else if (connectivityResult == ConnectivityResult.wifi) {
      if (await DataConnectionChecker().hasConnection) {
        print("wifi data detected & internet connection confirmed.");
        return true;
      }else{
        print('No internet :( Reason:');
        return false;
      }
    }else {
      print("Neither mobile data or WIFI detected, not internet connection found.");
      return false;
    }
  }

  Future<int> addData(ReceiveinModel receiveinModel)async{
    var dbclient = await conn.db;
    int result;
    try {
      result = await dbclient.insert(SqfliteDatabaseHelper.receivein_warehouses, receiveinModel.toJson());
    } catch (e) {
      print(e.toString());
    }
    return result;
  }

  Future<int> updateData(ReceiveinModel receiveinModel)async{
    var dbclient = await conn.db;
    int result;
    try {
      result = await dbclient.update(SqfliteDatabaseHelper.receivein_warehouses, receiveinModel.toJson(),where: 'id=?',whereArgs: [receiveinModel.id]);
    } catch (e) {
      print(e.toString());
    }
    return result;
  }

  Future fetchData()async{
    var dbclient = await conn.db;
    List userList = [];
    try {
      List<Map<String,dynamic>> maps = await dbclient.query(SqfliteDatabaseHelper.receivein_warehouses,orderBy: 'id DESC');
      for (var item in maps) {
        userList.add(item);
      }
    } catch (e) {
      print(e.toString());
    }
    return userList;
  }
}