import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_delivery_app/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class ShopPicCard extends StatefulWidget {
  const ShopPicCard({super.key});

  @override
  State<ShopPicCard> createState() => _ShopPicCardState();
}

class _ShopPicCardState extends State<ShopPicCard> {
  File? image;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<auth_provider>(context);
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {
          auth.getImage().then((image) {
            setState(() {
              this.image = image;
            });
            if (image != null) {
              auth.ifPicAvail = true;
            }
          });
        },
        child: Container(
          height: size.height / 6,
          width: size.width / 2.8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border(
                right: BorderSide(color: Colors.green),
                top: BorderSide(color: Colors.green),
                bottom: BorderSide(color: Colors.green),
                left: BorderSide(color: Colors.green)),
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(size.width / 80),
              child: image == null
                  ? Center(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.person,
                          size: 50,
                          color: Colors.green,
                        ),
                      ],
                    ))
                  : Container(
                      height: size.height / 6,
                      width: size.width / 2.8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border(
                            right: BorderSide(color: Colors.green),
                            top: BorderSide(color: Colors.green),
                            bottom: BorderSide(color: Colors.green),
                            left: BorderSide(color: Colors.green)),
                        image: DecorationImage(
                          image: FileImage(
                            image!,
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                    )),
        ),
      ),
    );
  }
}
