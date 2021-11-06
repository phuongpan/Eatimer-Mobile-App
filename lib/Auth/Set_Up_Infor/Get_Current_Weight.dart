import 'package:eatimer/Auth/Set_Up_Infor/Set_Goal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:google_fonts/google_fonts.dart';

class CurrentWeight extends StatefulWidget {
  const CurrentWeight({Key? key}) : super(key: key);

  @override
  _CurrentWeightState createState() => _CurrentWeightState();
}

class _CurrentWeightState extends State<CurrentWeight> {
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  int currentWeight = 50;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Stack(
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(image: new AssetImage("pictures/background.PNG"), fit: BoxFit.cover,),
              ),
            ),
            new Center(
              child: Column(
                children: [
                  SizedBox(height: 170,),
                  Text("Your Current Weight", style: GoogleFonts.leckerliOne(fontSize:35, color: Colors.black54),),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 135),
                          child:Row(
                            children: [
                              NumberPicker(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    border:Border.all(color:Colors.black54, width: 3) ),
                                value: currentWeight,
                                minValue: 0,
                                maxValue: 200,
                                itemHeight: 120,
                                itemWidth: 120,
                                textStyle: TextStyle(fontSize: 30, color:Colors.black54),
                                selectedTextStyle: TextStyle(color: Colors.black, fontSize: 80, fontWeight: FontWeight.bold,),
                                onChanged: (value) => setState(() => currentWeight = value),
                              ),
                              SizedBox(width: 10,),
                              Text("kg", style: TextStyle(color: Colors.black54,fontSize: 50 ),)
                            ],
                          ),
                        ),

                        SizedBox(height: 25,),
                        ElevatedButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SetGoal(currentWeight: currentWeight,)),);

                            FirebaseDatabase.instance.reference().child('Infor').set({
                              "currentWeight": currentWeight,
                              "goalWeight": 0,
                            }).then((value) {
                              print("Successfully Set Goal");
                            }).catchError((error){
                              print("Failed to set goal"+ error.toString());
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFFFEE5B4),
                            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),),
                          child: Text("Done", style: TextStyle(fontSize: 20, color: Colors.black),),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        )
    );
  }
}
