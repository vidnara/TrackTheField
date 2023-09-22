import 'package:shotput/controllers/databse.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddtrackthefieldNoGradient extends StatefulWidget {
  const AddtrackthefieldNoGradient({Key? key}) : super(key: key);

  @override
  _AddtrackthefieldNoGradientState createState() =>
      _AddtrackthefieldNoGradientState();
}

class _AddtrackthefieldNoGradientState
    extends State<AddtrackthefieldNoGradient> {
  DateTime selectedDate = DateTime.now();
  int? distance;
  String note = "Shot";
  String type = "Discus";

  List<String> months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
      ),
      backgroundColor: Color(0xffe2e7ef),
      //
      body: ListView(
        padding: EdgeInsets.all(
          12.0,
        ),
        children: [
          Text(
            "How Did Your Meet Go?",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          //
          SizedBox(
            height: 20.0,
          ),
          //
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 26, 22, 65),
                  borderRadius: BorderRadius.circular(
                    16.0,
                  ),
                ),
                padding: EdgeInsets.all(
                  12.0,
                ),
                child: Icon(
                  Icons.art_track_sharp,
                  size: 24.0,
                  // color: Colors.grey[700],
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 12.0,
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Distance (Feet) To Nearest Whole Foot",
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                  onChanged: (val) {
                    try {
                      distance = int.parse(val);
                    } catch (e) {
                      // show Error
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          duration: Duration(
                            seconds: 2,
                          ),
                          content: Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 6.0,
                              ),
                              Text(
                                "Enter only Numbers",
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  keyboardType: TextInputType.number,
                  // textAlign: TextAlign.center,
                ),
              ),
            ],
          ),

          //
          SizedBox(
            height: 20.0,
          ),
          //
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 26, 22, 65),
                  borderRadius: BorderRadius.circular(
                    16.0,
                  ),
                ),
                padding: EdgeInsets.all(
                  12.0,
                ),
                child: Icon(
                  Icons.attach_money,
                  size: 24.0,
                  // color: Colors.grey[700],
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 12.0,
              ),
              ChoiceChip(
                label: Text(
                  "Discus",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: type == "Discus" ? Colors.white : Colors.black,
                  ),
                ),
                selectedColor: Color(0xFF1B1642),
                onSelected: (val) {
                  if (val) {
                    setState(() {
                      type = "Discus";
                    });
                  }
                },
                selected: type == "Discus" ? true : false,
              ),
              SizedBox(
                width: 8.0,
              ),
              ChoiceChip(
                label: Text(
                  "Shot Put",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: type == "shotput" ? Colors.white : Colors.black,
                  ),
                ),
                selectedColor: Color.fromARGB(255, 26, 22, 65),
                onSelected: (val) {
                  if (val) {
                    setState(() {
                      type = "shotput";
                    });
                  }
                },
                selected: type == "shotput" ? true : false,
              ),
              SizedBox(
                width: 8.0,
              ),
              ChoiceChip(
                label: Text(
                  "Javelin",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: type == "Javelin" ? Colors.white : Colors.black,
                  ),
                ),
                selectedColor: Color.fromARGB(255, 26, 22, 65),
                onSelected: (val) {
                  if (val) {
                    setState(() {
                      type = "Javelin";
                    });
                  }
                },
                selected: type == "Javelin" ? true : false,
              ),
            ],
          ),
          //
          SizedBox(
            height: 20.0,
          ),
          //
          SizedBox(
            height: 50.0,
            child: TextButton(
              onPressed: () {
                _selectDate(context);

                FocusScope.of(context).unfocus();
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  EdgeInsets.zero,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 26, 22, 65),
                      borderRadius: BorderRadius.circular(
                        16.0,
                      ),
                    ),
                    padding: EdgeInsets.all(
                      12.0,
                    ),
                    child: Icon(
                      Icons.date_range,
                      size: 24.0,
                      // color: Colors.grey[700],
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 12.0,
                  ),
                  Text(
                    "${selectedDate.day} ${months[selectedDate.month - 1]}",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
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
              onPressed: () {
                if (distance != null) {
                  JDSInfo dbHelper = JDSInfo();
                  dbHelper.addData(distance!, selectedDate, type, note);
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red[700],
                      content: Text(
                        "Enter a Proper Amount",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                }
              },
              child: Text(
                "Add",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
