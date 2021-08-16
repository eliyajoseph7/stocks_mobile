import 'dart:ui';

import 'package:csdynamics/providers/crops.dart';
import 'package:csdynamics/providers/location.dart';
import 'package:csdynamics/providers/markets.dart';
import 'package:csdynamics/providers/seller.dart';
import 'package:csdynamics/providers/warehouses.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

class InWarehouse extends StatefulWidget {
  InWarehouse({Key? key}) : super(key: key);

  @override
  _InWarehouseState createState() => _InWarehouseState();
}

class _InWarehouseState extends State<InWarehouse> {

  final format = DateFormat("yyyy-MM-dd");

  TextEditingController buyingPrice = new TextEditingController();
  TextEditingController quantity = new TextEditingController();
  TextEditingController cessPayment = new TextEditingController();
  TextEditingController date = new TextEditingController();
  var _formState = GlobalKey<FormState>();

var qualities = [
    "High",
    "Moderate",
    "Low",
    "Unknown",
  ];

  var sources = [
    "Farm",
    "Warehouse",
    "Market",
  ];


  var quality;
  var receivingWarehouseId;
  var source;
  var sourceWarehouseId;
  var sourceMarketId;
  

  var fromWarehouse = false;
  var fromMarket = false;
  var obj;

  
  var sellerId;
  var cropId;
  var regionId;
  var districtId;
  var wardId;
  var villageId;
  @override
  Widget build(BuildContext context) {
    var sellers = Provider.of<SellerProvider>(context);
    var crops = Provider.of<CropProvider>(context);
    var location = Provider.of<LocationProvider>(context);
    var markets = Provider.of<AllMarketsProvider>(context);
    var warehouses = Provider.of<AllWarehouseProvider>(context);
    return Scaffold(
       appBar: AppBar(
         title: Column(
           children: [
             Text("Receive commodities"),
             Text('in warehouse', 
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
               child: Padding(
                 padding: const EdgeInsets.all(5.0),
                 child: Column(
                   children: [
                     
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: DropdownButtonFormField(
                          validator: (value) => value == null ? "This field is required" : null,
                          items: warehouses.warehouses.map((var warehouse) {
                            return new DropdownMenuItem(
                              value: warehouse.id,
                              child: Row(
                                children: <Widget>[
                                  // Icon(Icons.star),
                                  Text(warehouse.name),
                                ],
                              )
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            // do other stuff with warehouse
                            setState(() => receivingWarehouseId = newValue);
                          },
                          value: receivingWarehouseId,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                              filled: true,
                              fillColor: Colors.grey[200],
                              labelText: "Receiving Warehouse",
                          ),
                          isExpanded: false,
                          // hint: Text("Select seller",),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: DropdownButtonFormField(
                          validator: (value) => value == null ? "This field is required" : null,
                          items: sellers.sellers.map((var seller) {
                            return new DropdownMenuItem(
                              value: seller.id,
                              child: Row(
                                children: <Widget>[
                                  // Icon(Icons.star),
                                  Text(seller.name),
                                ],
                              )
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            // do other stuff with seller
                            setState(() {
                              sellerId = newValue;
                              cropId = obj;
                              crops.fetchCrops(this.sellerId.toString());
                            });
                          },
                          value: sellerId,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                              filled: true,
                              fillColor: Colors.grey[200],
                              labelText: "Seller Name",
                              //  hintText: Localization.of(context).category, 
                              //  errorText: errorSnapshot.data == 0 ? Localization.of(context).categoryEmpty : null
                          ),
                          isExpanded: false,
                          // hint: Text("Select seller",),
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
                            print(newValue);
                            setState(() {
                              cropId = newValue;
                            });
                          },
                          value: cropId,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                              filled: true,
                              fillColor: Colors.grey[200],
                              labelText: "Crop",
                          ),
                          isExpanded: false,
                          // hint: Text("Select seller",),
                        ),
                      ),
                      Padding(
                       padding: const EdgeInsets.all(3.0),
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
                          isExpanded: false,
                          // hint: Text("Select seller",),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: TextFormField(
                          validator: (value) => value!.isEmpty ? "This field is required" : null,
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
                        child: TextFormField(
                          validator: (value) => value!.isEmpty ? "This field is required" : null,
                          controller: buyingPrice,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Buying Price",
                            hintText: "Enter buying price",
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
                            filled: false,
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
                            sourceMarketId = obj;
                            sourceWarehouseId = obj;
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
                              fillColor: Colors.grey[50],
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
                            // print(newValue);
                          },
                          value: regionId,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                              filled: true,
                              fillColor: Colors.grey[200],
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
                              fillColor: Colors.grey[50],
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
                              fillColor: Colors.grey[200],
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
                            setState(() {
                              villageId = newValue;
                            });
                          },
                          value: villageId,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                              filled: true,
                              fillColor: Colors.grey[50],
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
                            setState(() => sourceWarehouseId = newValue);
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
                            setState(() => sourceMarketId = newValue);
                          },
                          value: sourceMarketId,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                              filled: true,
                              fillColor: Colors.grey[50],
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
                              decoration: InputDecoration(
                                // icon: Icon(Icons.calendar_today),
                                labelText: 'Date',
                                filled: true,
                                fillColor: Colors.grey[200]
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
                                        'trader_id': this.sellerId,
                                        'quality': this.quality,
                                        'quantity': quantity.text,
                                        'buying_price': buyingPrice.text,
                                        'crop_id': this.cropId,
                                        'warehouse_id': this.receivingWarehouseId,
                                        'village_id': this.villageId,
                                        'ward_id': this.wardId,
                                        'district_id': this.wardId,
                                        'region_id': this.regionId,
                                        'cess_payment': cessPayment.text,
                                        'source': this.source,
                                        'origin_market': this.sourceMarketId,
                                        'origin_warehouse': this.sourceWarehouseId,
                                        'date': date.text
                                      });

                                      // print(data);
                                      warehouses.setLoading();
                                      warehouses.isLoading ?
                                        showAlertDialog(context) : Navigator.pop(context);

                                      warehouses.receiveInWarehouses(data, context);
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
                      ),
                   ],
                 ),
               ),
             ),
           )
         ],
       ),
    );
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