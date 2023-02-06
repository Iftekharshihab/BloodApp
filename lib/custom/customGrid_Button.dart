import 'package:blood_donation_project/utils/colors_resource.dart';
import 'package:flutter/material.dart';

class CustomGrid extends StatelessWidget {
  final Image image;
  final String titel;
  Function onTap;
   CustomGrid({Key? key, required this.image, required this.titel,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:() {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>onTap()));
      },
      child: Column(
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: ColorsResource.COLOR_PRIMARY),
              color: Colors.white,
      ),
      padding: const EdgeInsets.all(23),
      child: image,
    ),
      SizedBox(height: 5,),
        Container(
         height: 20,
        child: Text(titel, style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500, color:Colors.black87),))
        ],
      ),
    );
  }
}
