import 'package:csdynamics/providers/markets.dart';
import 'package:csdynamics/screens/marketin.dart';
import 'package:csdynamics/screens/marketout.dart';
import 'package:csdynamics/screens/stock_market.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Market extends StatelessWidget {
  const Market({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var market = Provider.of<AllMarketsProvider>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            InMarket()));
              },
              child: Card(
              //  color: Colors.blueGrey[50],
              elevation: 2,
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5)
                )
                ),
              child: SizedBox(
                height: 130,
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Card(
                        color: Colors.grey[200],
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              "Receive stock in market",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.arrow_circle_down,
                          size: 58.0,
                        ),
                      )
                    ]
                  ),
                ),
              ),
              ),
            ),
            SizedBox(height: 8.0,),
          GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            OutMarket()));
              },
            child: Card(
              elevation: 2,
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5)
                )
                ),
              child: SizedBox(
                height: 130,
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Card(
                        color: Colors.grey[200],
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              "Release stock from market",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.arrow_circle_up,
                          size: 58.0,
                        ),
                      )
                    ]
                  ),
                ),
              ),
              ),
          ),
          GestureDetector(
              onTap: () {
                market.getMyMarketStock();
                Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            AvailableStock()));
              },
            child: Card(
              elevation: 2,
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5)
                )
                ),
              child: SizedBox(
                // height: MediaQuery.of(context).size.height * 0.15,
                height: 130,
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Card(
                        color: Colors.grey[200],
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              "View Market Stock",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.house,
                          size: 58.0,
                        ),
                      )
                    ]
                  ),
                ),
              ),
              ),
          ),
      ],
    );

  }
}