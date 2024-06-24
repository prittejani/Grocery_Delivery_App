import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  CollectionReference boys = FirebaseFirestore.instance.collection("boys");
  CollectionReference orders = FirebaseFirestore.instance.collection("orders");
  CollectionReference users = FirebaseFirestore.instance.collection("users");
  //User? user = FirebaseAuth.instance.currentUser;

  Future<DocumentSnapshot> getUserDetails(id) async {
    DocumentSnapshot doc = await users.doc(id).get();
    return doc;
  }

Future<void>updateStatus({id,status})
{
  return orders.doc(id).update({
    'orderStatus' : status
  });
}

  Future<DocumentSnapshot>validateUser(id) async {
    DocumentSnapshot result = await boys.doc(id).get();
    return result;
  }
}
