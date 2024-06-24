import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:grocery_delivery_app/service/firebase_service.dart';
import 'package:map_launcher/map_launcher.dart';

class OrderService {
  CollectionReference orders = FirebaseFirestore.instance.collection("orders");
  FirebaseService _service = FirebaseService();

  mapLauncher(lat,long, name) async {
    final availableMaps = await MapLauncher.installedMaps;

    await availableMaps.first.showMarker(
      coords: Coords(lat, long),
      title: " ${name} is here ",
    );
  }

  Widget statusContainer(document, context) {
    if (document["deliveryBoy"]["name"].length > 1) {
      if (document["orderStatus"] == "Accepted") {
        return Container(
          color: Colors.grey[300],
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(40, 8, 40, 8),
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                        //side: BorderSide(color: Colors.orangeAccent)
                    )),
                backgroundColor: MaterialStatePropertyAll(
                  statusColor(document),
                ),
              ),
              onPressed: () {
                _service.updateStatus(id: document.id, status: "Pick Up").then((value) {
                  EasyLoading.showSuccess("Order status is now piked up");
                });
              },
              child: Text(
                " Update Status to Picked Up ",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      };
    }
    if (document["orderStatus"] == "Pick Up") {
      return Container(
        color: Colors.grey[300],
        width: MediaQuery.of(context).size.width,
        height: 50,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40, 8, 40, 8),
          child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                      //side: BorderSide(color: Colors.orangeAccent)
                  )),
              backgroundColor: MaterialStatePropertyAll(
                statusColor(document),
              ),
            ),
            onPressed: () {
              _service.updateStatus(id: document.id, status: "On The Way").then((value) {
                EasyLoading.showSuccess("Order status is now on the way");
              });
            },
            child: Text(
              " Update Status to On the Way ",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    };
    if (document["orderStatus"] == 'On The Way') {
      return Container(
        color: Colors.grey[300],
        width: MediaQuery.of(context).size.width,
        height: 50,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40, 8, 40, 8),
          child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                      //side: BorderSide(color: Colors.orangeAccent)
                    )),
              backgroundColor: MaterialStatePropertyAll(
                statusColor(document),
              ),
            ),
            onPressed: () {
              if(document["cod"] == true)
                {
                  return showMyDialog("Receive Payment", "Delivered", document.id, context);
                }
              else
                {
                  EasyLoading.show();
              _service.updateStatus(id: document.id, status: "Delivered").then((value) {
                EasyLoading.showSuccess("Order status is now Delivered. ");
              });
                }
            },
            child: Text(
              'Delivered Ordered',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    };
    if (document["orderStatus"] == 'Delivered') {
      return Container(
        color: Colors.grey[300],
        width: MediaQuery.of(context).size.width,
        height: 50,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40, 8, 40, 8),
          child: ElevatedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                      //side: BorderSide(color: Colors.orangeAccent)
                    )),
              backgroundColor: MaterialStatePropertyAll(
                statusColor(document),
              ),
            ),
            onPressed: () {
              if(document["cod"] == true)
                {
                  return showMyDialog("Receive Payment", "Delivered", document.id, context);
                }
              else
                {
                  EasyLoading.show();
              _service.updateStatus(id: document.id, status: "Delivered").then((value) {
                EasyLoading.showSuccess("Order status is now Delivered. ");
              });
                }
            },
            child: Text(
              'Order Delivered',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    };

      return Container(
        color: Colors.grey[300],
        width: MediaQuery.of(context).size.width,
        height: 40,
        child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                    side: BorderSide(color: Colors.green),
                )),
            backgroundColor: MaterialStatePropertyAll(
              Colors.green,
            ),
          ),
          onPressed: () {
          },
          child: Text(
            'Pending',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
  }

  showMyDialog(title, status, documentId, context) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Text("Make sure you have receive payment."),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    EasyLoading.show();
                    _service.updateStatus(id:documentId,status: "Delivered").then((value) {
                    EasyLoading.showSuccess("Order status is now Delivered");
                    Get.back();
                    });
                  },
                  child: Center(
                    child: Text(
                      "Receive",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Center(
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  Future<void> updateOrderStatus(documentId, status) {
    var result = orders.doc(documentId).update({
      "orderStatus": status,
    });
    return result;
  }

  Color? statusColor(DocumentSnapshot document) {
    if (document['orderStatus'] == "Accepted") {
      return Color(0xffE4DEAE);
    }
    if (document['orderStatus'] == "Rejected") {
      return Colors.red;
    }
    if (document['orderStatus'] == "Pick Up") {
      return Color(0xff8eb15c);
    }
    if (document['orderStatus'] == "Delivered") {
      return Colors.green;
    }
    if (document['orderStatus'] == "On The Way") {
      return Color(0xff5cc593);
    }
    return Color(0xffB7BF96);
  }
  Icon? statusIcon(DocumentSnapshot document) {
    if (document['orderStatus'] == "Accepted") {
      return Icon(Icons.assignment_turned_in_outlined,color: statusColor(document),);
    }
    if (document['orderStatus'] == "Rejected") {
      return Icon(Icons.cases_sharp,color: statusColor(document),);
    }
    if (document['orderStatus'] == "Pick Up") {
      return Icon(Icons.delivery_dining,color: statusColor(document),);
    }
    if (document['orderStatus'] == "Delivered") {
      return Icon(Icons.shopping_bag_outlined,color: statusColor(document),);
    }
    if (document['orderStatus'] == "On The Way") {
      return Icon(Icons.assignment_turned_in_outlined,color: statusColor(document),);
    }
    return Icon(Icons.assignment_turned_in_outlined,color: statusColor(document),);
  }
}
