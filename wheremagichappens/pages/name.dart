//  will ask use for their name here

import 'package:shotput/controllers/databse.dart';
import 'package:shotput/pages/homepage.dart';
import 'package:flutter/material.dart';

class YourName extends StatefulWidget {
  const YourName({Key? key}) : super(key: key);

  @override
  _YourNameState createState() => _YourNameState();
}

class _YourNameState extends State<YourName> {
  //
  JDSInfo dbHelper = JDSInfo();

  String name = "";

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      //
      backgroundColor: Color(0xffe2e7ef),
      //
      body: Padding(
        padding: const EdgeInsets.all(
          12.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(
                  12.0,
                ),
              ),
              padding: EdgeInsets.all(
                16.0,
              ),
              child: Image.asset(
                "assets/logologo.png",
                width: 250.0,
                height: 250.0,
              ),
            ),
            //
            SizedBox(
              height: 20.0,
            ),
            //
            Text(
              "What's Yo Name",
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w200,
              ),
            ),
            //
            SizedBox(
              height: 20.0,
            ),
            //
            Container(
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(
                  12.0,
                ),
              ),
              padding: EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Your Name",
                  border: InputBorder.none,
                ),
                style: TextStyle(
                  fontSize: 20.0,
                ),
                maxLength: 50,
                onChanged: (val) {
                  name = val;
                },
              ),
            ),
            //
            SizedBox(
              height: 20.0,
            ),
            //
            SizedBox(
              height: 50.0,
              child: ElevatedButton(
                onPressed: () async {
                  if (name.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        action: SnackBarAction(
                          label: "OK",
                          onPressed: () {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          },
                        ),
                        backgroundColor: Colors.white,
                        content: Text(
                          "Please Enter a name",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    );
                  } else {
                    JDSInfo dbHelper = JDSInfo();
                    await dbHelper.addName(name);
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                  }
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        12.0,
                      ),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Input Data!",
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Icon(
                      Icons.arrow_right_alt,
                      size: 24.0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
