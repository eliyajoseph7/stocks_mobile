import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'databasehelper.dart';
import 'ReceiveinModel.dart';
import 'package:http/http.dart' as htpp;

class SyncronizationData {

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

  final conn = SqfliteDatabaseHelper.instance;
  
  Future<List<ReceiveinModel>> fetchAllInfo()async{
    final dbClient = await conn.db;
    List<ReceiveinModel> receiveList = [];
    try {
      final maps = await dbClient.query(SqfliteDatabaseHelper.receivein_warehouses);
      for (var item in maps) {
        receiveList.add(ReceiveinModel.fromJson(item));
      }
    } catch (e) {
      print(e.toString());
    }
    return receiveList;
  }

   

  Future saveToMysqlWith(List<ReceiveinModel> receiveList)async{
    for (var i = 0; i < receiveList.length; i++) {
      Map<String, dynamic> data = {
        "id":receiveList[i].id.toString(),
        "date":receiveList[i].date,
        "trader_id":receiveList[i].trader_id.toString(),
        "quality":receiveList[i].quality,
        "buying_price":receiveList[i].buying_price,
        "quantity":receiveList[i].quantity,
        "created_at":receiveList[i].created_at,
        "source":receiveList[i].source,
        "crop_id":receiveList[i].crop_id.toString(),
        "warehouse_id":receiveList[i].warehouse_id.toString(),
        "village_id":receiveList[i].village_id.toString(),
        "ward_id":receiveList[i].ward_id.toString(),
        "district_id":receiveList[i].district_id.toString(),
        "region_id":receiveList[i].region_id.toString(),
        "origin_warehouse":receiveList[i].origin_warehouse,
        "origin_market":receiveList[i].origin_market,
        "cess_payment":receiveList[i].cess_payment,
        "updated_at":receiveList[i].updates_at,
      };
      final response = await htpp.post('http://192.168.43.6/syncsqftomysqlflutter/load_from_sqflite_contactinfo_table_save_or_update_to_mysql.php',body: data);
      if (response.statusCode==200) {
        print("Saving Data ");
      }else{
        print(response.statusCode);
      }
    }
  }

  Future<List> fetchAllCustoemrInfo()async{
    final dbClient = await conn.db;
    List receiveList = [];
    try {
      final maps = await dbClient.query(SqfliteDatabaseHelper.contactinfoTable);
      for (var item in maps) {
        receiveList.add(item);
      }
    } catch (e) {
      print(e.toString());
    }
    return receiveList;
  }

  Future saveToMysql(List receiveList)async{
    for (var i = 0; i < receiveList.length; i++) {
      Map<String, dynamic> data = {
         "id":receiveList[i].id.toString(),
        "date":receiveList[i].date,
        "trader_id":receiveList[i].trader_id.toString(),
        "quality":receiveList[i].quality,
        "buying_price":receiveList[i].buying_price,
        "quantity":receiveList[i].quantity,
        "created_at":receiveList[i].created_at,
        "source":receiveList[i].source,
        "crop_id":receiveList[i].crop_id.toString(),
        "warehouse_id":receiveList[i].warehouse_id.toString(),
        "village_id":receiveList[i].village_id.toString(),
        "ward_id":receiveList[i].ward_id.toString(),
        "district_id":receiveList[i].district_id.toString(),
        "region_id":receiveList[i].region_id.toString(),
        "origin_warehouse":receiveList[i].origin_warehouse,
        "origin_market":receiveList[i].origin_market,
        "cess_payment":receiveList[i].cess_payment,
        "updated_at":receiveList[i].updates_at,
      };
      final response = await htpp.post('http://192.168.43.6/syncsqftomysqlflutter/load_from_sqflite_contactinfo_table_save_or_update_to_mysql.php',body: data);
      if (response.statusCode==200) {
        print("Saving Data ");
      }else{
        print(response.statusCode);
      }
    }
  }

}