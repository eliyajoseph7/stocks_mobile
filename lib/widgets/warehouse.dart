import 'package:csdynamics/screens/warehousein.dart';
import 'package:csdynamics/screens/warehouseout.dart';
import 'package:flutter/material.dart';

class Warehouse extends StatelessWidget {
  const Warehouse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            InWarehouse()));
              },
              child: Card(
              //  color: Colors.blueGrey[50],
              elevation: 2,
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15)
                )
                ),
              child: SizedBox(
                height: 120,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Text(
                          "Receive in warehouse",
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.arrow_circle_down,
                          size: 48.0,
                        ),
                      )
                    ]
                  ),
                ),
              ),
              ),
            ),
          ),
          Flexible(
          child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            OutWarehouse()));
              },
            child: Card(
              elevation: 2,
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15)
                )
                ),
              child: SizedBox(
                // height: MediaQuery.of(context).size.height * 0.15,
                height: 120,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Text(
                          "Release from warehouse",
                          style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.arrow_circle_up,
                          size: 48.0,
                        ),
                      )
                    ]
                  ),
                ),
              ),
              ),
          ),
          )
      ],
    );
  }
}
