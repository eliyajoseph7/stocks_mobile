
import 'package:csdynamics/providers/buyer.dart';
import 'package:csdynamics/providers/crops.dart';
import 'package:csdynamics/providers/location.dart';
import 'package:csdynamics/providers/markets.dart';
import 'package:csdynamics/providers/seller.dart';
import 'package:csdynamics/providers/warehouses.dart';
import 'package:csdynamics/screens/login.dart';
import 'package:csdynamics/widgets/market.dart';
import 'package:csdynamics/widgets/warehouse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      var seller = Provider.of<SellerProvider>(context, listen: false);
      var crop = Provider.of<CropProvider>(context, listen: false);
      var location = Provider.of<LocationProvider>(context, listen: false);
      var markets = Provider.of<AllMarketsProvider>(context, listen: false);
      var warehouses = Provider.of<AllWarehouseProvider>(context, listen: false);
      var buyer = Provider.of<BuyerProvider>(context, listen: false);

      seller.fetchSellers();
      // crop.fetchCrops();
      location.fetchRegions();
      markets.fetchMarkets();
      warehouses.fetchWarehouses();
      buyer.fetchBuyers();
    });
  }

  checkLoginStatus() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
       body: NestedScrollView(
         headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
           return [
             SliverAppBar(
               actions: [
                 IconButton(
                   onPressed: () { _showPopupMenu();},
                   icon: Icon(Icons.more_vert, color: Colors.white,),
                )
               ],
               expandedHeight: 210.0,
               pinned: true,
               floating: true,
               flexibleSpace: FlexibleSpaceBar(
                 title: Text(
                   'Crop Stock Dynamics',
                   style: TextStyle(
                     color: Colors.white
                   ),
                   ),
                 centerTitle: false,
                 titlePadding: EdgeInsets.only(left: 5.0, bottom: 5.0),
                 background: Image.asset(
                   'assets/images/crops.jpg',
                   fit: BoxFit.cover
                 ),
                ),
             ),
           ];
         },
         body: ListView(
           children: [
             Column(
               children: [
                Warehouse(),
                Market()
               ],
             ),
           ],
         ),
       ),
    );
  }

    _showPopupMenu() {
    showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(25.0, 25.0, 0.0,
          0.0), //position where you want to show the menu on screen
      items: [
        PopupMenuItem<String>(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Logout'),
            ],
          ),
          value: '1',
        ),
      ],
      elevation: 8.0,
    ).then((value) => {
      if (value == '1') {
        logmeOut(),
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false)
      }
    });
  }

  logmeOut() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }
}