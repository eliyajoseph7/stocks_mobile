import 'package:csdynamics/providers/buyer.dart';
import 'package:csdynamics/providers/crops.dart';
import 'package:csdynamics/providers/location.dart';
import 'package:csdynamics/providers/markets.dart';
import 'package:csdynamics/providers/seller.dart';
import 'package:csdynamics/providers/warehouses.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OutWarehouse extends StatefulWidget {
  OutWarehouse({Key? key}) : super(key: key);

  @override
  _OutWarehouseState createState() => _OutWarehouseState();
}

class _OutWarehouseState extends State<OutWarehouse> {
  
  final format = DateFormat("yyyy-MM-dd");

  TextEditingController buyingPrice = new TextEditingController();
  TextEditingController quantity = new TextEditingController();
  TextEditingController cessPayment = new TextEditingController();
  TextEditingController product = new TextEditingController();
  TextEditingController date = new TextEditingController();
  var _formState = GlobalKey<FormState>();

  var processed = [
    "Yes",
    "No",
  ];

  var destinations = [
    "Human food",
    "Animal food",
    "Raw material",
    "Export",
    "Warehouse",
    "Market",
  ];

  var regions = [
    "Mara",
    "Dodoma",
    "Mwanza",
  ];

var qualities = [
    "High",
    "Moderate",
    "Low",
    "Unknown",
  ];

  var warehouseId;
  var destination;
  var process;
  var quality;
  var isProcessed = false;
  var towarehouse = false;
  var tomarket = false;
  var obj;

    
  var sellerId;
  var buyerId;
  var cropId;
  var regionId;
  var districtId;
  var wardId;
  var villageId;
  var destWarehouse;
  var destMarket;
  @override
  Widget build(BuildContext context) {
    var sellers = Provider.of<SellerProvider>(context);
    var crops = Provider.of<CropProvider>(context);
    var location = Provider.of<LocationProvider>(context);
    var markets = Provider.of<AllMarketsProvider>(context);
    var warehouses = Provider.of<AllWarehouseProvider>(context);
    var buyers = Provider.of<BuyerProvider>(context);
    return Scaffold(
       appBar: AppBar(
         title: Column(
           children: [
             Text("Release commodities"),
             Text('from warehouse', 
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
                          });
                          crops.fetchCrops(sellerId.toString());
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
                          setState(() => warehouseId = newValue);
                        },
                        value: warehouseId,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                            filled: true,
                            fillColor: Colors.grey[50],
                            labelText: "Releasing Warehouse",
                        ),
                        isExpanded: false,
                        // hint: Text("Select seller",),
                      ),
                    ),

                    
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: DropdownButtonFormField(
                        validator: (value) => value == null ? "This field is required" : null,
                        items: buyers.buyers.map((var buyer) {
                          return new DropdownMenuItem(
                            value: buyer.id,
                            child: Row(
                              children: <Widget>[
                                // Icon(Icons.star),
                                Text(buyer.name),
                              ],
                            )
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          // do other stuff with buyer
                          setState(() {
                            buyerId = newValue;
                          });
                          print(buyerId);
                        },
                        value: buyerId,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                            filled: true,
                            fillColor: Colors.grey[200],
                            labelText: "Buyer Name",
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
                          setState(() => cropId = newValue);
                        },
                        value: cropId,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                            filled: true,
                            fillColor: Colors.grey[50],
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
                        items: processed.map((String process) {
                          return new DropdownMenuItem(
                            value: process,
                            child: Row(
                              children: <Widget>[
                                // Icon(Icons.star),
                                Text(process),
                              ],
                            )
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          // do other stuff with process
                          setState(() => process = newValue);
                          if (newValue == 'Yes') {
                            isProcessed = true;
                          } else {
                            isProcessed = false;
                          }
                        },
                        value: process,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                            filled: true,
                            fillColor: Colors.grey[50],
                            labelText: "Processed?",
                        ),
                        isExpanded: false,
                        // hint: Text("Select seller",),
                      ),
                    ),
                    isProcessed ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 5.0),
                      child: TextFormField(
                        controller: product,
                        decoration: InputDecoration(
                          labelText: "Product",
                          hintText: "Enter end product",
                          labelStyle: TextStyle(fontSize: 15.0, color: Colors.grey[750]),
                          errorStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ) : Container(),

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
                      child: TextFormField(
                        validator: (value) => value == null ? "This field is required" : null,
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
                        items: destinations.map((String destination) {
                          return new DropdownMenuItem(
                            value: destination,
                            child: Row(
                              children: <Widget>[
                                // Icon(Icons.star),
                                Text(destination),
                              ],
                            )
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          // do other stuff with destination
                          destMarket = obj;
                          destWarehouse = obj;
                          setState(() => destination = newValue);
                          if (newValue == 'Warehouse') {
                            tomarket = false;
                            towarehouse = true;
                          }
                          else if (newValue == 'Market') {
                            towarehouse = false;
                            tomarket = true;
                          } else {
                            tomarket = false;
                            towarehouse = false;
                          }
                        },
                        value: destination,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                            filled: true,
                            fillColor: Colors.grey[50],
                            labelText: "Destination",
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
                             destMarket = obj;
                             destWarehouse = obj;
                          });
                          location.fetchDistricts(regionId.toString());
                        },
                        value: regionId,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                            filled: true,
                            fillColor: Colors.grey[200],
                            labelText: "Destination Region",
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
                             destMarket = obj;
                             destWarehouse = obj;
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
                            labelText: "Destination District",
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
                            labelText: "Destination Ward",
                        ),
                        isExpanded: false,
                        // hint: Text("Select seller",),
                      ),
                    ),

                        
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: DropdownButtonFormField(
                        validator: (value) => value == null ? "This field is required" : null,
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
                            fillColor: Colors.grey[50],
                            labelText: "Destination Village",
                        ),
                        isExpanded: false,
                        // hint: Text("Select seller",),
                      ),
                    ),
                    towarehouse ? Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: DropdownButtonFormField(
                        validator: (value) => value == null ? "This field is required" : null,
                        items: warehouses.sourceWarehouses.map((var warehouse) {
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
                          // do other stuff with destwarehouse
                          setState(() => destWarehouse = newValue);
                        },
                        value: destWarehouse,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                            filled: true,
                            fillColor: Colors.grey[200],
                            labelText: "Destination Warehouse",
                        ),
                        isExpanded: false,
                        // hint: Text("Select seller",),
                      ),
                    ): Container(),
                    tomarket ? Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: DropdownButtonFormField(
                        validator: (value) => value == null ? "This field is required" : null,
                        items: markets.sourceMarkets.map((var market) {
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
                          // do other stuff with destmarket
                          setState(() => destMarket = newValue);
                        },
                        value: destMarket,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                            filled: true,
                            fillColor: Colors.grey[50],
                            labelText: "Destination Market",
                        ),
                        isExpanded: false,
                      ),
                    ) : Container(),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 5.0),
                      child: Column(
                        children: [
                          // Text('Basic date field (${format.pattern})'),
                          DateTimeField(
                            format: format,
                            controller: date,
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
                                    restoreDefaults();
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
              )
            )
           )
         ],
       ),
    );
  }

  restoreDefaults() {
    setState(() {
      warehouseId = obj;
      sellerId = obj;
      buyerId = obj;
      cropId = obj;
      process = obj;
      quality = obj;
      quantity.text = '';
      buyingPrice.text = '';
      cessPayment.text = '';
      destination = obj;
      regionId = obj;
      districtId = obj;
      wardId = obj;
      villageId = obj;
      date.text = '';
      product.text = '';
      destMarket = obj;
      destWarehouse = obj;
    });
  }
}