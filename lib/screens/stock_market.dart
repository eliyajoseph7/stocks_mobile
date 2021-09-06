import 'package:csdynamics/providers/markets.dart';
import 'package:csdynamics/widgets/market_received.dart';
import 'package:csdynamics/widgets/market_released.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AvailableStock extends StatefulWidget {
  AvailableStock({Key? key}) : super(key: key);

  @override
  _AvailableStockState createState() => _AvailableStockState();
}

class _AvailableStockState extends State<AvailableStock> {
   @override
  void initState() {
    super.initState();
    
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      var load = Provider.of<AllMarketsProvider>(context, listen: false);
      
      load.setSuccess(true);
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         toolbarHeight: 80,
         title: Column(
           children: [
             Text("Crop Stock Dynamics"),
             Text("Stock details", 
             style: TextStyle(
               fontSize: 17.0
             ),),
             Text('in secondary market', 
              style: TextStyle(
                fontWeight: FontWeight.w100,
                fontSize: 15
              )
            )
           ],
         ),
       ),
       body: DefaultTabController(
         length: 2,
         initialIndex: 0,
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
             Container(
               height: 50,
               child: TabBar(
                labelColor: Colors.green,
                unselectedLabelColor: Colors.black,
                tabs: [
                 Tab(text: "Received",),
                 Tab(text: "Released",)
               ],),
             ),

             Expanded(
               child: Container(
                //  height: MediaQuery.of(context).size.height * 0.785,
                 color: Colors.green[100],
                 child: TabBarView(
                   children: [
                     MarketReceived(),
                     MarketReleased(),
                  ]
                 ),
               ),
             )
           ],
         ),
       ),
      
    );
  }
}