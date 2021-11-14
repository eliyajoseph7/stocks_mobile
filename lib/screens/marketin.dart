import 'dart:convert';

import 'package:csdynamics/providers/broker.dart';
import 'package:csdynamics/providers/crops.dart';
import 'package:csdynamics/providers/location.dart';
import 'package:csdynamics/providers/markets.dart';
import 'package:csdynamics/providers/warehouses.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class InMarket extends StatefulWidget {
  InMarket({Key? key}) : super(key: key);

  @override
  _InMarketState createState() => _InMarketState();
}

class _InMarketState extends State<InMarket> {
  var _formState = GlobalKey<FormState>();
  TextEditingController quantity = new TextEditingController();
  TextEditingController cessPayment = new TextEditingController();
  TextEditingController wholesale = new TextEditingController();
  TextEditingController retail = new TextEditingController();
  TextEditingController date = new TextEditingController();

  final format = DateFormat("yyyy-MM-dd");

  var sources = [
    "Farm",
    "Warehouse",
    "Market",
  ];

  var qualities = [
    "High",
    "Moderate",
    "Low",
    "Unknown",
  ];


  var brokerId;
  var marketId;
  var source;
  var sourceWarehouseId;
  var sourceMarketId;
  var regionId;
  var districtId;
  var wardId;
  var villageId;
  var cropId;
  var quality;
  
  var fromWarehouse = false;
  var fromMarket = false;
  var obj;
  @override
  Widget build(BuildContext context) {
    var brokers = Provider.of<BrokerProvider>(context);
    var crops = Provider.of<CropProvider>(context);
    var location = Provider.of<LocationProvider>(context);
    var markets = Provider.of<AllMarketsProvider>(context);
    var warehouses = Provider.of<AllWarehouseProvider>(context);

    DateTime now = new DateTime.now();
    String formattedDate = format.format(now);
    date.text = formattedDate;
    return Scaffold(
       appBar: AppBar(
         toolbarHeight: 80,
         title: Column(
           children: [
             Text("Crop Stock Dynamics"),
             Text("Receive commodities", 
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
       body: ListView(
         children: [
           Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black,
                        blurRadius: 200.0,
                        spreadRadius: 5.0,
                        // offset: Offset(2.0, 2.0), // shadow direction: bottom right
                    )
                ],
            ),
            child: Form(
              key: _formState,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: DropdownButtonFormField(
                      validator: (value) => value == null ? "This field is required" : null,
                      items: markets.markets.map((var market) {
                        return new DropdownMenuItem(
                          value: market.id,
                          child: Row(
                            children: <Widget>[
                              // Icon(Icons.star),
                              Text(market.name),
                            ],
                          )
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        // do other stuff with market
                        setState(() => marketId = newValue);
                      },
                      value: marketId,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                          filled: true,
                          fillColor: Colors.grey[50],
                          labelText: "Receiving Market"
                      ),
                      isExpanded: false,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: DropdownButtonFormField(
                      validator: (value) => value == null ? "This field is required" : null,
                      items: brokers.brokers.map((var broker) {
                        return new DropdownMenuItem(
                          value: broker.id,
                          child: Row(
                            children: <Widget>[
                              Text(broker.name),
                            ],
                          )
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        // do other stuff with broker
                        setState(() {
                          brokerId = newValue;
                          cropId = obj;
                          crops.fetchCrops(brokerId.toString());
                        });
                      },
                      value: brokerId,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                          filled: true,
                          fillColor: Colors.grey[200],
                          labelText: "Broker Name"
                      ),
                      isExpanded: false,
                    ),
                  ),

                  
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: DropdownButtonFormField(
                      validator: (value) => value == null ? "This field is required" : null,
                      items: crops.crops.map((var crop) {
                        return new DropdownMenuItem(
                          value: crop.id,
                          child: Row(
                            children: <Widget>[
                              // Icon(Icons.star),
                              Text(crop.name),
                            ],
                          )
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        // do other stuff with crop
                        setState(() => cropId = newValue);
                      },
                      value: cropId,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                            filled: true,
                            fillColor: Colors.grey[50],
                            labelText: "Crop",
                        ),
                        // isExpanded: true,
                        // hint: Text("Select seller",),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: TextFormField(
                      validator: (value) => value == null ? "This field is required" : null,
                      controller: quantity,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Quantity (MT)",
                        hintText: "Enter quantity",
                        filled: true,
                        fillColor: Colors.grey[200],
                        labelStyle: TextStyle(fontSize: 15.0, color: Colors.grey[750]),
                        errorStyle: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 5.0),
                    child: DropdownButtonFormField(
                      validator: (value) => value == null ? "This field is required" : null,
                      items: qualities.map((String quality) {
                        return new DropdownMenuItem(
                          value: quality,
                          child: Row(
                            children: <Widget>[
                              // Icon(Icons.star),
                              Text(quality),
                            ],
                          )
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        // do other stuff with quality
                        setState(() => quality = newValue);
                      },
                      value: quality,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                          filled: true,
                          fillColor: Colors.grey[50],
                          labelText: "Quality",
                      ),
                      // isExpanded: false,
                      // hint: Text("Select seller",),
                    ),
                  ),
                      

                      
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 5.0),
                    child: TextFormField(
                      validator: (value) => value == null ? "This field is required" : null,
                      controller: wholesale,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Wholesale Price/Kg (Tsh)",
                        hintText: "Enter wholesale price",
                        filled: true,
                        fillColor: Colors.grey[200],
                        labelStyle: TextStyle(fontSize: 15.0, color: Colors.grey[750]),
                        errorStyle: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ),    
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 5.0),
                    child: TextFormField(
                      validator: (value) => value == null ? "This field is required" : null,
                      controller: retail,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Retail Price/Kg (Tsh)",
                        hintText: "Enter retail price",
                        filled: true,
                        fillColor: Colors.grey[50],
                        labelStyle: TextStyle(fontSize: 15.0, color: Colors.grey[750]),
                        errorStyle: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ),    
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 5.0),
                    child: TextFormField(
                      controller: cessPayment,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "CESS Payment (Tsh)",
                        hintText: "Enter cess payment",
                        filled: true,
                        fillColor: Colors.grey[200],
                        labelStyle: TextStyle(fontSize: 15.0, color: Colors.grey[750]),
                        errorStyle: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ),
                  
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: DropdownButtonFormField(
                      validator: (value) => value == null ? "This field is required" : null,
                      items: sources.map((String source) {
                        return new DropdownMenuItem(
                          value: source,
                          child: Row(
                            children: <Widget>[
                              // Icon(Icons.star),
                              Text(source),
                            ],
                          )
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        // do other stuff with source
                        setState(() => source = newValue);
                        if (newValue == 'Warehouse') {
                          fromMarket = false;
                          fromWarehouse = true;
                        }
                        else if(newValue == 'Market') {
                          fromWarehouse = false;
                          fromMarket = true;
                        } else {
                          fromWarehouse = false;
                          fromMarket = false;
                        }
                      },
                      value: source,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                          filled: true,
                          fillColor: Colors.grey[200],
                          labelText: "Source",
                      ),
                      isExpanded: false,
                      // hint: Text("Select seller",),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: DropdownButtonFormField(
                      validator: (value) => value == null ? "This field is required" : null,
                      items: location.regions.map((var region) {
                        return new DropdownMenuItem(
                          value: region.regionId,
                          child: Row(
                            children: <Widget>[
                              // Icon(Icons.star),
                              Text(region.regionName),
                            ],
                          )
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        // do other stuff with region
                        setState(() {
                          regionId = newValue;
                          districtId = obj;
                          wardId = obj;
                          villageId = obj;
                          sourceMarketId = obj;
                          sourceWarehouseId = obj;
                        });
                          location.fetchDistricts(regionId.toString());
                      },
                      value: regionId,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                          filled: true,
                          fillColor: Colors.grey[50],
                          labelText: "Source Region",
                      ),
                      isExpanded: false,
                      // hint: Text("Select seller",),
                    ),
                  ),

                  
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: DropdownButtonFormField(
                      validator: (value) => value == null ? "This field is required" : null,
                      items: location.districts.map((var district) {
                        return new DropdownMenuItem(
                          value: district.districtId,
                          child: Row(
                            children: <Widget>[
                              // Icon(Icons.star),
                              Text(district.districtName),
                            ],
                          )
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        // do other stuff with district
                        setState(() {
                          districtId = newValue;
                          wardId = obj;
                          villageId = obj;
                          sourceMarketId = obj;
                          sourceWarehouseId = obj;
                        });
                        location.fetchWards(districtId.toString());
                        warehouses.fetchSourceWarehouses(districtId.toString());
                        markets.fetchSourceMarkets(districtId.toString());
                      },
                      value: districtId,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                          filled: true,
                          fillColor: Colors.grey[200],
                          labelText: "Source District",
                      ),
                      isExpanded: false,
                      // hint: Text("Select seller",),
                    ),
                  ),

                  
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: DropdownButtonFormField(
                      validator: (value) => value == null ? "This field is required" : null,
                      items: location.wards.map((var ward) {
                        return new DropdownMenuItem(
                          value: ward.wardId,
                          child: Row(
                            children: <Widget>[
                              // Icon(Icons.star),
                              Text(ward.wardName),
                            ],
                          )
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        // do other stuff with ward
                        setState(() {
                          wardId = newValue;
                          villageId = obj;
                        });
                        location.fetchvillage(wardId.toString());
                      },
                      value: wardId,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                          filled: true,
                          fillColor: Colors.grey[50],
                          labelText: "Source Ward",
                      ),
                      isExpanded: false,
                      // hint: Text("Select seller",),
                    ),
                  ),

                  
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: DropdownButtonFormField(
                      items: location.villages.map((var village) {
                        return new DropdownMenuItem(
                          value: village.villageId,
                          child: Row(
                            children: <Widget>[
                              // Icon(Icons.star),
                              Text(village.villageName),
                            ],
                          )
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        // do other stuff with village
                        setState(() => villageId = newValue);
                      },
                      value: villageId,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                          filled: true,
                          fillColor: Colors.grey[200],
                          labelText: "Source Village",
                      ),
                      isExpanded: false,
                      // hint: Text("Select seller",),
                    ),
                  ),
                  fromWarehouse ? Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: DropdownButtonFormField(
                      items: warehouses.sourceWarehouses.map((var sourceWarehouse) {
                        return new DropdownMenuItem(
                          value: sourceWarehouse.id,
                          child: Row(
                            children: <Widget>[
                              // Icon(Icons.star),
                              Text(sourceWarehouse.name),
                            ],
                          )
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        // do other stuff with sourceWarehouse
                        setState(() {
                          sourceWarehouseId = newValue;
                          sourceMarketId = obj;
                        });
                      },
                      value: sourceWarehouseId,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                          filled: true,
                          fillColor: Colors.grey[200],
                          labelText: "Source Warehouse",
                      ),
                      isExpanded: false,
                      // hint: Text("Select seller",),
                    ),
                  ): Container(),
                  fromMarket ? Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: DropdownButtonFormField(
                      items: markets.sourceMarkets.map((var sourceMarket) {
                        return new DropdownMenuItem(
                          value: sourceMarket.id,
                          child: Row(
                            children: <Widget>[
                              // Icon(Icons.star),
                              Text(sourceMarket.name),
                            ],
                          )
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        // do other stuff with sourceMarket
                        setState(() { 
                          sourceMarketId = newValue;
                          sourceWarehouseId = obj;
                        });
                      },
                      value: sourceMarketId,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                          filled: true,
                          fillColor: Colors.grey[200],
                          labelText: "Source Market",
                      ),
                      isExpanded: false,
                      // hint: Text("Select seller",),
                    ),
                  ) : Container(),
                      
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 5.0),
                    child: Column(
                      children: [
                        // Text('Basic date field (${format.pattern})'),
                        DateTimeField(
                          controller: date,
                          validator: (value) => value == null ? "This field is required" : null,
                          format: format,
                          initialValue: DateTime.now(),
                          decoration: InputDecoration(
                            // icon: Icon(Icons.calendar_today),
                            labelText: 'Date',
                            filled: true,
                            fillColor: Colors.grey[50]
                          ),
                          onShowPicker: (context, currentValue) {
                            return showDatePicker(
                                context: context,
                                firstDate: DateTime(1900),
                                initialDate: currentValue ?? DateTime.now(),
                                lastDate: DateTime.now()
                            );
                          },
                        ),
                      ]
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.green[700],
                                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                                  textStyle: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                  ),
                              ),
                              onPressed: () {
                                if (_formState.currentState!.validate()) {
                                  final data = jsonEncode({
                                    'trader_id': brokerId,
                                    'quality': quality,
                                    'quantity': quantity.text,
                                    'total_price': wholesale.text,
                                    'retail_price': retail.text,
                                    'crop_id': cropId,
                                    'market_id': marketId,
                                    'village_id': villageId,
                                    'ward_id': wardId,
                                    'district_id': districtId,
                                    'region_id': regionId,
                                    'cess_payment': cessPayment.text,
                                    'source': source,
                                    'origin_market': sourceMarketId,
                                    'origin_warehouse': sourceWarehouseId,
                                    'date': date.text
                                  });
                                  markets.setLoading();
                                  markets.isLoading ?
                                    // ignore: unnecessary_statements
                                    showAlertDialog(context) : null;

                                  markets.receiveInMarket(data, context);
                                  // ignore: unnecessary_statements
                                  markets.getMyMarketStock();
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.send),
                                    SizedBox(
                                      width: 12.0,
                                    ),
                                    Text(
                                      'Submit',
                                      textScaleFactor: 1.2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                      ]
                    ),
                  )    
                ],
              ),
            ),
           )
         ],
       ),
    );
  }
   restoreDefaults(AllMarketsProvider market) {
    setState(() {
      marketId = obj;
      brokerId = obj;
      cropId = obj;
      quality = obj;
      quantity.text = obj;
      wholesale.text = obj;
      retail.text = obj;
      cessPayment.text = obj;
      source = obj;
      regionId = obj;
      districtId = obj;
      wardId = obj;
      villageId = obj;
      date.text = obj;
      sourceMarketId = obj;
      sourceWarehouseId = obj;
    });
    // market.setSuccess();
  }

  
  showAlertDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row(
          children: [
              CircularProgressIndicator(),
              Container(margin: EdgeInsets.only(left: 5),child:Text("Loading" )),
          ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }
}