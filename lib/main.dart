import 'package:csdynamics/providers/broker.dart';
import 'package:csdynamics/providers/buyer.dart';
import 'package:csdynamics/providers/crops.dart';
import 'package:csdynamics/providers/location.dart';
import 'package:csdynamics/providers/markets.dart';
import 'package:csdynamics/providers/seller.dart';
import 'package:csdynamics/providers/user.dart';
import 'package:csdynamics/providers/warehouses.dart';
import 'package:csdynamics/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SqfliteDatabaseHelper.instance.db;
  runApp(MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
    //..customAnimation = CustomAnimation();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: SellerProvider()),
        ChangeNotifierProvider.value(value: CropProvider()),
        ChangeNotifierProvider.value(value: LocationProvider()),
        ChangeNotifierProvider.value(value: AllMarketsProvider()),
        ChangeNotifierProvider.value(value: AllWarehouseProvider()),
        ChangeNotifierProvider.value(value: BuyerProvider()),
        ChangeNotifierProvider.value(value: BrokerProvider()),
        ChangeNotifierProvider.value(value: UserProvider()),
      ],
      child: MaterialApp(
        title: 'CSDAYNAMICS',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
            primarySwatch: Colors.green,
            primaryColor: Colors.green[900],
        ),
        debugShowCheckedModeBanner: false,
        routes: routes
        // home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
