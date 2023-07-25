import 'package:flutter/material.dart';

Widget myList(BuildContext context,String url,String text) {
  return Container(
    height: MediaQuery.sizeOf(context).height / 7,
    width: double.infinity,
    margin: EdgeInsets.all(15.0),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.black12,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
          Flexible(child: Container(
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              image: DecorationImage(
                image: NetworkImage(url),
                fit: BoxFit.cover
              ),
            ),
          )
        ),
        const SizedBox(width: 20.0,),
        Flexible(
          flex: 2,
          child:Column(
          children: [
            Text(text,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 15),),
          ],
        ))

      ],
    ),
  );
}
