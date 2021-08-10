import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OutMarket extends StatefulWidget {
  OutMarket({Key? key}) : super(key: key);

  @override
  _OutMarketState createState() => _OutMarketState();
}

class _OutMarketState extends State<OutMarket> {
    
  final format = DateFormat("yyyy-MM-dd");

  TextEditingController buyingPrice = new TextEditingController();
  TextEditingController quantity = new TextEditingController();
  TextEditingController cessPayment = new TextEditingController();
  TextEditingController product = new TextEditingController();
  TextEditingController date = new TextEditingController();
  var _formState = GlobalKey<FormState>();

  
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

var buyers = [
    "Kamba Mtale",
    "Pedro Santo",
    "Paco Peter",
    "Kambona Elisante",
  ];


var crops = [
    "Maize",
    "Millet",
    "Soghum",
    "Rice",
  ];
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
   var destwarehouses = [
    "Utegi",
    "Ngara",
    "Mazimbu",
    "Kyela",
  ];
  
  var destmarkets = [
    "Kitenga",
    "Randa",
    "Nyamaguku",
  ];

  var regions = [
    "Mara",
    "Dodoma",
    "Mwanza",
  ];

  var districts = [];
  var wards = [];
  var villages = [];

  var broker;
  var market;
  var buyer;
  var crop;
  var process;
  var destination;
  var destwarehouse;
  var destmarket;
  var region;
  var district;
  var ward;
  var village;
  var isProcessed = false;
  var towarehouse = false;
  var tomarket = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Column(
           children: [
             Text("Release commodities"),
             Text('from primary market', 
              style: TextStyle(
                fontWeight: FontWeight.w100,
                fontSize: 15
              )
            )
           ],
         ),
       ),

      //  body: Center(child: Text("Page under construction"),),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Container(
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
                              labelText: "Releasing market",
                          ),
                          isExpanded: false,
                          // hint: Text("Select seller",),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: DropdownButtonFormField(
                          items: buyers.map((String buyer) {
                            return new DropdownMenuItem(
                              value: buyer,
                              child: Row(
                                children: <Widget>[
                                  // Icon(Icons.star),
                                  Text(buyer),
                                ],
                              )
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            // do other stuff with buyer
                            setState(() => buyer = newValue);
                          },
                          value: buyer,
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
                          isExpanded: false,
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
                        child: TextFormField(
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
                        padding: const EdgeInsets.all(3.0),
                        child: DropdownButtonFormField(
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
                              fillColor: Colors.grey[200],
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
                              fillColor: Colors.grey[200],
                              labelText: "Destination",
                          ),
                          isExpanded: false,
                          // hint: Text("Select seller",),
                        ),
                      ),
                      towarehouse ? Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: DropdownButtonFormField(
                          items: destwarehouses.map((String destwarehouse) {
                            return new DropdownMenuItem(
                              value: destwarehouse,
                              child: Row(
                                children: <Widget>[
                                  // Icon(Icons.star),
                                  Text(destwarehouse),
                                ],
                              )
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            // do other stuff with destwarehouse
                            setState(() => destwarehouse = newValue);
                          },
                          value: destwarehouse,
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
                          items: destmarkets.map((String destmarket) {
                            return new DropdownMenuItem(
                              value: destmarket,
                              child: Row(
                                children: <Widget>[
                                  // Icon(Icons.star),
                                  Text(destmarket),
                                ],
                              )
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            // do other stuff with destmarket
                            setState(() => destmarket = newValue);
                          },
                          value: destmarket,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                              filled: true,
                              fillColor: Colors.grey[50],
                              labelText: "Destination Market",
                          ),
                          isExpanded: false,
                          // hint: Text("Select seller",),
                        ),
                      ) : Container(),
                      

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
                              labelText: "Destination Region",
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
                              labelText: "Destination District",
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
                              labelText: "Destination Ward",
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
                              labelText: "Destination Village",
                          ),
                          isExpanded: false,
                          // hint: Text("Select seller",),
                        ),
                      ),

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
                )
              ),
            ),
          )
        ],
      ),
    );
  }
}