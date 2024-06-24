import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void CustomAlertDialog(
    {required context, required title, required message, required btnText}) async {
  return showCupertinoDialog(
      context: context,
      builder: (context)
      =>
          CupertinoAlertDialog(
            title: Text(title),
            content: Text(message),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text(btnText,style: TextStyle(color: Colors.green),),
                onPressed: () => Navigator.of(context).pop(false),
              ),
            ],
          ));
  // return showDialog<void>(
  //   context: context,
  //   barrierDismissible: false, // user must tap button!
  //   builder: (BuildContext context) {
  //     return AlertDialog(
  //       backgroundColor: Colors.green,
  //       title:  Text(title,style: TextStyle(color: Colors.white),),
  //       content:  SingleChildScrollView(
  //         child: ListBody(
  //           children: <Widget>[
  //             Text(message,style: TextStyle(color: Colors.white),),
  //             //               //Text('Would you like to approve of this message?'),
  //           ],
  //         ),
  //       ),
  //       actions: <Widget>[
  //         TextButton(
  //           child:  Text(btnText,style: TextStyle(color: Colors.white),),
  //           onPressed: () {
  //             Navigator.of(context).pop();
  //           },
  //         ),
  //       ],
  //     );
  //   },
  // );
}