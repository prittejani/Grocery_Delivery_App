import 'package:chips_choice/chips_choice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_delivery_app/provider/order_provider.dart';
import 'package:grocery_delivery_app/service/order_service.dart';
import 'package:grocery_delivery_app/widget/order_summary_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "home-screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  OrderService _orderService = OrderService();
  User? user = FirebaseAuth.instance.currentUser;
  int tag = 0;
  List<String> options = [
    'All Orders',
    'Accepted',
    'Pick Up',
    'On The Way',
    'Delivered',
  ];

  @override
  Widget build(BuildContext context) {
    var _order = Provider.of<OrderProvider>(context);
    return Scaffold(
      backgroundColor: Colors.green.withOpacity(.3),
      appBar: AppBar(
        backgroundColor: Colors.green,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "My Orders",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: Icon(Icons.power_settings_new),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 56,
            width: MediaQuery.of(context).size.width,
            child: ChipsChoice<int>.single(
              choiceStyle: C2ChipStyle.filled(
                foregroundColor: Colors.white,
                color: Colors.grey,
                borderRadius: BorderRadius.all(
                  Radius.circular(3),
                ),
                selectedStyle: C2ChipStyle.filled(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(
                    Radius.circular(3),
                  ),
                ),
              ),
              value: tag,
              onChanged: ((val) {
                if (val == 0) {
                  setState(() {
                    _order.status = "";
                  });
                }
                setState(() {
                  tag = val;
                  _order.filterOrder(options[val]);
                });
              }),
              choiceItems: C2Choice.listFrom<int, String>(
                source: options,
                value: (i, v) => i,
                label: (i, v) => v,
              ),
            ),
          ),
          Container(
            child: StreamBuilder<QuerySnapshot>(
              stream: _orderService.orders
                  .where("deliveryBoy.email", isEqualTo: user?.email)
                  .where("orderStatus",
                      isEqualTo: tag > 0 ? _order.status : null)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CupertinoActivityIndicator(
                    color: Colors.green,
                    animating: true,
                    radius: 20,
                  ));
                }
                if (snapshot.data!.size == 0) {
                  return Expanded(
                    child: Center(
                      child: Text(tag > 0
                          ? "No ${options[tag]} orders"
                          : " No orders continue shopping.."),
                    ),
                  );
                }
                return Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      // Map<String, dynamic> data =
                      //     document.data()! as Map<String, dynamic>;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: new OrderSummaryCard(document: document),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
