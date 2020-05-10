import 'package:flutter/material.dart';
import 'package:fluttertictacto/friend_page.dart';
import 'package:fluttertictacto/phone_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tic Tac To',
      theme: ThemeData(
        primaryColor: Colors.black
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void friend (){
    setState(() {
     new  FriendPage();
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Tic Tac To "),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Text("Select Option ",style: TextStyle(
                color: Colors.white,
                fontSize: 24
              ),),
            ),SizedBox(
              height: 20,
            ),
            RawMaterialButton(
              constraints: BoxConstraints.tight(Size(300,50)),
              fillColor: Colors.red,
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => FriendPage()
                ),);
              },
              child: Text("Play With Freind",style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontStyle: FontStyle.italic
              ),),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
              ),

            ),
            SizedBox(
              height: 30,
            ),
            RawMaterialButton(
              constraints: BoxConstraints.tight(Size(300,50)),
               shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(30)
               ),
              fillColor: Colors.red,
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => PhonePage()
                ));
              },
              child: Text("Play with Phone",style: TextStyle(
                  fontSize: 30,
                color: Colors.white,
                fontStyle: FontStyle.italic
              ),),

            ),
      SizedBox(
        height: 200,
      ),
      Container(
        child: Text("                Desined By\nAnas khan*(Software Engineer).",style: TextStyle(
            color: Colors.white,
            fontSize: 20,fontStyle: FontStyle.italic
        ),),)
          ],
        ),
      ),
    );
  }
}

