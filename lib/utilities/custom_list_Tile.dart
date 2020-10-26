import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget{

  IconData icon;
  String text;
  Function onTap;
  Color color;

  CustomListTile(this.icon,this.text,this.onTap);

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child:InkWell(
        splashColor: Colors.white,
        onTap: onTap,
        child: Container(
          //color: Colors.amber,
          height: 45,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children:<Widget>[
                  Icon(icon,size: 37,color: Colors.white,),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(text,style:TextStyle(
                        fontSize:  20.0,
                        color: Colors.white

                    ),
                    ),
                  ),
                ],
              ),
              Icon(Icons.arrow_right,color: Colors.white,)
            ],
          ),
        ),
      ),

    );
  }
}