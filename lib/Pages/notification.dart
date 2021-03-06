import 'package:flutter/material.dart';
import 'package:teamapp/Pages/addNewMember.dart';
import 'package:teamapp/Pages/check.dart';
import 'package:teamapp/Pages/createSheet.dart';
import 'package:teamapp/Pages/signIn.dart';
import 'package:teamapp/Pages/viewSheet.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class notification extends StatefulWidget {
  @override
  _notificationState createState() => _notificationState();
}

class _notificationState extends State<notification> {
  TextStyle style =
      TextStyle(fontFamily: 'Montserrat', fontSize: 20.0, color: Colors.white);
  @override
  Widget build(BuildContext context) {
    final createSheet = Material(
      elevation: 4.0,
      borderRadius: BorderRadius.circular(10.0),
      color: Color(0xff564154),
      child: MaterialButton(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40.0,
            ),
            Icon(
              Icons.create,
              color: Colors.white,
              size: 50.0,
            ),
            SizedBox(
              height: 40.0,
            ),
            Text(
              'Create Sheet',
              style: style,
            ),
          ],
        ),
        //minWidth: MediaQuery.of(context).size.width / 2,
        //height: MediaQuery.of(context).size.width / 4,
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => CreateSheet())),
      ),
    );
    final viewSheet = Material(
      elevation: 4.0,
      borderRadius: BorderRadius.circular(10.0),
      color: Color(0xffff8164),
      child: MaterialButton(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40.0,
            ),
            Icon(
              EvaIcons.monitor,
              color: Colors.white,
              size: 50.0,
            ),
            SizedBox(
              height: 40.0,
            ),
            Text(
              'View Sheet',
              style: style,
            ),
          ],
        ),
        //minWidth: MediaQuery.of(context).size.width / 2,
        //height: MediaQuery.of(context).size.width / 4,
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => ViewSheet())),
      ),
    );
    final addMember = Material(
      elevation: 4.0,
      borderRadius: BorderRadius.circular(10.0),
      color: Color(0xff8f826b),
      child: MaterialButton(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40.0,
            ),
            Icon(
              EvaIcons.personAdd,
              color: Colors.white,
              size: 50.0,
            ),
            SizedBox(
              height: 40.0,
            ),
            Text(
              'New Member',
              style: style,
            ),
          ],
        ),
        //minWidth: MediaQuery.of(context).size.width / 2,
        //height: MediaQuery.of(context).size.width / 4,
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => addNewMember())),
      ),
    );
    final checkAttendance = Material(
      elevation: 4.0,
      borderRadius: BorderRadius.circular(10.0),
      color: Color(0xff779fa1),
      child: MaterialButton(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40.0,
            ),
            Icon(
              EvaIcons.checkmarkSquare,
              color: Colors.white,
              size: 50.0,
            ),
            SizedBox(
              height: 40.0,
            ),
            Text(
              'Recode Book',
              style: style,
            ),
          ],
        ),
        //minWidth: MediaQuery.of(context).size.width / 2,
        //height: MediaQuery.of(context).size.width / 4,
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => check())),
      ),
    );
    final viewProfile = Material(
      elevation: 4.0,
      borderRadius: BorderRadius.circular(10.0),
      color: Color(0xff88498f),
      child: MaterialButton(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40.0,
            ),
            Icon(
              EvaIcons.fileText,
              color: Colors.white,
              size: 50.0,
            ),
            SizedBox(
              height: 40.0,
            ),
            Text(
              'View Profile',
              style: style,
            ),
          ],
        ),
        //minWidth: MediaQuery.of(context).size.width / 2,
        //height: MediaQuery.of(context).size.width / 4,
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => addNewMember())),
      ),
    );
    final notifi = Material(
      elevation: 4.0,
      borderRadius: BorderRadius.circular(10.0),
      color: Colors.red[200],
      child: MaterialButton(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40.0,
            ),
            Icon(
              EvaIcons.bell,
              color: Colors.white,
              size: 50.0,
            ),
            SizedBox(
              height: 40.0,
            ),
            Text(
              'Notification',
              style: style,
            ),
          ],
        ),
        //minWidth: MediaQuery.of(context).size.width / 2,
        //height: MediaQuery.of(context).size.width / 4,
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => addNewMember())),
      ),
    );
    /*final viewSheet = MaterialButton(
         child: Text('Done'),
         minWidth: MediaQuery.of(context).size.width / 2,
         height: MediaQuery.of(context).size.width / 4,
         
         onPressed: (){},
       );*/
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Home'),
      ),
      backgroundColor: Colors.white,
      body: CustomScrollView(
        primary: false,
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.all(10.0),
            sliver: SliverGrid.count(
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              crossAxisCount: 2,
              children: <Widget>[
                createSheet,
                viewSheet,
                addMember,
                checkAttendance,
                viewProfile,
                notifi,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
