import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  final format = DateFormat("yyyy-MM-dd");

var brokers = [
    "Kamba Mtale",
    "Pedro Santo",
    "Paco Peter",
    "Kambona Elisante",
  ];

var markets = [
    "Utegi",
    "Ngara",
    "Mazimbu",
    "Kyela",
  ];

  var sources = [
    "Farm",
    "Warehouse",
    "Market",
  ];
  var waresources = [
    "Majengo",
    "Begi",
    "Mtana",
  ];
  var marketsources = [
    "Kitenga",
    "Randa",
    "Nyamaguku",
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

  
var crops = [
    "Maize",
    "Millet",
    "Soghum",
    "Rice",
  ];

  var districts = [];
  var wards = [];
  var villages = [];
  var broker;
  var market;
  var source;
  var sourceWarehouse;
  var sourceMarket;
  var region;
  var district;
  var ward;
  var village;
  var crop;
  var quality;
  
  var fromWarehouse = false;
  var fromMarket = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Column(
           children: [
             Text("Receive commodities"),
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
                      items: markets.map((String market) {
                        return new DropdownMenuItem(
                          value: market,
                          child: Row(
                            children: <Widget>[
                              // Icon(Icons.star),
                              Text(market),
                            ],
                          )
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        // do other stuff with market
                        setState(() => market = newValue);
                      },
                      value: market,
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
                      items: brokers.map((String broker) {
                        return new DropdownMenuItem(
                          value: broker,
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.star),
                              Text(broker),
                            ],
                          )
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        // do other stuff with broker
                        setState(() => broker = newValue);
                      },
                      value: broker,
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
                      items: crops.map((String crop) {
                        return new DropdownMenuItem(
                          value: crop,
                          child: Row(
                            children: <Widget>[
                              // Icon(Icons.star),
                              Text(crop),
                            ],
                          )
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        // do other stuff with crop
                        setState(() => crop = newValue);
                      },
                      value: crop,
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
                      items: regions.map((var region) {
                        return new DropdownMenuItem(
                          value: region,
                          child: Row(
                            children: <Widget>[
                              // Icon(Icons.star),
                              Text(region),
                            ],
                          )
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        // do other stuff with region
                        setState(() => region = newValue);
                      },
                      value: region,
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
                      items: districts.map((var district) {
                        return new DropdownMenuItem(
                          value: district,
                          child: Row(
                            children: <Widget>[
                              // Icon(Icons.star),
                              Text(district),
                            ],
                          )
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        // do other stuff with district
                        setState(() => district = newValue);
                      },
                      value: district,
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
                      items: wards.map((var ward) {
                        return new DropdownMenuItem(
                          value: ward,
                          child: Row(
                            children: <Widget>[
                              // Icon(Icons.star),
                              Text(ward),
                            ],
                          )
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        // do other stuff with ward
                        setState(() => ward = newValue);
                      },
                      value: ward,
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
                      items: villages.map((var village) {
                        return new DropdownMenuItem(
                          value: village,
                          child: Row(
                            children: <Widget>[
                              // Icon(Icons.star),
                              Text(village),
                            ],
                          )
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        // do other stuff with village
                        setState(() => village = newValue);
                      },
                      value: village,
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
                      items: waresources.map((String sourceWarehouse) {
                        return new DropdownMenuItem(
                          value: sourceWarehouse,
                          child: Row(
                            children: <Widget>[
                              // Icon(Icons.star),
                              Text(sourceWarehouse),
                            ],
                          )
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        // do other stuff with sourceWarehouse
                        setState(() => sourceWarehouse = newValue);
                      },
                      value: sourceWarehouse,
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
                      items: marketsources.map((String sourceMarket) {
                        return new DropdownMenuItem(
                          value: sourceMarket,
                          child: Row(
                            children: <Widget>[
                              // Icon(Icons.star),
                              Text(sourceMarket),
                            ],
                          )
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        // do other stuff with sourceMarket
                        setState(() => sourceMarket = newValue);
                      },
                      value: sourceMarket,
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
                          format: format,
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
}