import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_delivery_app/provider/auth_provider.dart';
import 'package:grocery_delivery_app/widget/custome_Alert.dart';
import 'package:provider/provider.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  bool _passObsecure = true;
  bool _confirmPassObsecure = true;
  String boyEmail = "";
  String boyPassword = "";
  String boyName = "";
  String shopMono = "";
  String shopAddress = "";
  bool isLoading = false;
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtCPassword = TextEditingController();
  TextEditingController txtAddress = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final auth = Provider.of<auth_provider>(context);
    setState(() {
      txtEmail.text = auth.email;
      boyEmail = auth.email;
    });
    Message(message) {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
          ),
        );
      });
    }

    return isLoading
        ? Center(child: CupertinoActivityIndicator(color: Colors.green,animating: true,radius: 20,))
        : Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Your Name";
                        }
                        setState(() {
                          boyName = value;
                        });
                        return null;
                      },
                      cursorColor: Colors.green,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.green,
                          ),
                          hintText: "Name",
                          hintStyle: TextStyle(color: Colors.grey),
                          contentPadding: EdgeInsets.zero,
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.green,
                            ),
                          ),
                          focusColor: Colors.green),
                    ),
                  ), //Name
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value!.length > 10 || value.length < 10) {
                          return "Please Enter Proper Mobile Number";
                        }
                        if (value.isEmpty) {
                          return "Enter Mobile Number";
                        }
                        setState(() {
                          shopMono = value;
                        });

                        return null;
                      },
                      cursorColor: Colors.green,
                      decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                          prefixIcon: Icon(Icons.phone, color: Colors.green),
                          hintText: " Mobile Number",
                          hintStyle: TextStyle(color: Colors.grey),
                          contentPadding: EdgeInsets.zero,
                          enabledBorder: OutlineInputBorder(),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.green,
                            ),
                          ),
                          focusColor: Colors.green),
                    ),
                  ), //Mobile Number
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: TextFormField(
                      readOnly: true,
                      keyboardType: TextInputType.emailAddress,
                      controller: txtEmail,
                      cursorColor: Colors.green,
                      style: TextStyle(color: Colors.grey),
                      decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email, color: Colors.green),
                          contentPadding: EdgeInsets.zero,
                          enabledBorder: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.green,
                            ),
                          ),
                          focusColor: Colors.green),
                    ),
                  ), //email
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: TextFormField(
                      controller: txtPassword,
                      cursorColor: Colors.green,
                      obscureText: _passObsecure,
                      decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _passObsecure = !_passObsecure;
                              });
                            },
                            child: _passObsecure
                                ? Icon(
                                    CupertinoIcons.eye,
                                    color: Colors.grey,
                                  )
                                : Icon(
                                    CupertinoIcons.eye_slash,
                                    color: Colors.grey,
                                  ),
                          ),
                          prefixIcon: Icon(Icons.lock, color: Colors.green),
                          hintText: "New Password",
                          hintStyle: TextStyle(color: Colors.grey),
                          contentPadding: EdgeInsets.zero,
                          enabledBorder: OutlineInputBorder(),
                          border: OutlineInputBorder(),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.green,
                            ),
                          ),
                          focusColor: Colors.green),
                    ),
                  ), //Password
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: TextFormField(
                      controller: txtCPassword,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter confirm password";
                        }
                        if (txtPassword.text != txtCPassword.text) {
                          return 'Password dose not match';
                        }
                        setState(() {
                          boyPassword = value;
                        });
                        return null;
                      },
                      cursorColor: Colors.green,
                      obscureText: _confirmPassObsecure,
                      decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _confirmPassObsecure = !_confirmPassObsecure;
                              });
                            },
                            child: _confirmPassObsecure
                                ? Icon(
                                    CupertinoIcons.eye,
                                    color: Colors.grey,
                                  )
                                : Icon(
                                    CupertinoIcons.eye_slash,
                                    color: Colors.grey,
                                  ),
                          ),
                          prefixIcon: Icon(Icons.lock, color: Colors.green),
                          hintText: " Confirm Password",
                          hintStyle: TextStyle(color: Colors.grey),
                          contentPadding: EdgeInsets.zero,
                          enabledBorder: OutlineInputBorder(),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.green,
                            ),
                          ),
                          focusColor: Colors.green),
                    ),
                  ), //Confirm Password
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: TextFormField(
                      maxLines: 1,
                      keyboardType: TextInputType.streetAddress,
                      controller: txtAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Press Navigation Button";
                        }
                        if (auth.shoplatitude == null) {
                          return "Please Press Navigation Button";
                        }
                        setState(() {
                          shopAddress = value;
                        });
                        return null;
                      },
                      cursorColor: Colors.green,
                      style: TextStyle(color: Colors.grey),
                      decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                          prefixIcon:
                              Icon(Icons.contact_mail, color: Colors.green),
                          suffixIcon: IconButton(
                            onPressed: () {
                              txtAddress.text = 'Locating...\nPlease Wait';
                              auth.getCurrentAddress().then((address) {
                                if (address != null) {
                                  setState(() {
                                    txtAddress.text = '${auth.shopAddress}';
                                  });
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Couldn't find location."),
                                    ),
                                  );
                                }
                              });
                            },
                            icon: Icon(
                              Icons.location_searching,
                              color: Colors.grey,
                            ),
                          ),
                          hintText: " Your Location",
                          hintStyle: TextStyle(color: Colors.grey),
                          enabledBorder: OutlineInputBorder(),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.green,
                            ),
                          ),
                          focusColor: Colors.green),
                    ),
                  ), //address
                  SizedBox(
                    height: size.height / 24,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (auth.ifPicAvail == true) {
                        if (validatePassword(txtPassword.text.trim()) != null) {
                          return CustomAlertDialog(
                            context: context,
                            title: "Password !!  🤷‍♂️️",
                            message:
                                "should contain at least one upper case \nshould contain at least one lower case\nshould contain at least one digit \nshould contain at least one Special character \nmust be at least 8 characters in length",
                            btnText: "OK",
                          );
                        }
                       else if (_formKey.currentState!.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          auth
                              .registerBoy(boyEmail, boyPassword)
                              .then((credential) {
                            log("===========-----> Boy Data Uploaded");
                            auth
                                .uploadBoyImage(auth.image, boyName)
                                .then((url) {
                              log("===========-----> Boy Image Uploaded");
                              if (url != null) {
                                auth.UploadBoyData(
                                  BoyImg: url,
                                  BoyName: boyName,
                                  BoyMobileNumber: "+91${shopMono}",
                                  BoyAddress: shopAddress,
                                  password: boyPassword,
                                );
                                if (mounted) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              } else {
                                Message("Failed to Upload your Pic");
                              }
                            });
                          });
                        } else {
                          Message("Enter proper details");
                        }
                      } else {
                        Message("Your Image is required");
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: size.width,
                      height: size.height / 18,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(size.height / 20),
                      ),
                      child: Text(
                        "Register",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 70,
                  ),
                ],
              ),
            ),
          );
  }

  String? validatePassword(String value) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (value.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Enter valid password';
      } else {
        return null;
      }
    }
  }
}
