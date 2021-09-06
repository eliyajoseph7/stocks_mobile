import 'package:csdynamics/providers/markets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MarketReleased extends StatelessWidget {
  const MarketReleased({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var stock = Provider.of<AllMarketsProvider>(context);
    return stock.myStock.isEmpty ? 
        stock.isSuccess ? Center(child: CircularProgressIndicator()) :
        Center(child: Text('Nothing is in the stock'),) :
        
        ListView(
          children: [
            Card(
              elevation: 2,
              child: Container(
                height: 50.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Flexible(child: Center(child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text("Released stock from Market",
                        style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                      ),
                    ))),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 2.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Card(
                  child: DataTable(
                    columns: [
                      DataColumn(
                        label: Text('Date'),
                        tooltip: 'reveived date.',
                      ),
                      DataColumn(
                          label: Text('Buyer Name'),
                          tooltip: 'name of the buyer'),
                      DataColumn(
                        label: Text('Crop'),
                        tooltip: 'crop',
                      ),
                      DataColumn(
                        label: Text('Quantity'),
                        tooltip: "released quantity",
                      ),
                      DataColumn(
                        label: Text('Quality'),
                        tooltip: 'crop quality',
                      ),
                      DataColumn(
                        label: Text('Buying price'),
                        // tooltip: 'wholesale price',
                      ),
                      DataColumn(
                        label: Text('Destination Region'),
                        // tooltip: 'retail price',
                      ),
                    ],
                    rows: stock.myReleasedStock
                        .map((data) => DataRow(
                              cells: [
                                DataCell(Text(data.date)),
                                DataCell(Text(data.buyer)),
                                DataCell(Text(data.crop)),
                                DataCell(Text(data.quantity.toString())),
                                DataCell(Text(data.quality)),
                                DataCell(Text(data.buyingPrice.toString())),
                                DataCell(Text(data.destRegion.toString())),
                              ],
                            ))
                        .toList(),
                  ),
                ),
              ),
            ),
          ],
        );
  }
}