import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_delivery_app/service/order_service.dart';
import 'package:intl/intl.dart';

class MyOrderScreen extends StatelessWidget {
  final DocumentSnapshot document;

  const MyOrderScreen({super.key, required this.document});

  @override
  Widget build(BuildContext context) {
    OrderService _orderService = OrderService();
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 14,
              child: Icon(
                CupertinoIcons.square_list,
                color: _orderService.statusColor(document),
                size: 18,
              ),
            ),
            title: Text(
              document["orderStatus"],
              style: TextStyle(
                  fontSize: 12,
                  color: _orderService.statusColor(document),
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              "On ${DateFormat.yMMMd().format(
                DateTime.parse(document["timestamp"]),
              )}",
              style: TextStyle(fontSize: 12),
            ),
            trailing: Text(
              "Amount : \₹${document["total"].toStringAsFixed(0)}",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ExpansionTile(
            title: Text(
              "Order Details",
              style: TextStyle(fontSize: 10),
            ),
            subtitle: Text(
              "View order Details",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            children: [
              ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Image.network(
                          document["products"][index]["productImage"]),
                    ),
                    title: Text(
                      document["products"][index]["productName"],
                      style: TextStyle(fontSize: 12),
                    ),
                    subtitle: Text(
                      "${document["products"][index]["qty"]} X \₹${document["products"][index]["price"].toStringAsFixed(0)} = \₹${document["products"][index]["total"].toStringAsFixed(0)}",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Amount : \₹${document["total"].toStringAsFixed(0)} ",
                          style:
                              TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        Text(
                          "Payment Type : \₹${document["cod"] == true ? "COD" : " Pay Online"} ",
                          style:
                              TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: document["products"].length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 12,
                  right: 12,
                  bottom: 8,
                  top: 8,
                ),
                child: Card(
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Seller : ",
                              style: TextStyle(fontSize: 12),
                            ),
                            Text(
                              document["seller"]["shopName"],
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              "Delivery Fee : ",
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "\₹${document["deliveryFee"].toString()}",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        int.parse(document["discount"]) > 0
                            ? Row(
                                children: [
                                  Text(
                                    "Discount : ",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    document["discount"],
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          Divider(
            height: 3,
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}
