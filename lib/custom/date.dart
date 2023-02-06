import 'package:intl/intl.dart';
import 'package:blood_donation_project/utils/colors_resource.dart';
import 'package:flutter/material.dart';
//----------------------Date function-------------

Future <DateTime?> getDate (BuildContext context)async{

  return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2001,01,01),
      lastDate: DateTime(2030,12,31),
      builder: (BuildContext context, Widget? child){
        return Theme(
          data: ThemeData(
            colorScheme:  ColorScheme.light(
              primary: ColorsResource.RED_DEEP,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      }
  );
}


get_Date(){
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('MM-dd-yyyy').format(now);
  print(formattedDate);
  return  formattedDate;
}

getTime(){
  DateTime now = DateTime.now();
  String formattedTime = DateFormat('hh:mm a').format(now);
  print(formattedTime);
  return  formattedTime;
}



