import 'package:csdynamics/providers/markets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MarketReceived extends StatelessWidget {
  const MarketReceived({Key? key}) : super(key: key);

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
                      child: Text("Received stock in the Market",
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
                          label: Text('Broker Name'),
                          tooltip: 'name of the broker'),
                      DataColumn(
                        label: Text('Crop'),
                        tooltip: 'crop',
                      ),
                      DataColumn(
                        label: Text('Quantity'),
                        tooltip: "received quantity",
                      ),
                      DataColumn(
                        label: Text('Quality'),
                        tooltip: 'crop quality',
                      ),
                      DataColumn(
                        label: Text('Wholesale price'),
                        // tooltip: 'wholesale price',
                      ),
                      DataColumn(
                        label: Text('Retail price'),
                        // tooltip: 'retail price',
                      ),
                    ],
                    rows: stock.myStock
                        .map((data) => DataRow(
                              cells: [
                                DataCell(Text(data.date)),
                                DataCell(Text(data.broker)),
                                DataCell(Text(data.crop)),
                                DataCell(Text(data.quantity.toString())),
                                DataCell(Text(data.quality)),
                                DataCell(Text(data.wholesale.toString())),
                                DataCell(Text(data.retail.toString())),
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