import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:queries/collections.dart';
import 'package:teamapp/Pages/collectionid.dart';
import 'package:queries/queries.dart';

import 'package:sortedmap/sortedmap.dart';

class check extends StatefulWidget {
  @override
  _checkState createState() => _checkState();
}

List<dynamic> allId = List<dynamic>();
List<String> keys = List<String>();
List<int> vals = List<int>();
int run = 0;

/* initSate(){
    getDetails();
    print('Done');
 }*/

class _checkState extends State<check> {
  TextStyle style = TextStyle(
      fontFamily: 'Montserrat', fontSize: 20.0, color: Colors.black54);
  @override
  Widget build(BuildContext context) {
    //getDetails();
    //countId();

    final div = Divider(
      height: 15.0,
      color: Colors.grey[400],
    );
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Recode Book', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xff779fa1),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(
                  width: 5.0,
                ),
                /*FlatButton(
                    color: Colors.amber,
                    child: Text('Change Order'),
                    onPressed: () {
                      setState(() {
                        print('ASC');
                      });
                    }),*/
                SizedBox(
                  width: 50.0,
                ),
              ],
            ),
            Flexible(
              child: Container(
                child: FutureBuilder(
                  future: getDetails(),
                  builder: (contetx, AsyncSnapshot<Map<String, int>> snapshot) {
                    /* if (snapshot.hasData) {
                      return Text('${snapshot.data.length}');
                    } else if (snapshot.hasData) {
                      print('Error');
                    }*/
                    print('future builder');

                    if (snapshot.hasData) {
                      return Container(
                          child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 200.0,
                          ),
                          Text(
                            ' had no practices',
                          ),
                        ],
                      ));
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else {
                      print('#');

                      return Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              FlatButton(
                                  color: Colors.amber,
                                  child: Text('Change Order'),
                                  onPressed: () {
                                    setState(() {
                                      print('ASC');
                                    });
                                  }),
                              SizedBox(
                                width: 50.0,
                              ),
                              Chip(
                                avatar: CircleAvatar(
                                  backgroundColor: Colors.grey.shade800,
                                  child: Text(pracDays.length.toString()),
                                ),
                                label: Text('Total Practice Days'),
                              ),
                            ],
                          ),
                          ListView.builder(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: allId
                                  .length, //((snapshot.data.values.join("").length)/2).toInt(),
                              itemBuilder: (context, index) {
                                print(index);
                                return Center(
                                    child: Column(
                                  children: <Widget>[
                                    ListTile(
                                      title: Text(newMapx.keys.toList()[index]),
                                      subtitle: Center(
                                        child: Row(
                                          children: <Widget>[
                                            SizedBox(width: 270.0),
                                            Text(newMapx.values
                                                .toList()[index]
                                                .toString()),
                                          ],
                                        ),
                                      ), //snapshot data should dispaly in this text field
                                    ),
                                    div,
                                  ],
                                )

                                    /*ListTile(
                                  
                                  title: Text(dayCount.keys.toList()[index] +
                                      "     " +
                                      dayCount.values
                                          .toList()[index]
                                          .toString()), //snapshot data should dispaly in this text field
                                ),*/
                                    );
                              }),
                        ],
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  setDec() {}

/*  Future<Map<String, int>> countId() async {
    print('count id');
    print(memId);
    print('#');
    int lenMem = memId.length; //members who came practice
    int lenAll = allId.length; //all members
    int c = 0;
    print(lenMem);
    print(lenAll);

    if (run <= memId.length) {
      for (int i = 0; i < lenAll; i++) {
        print('outer for loop');
        for (int j = 0; j < lenMem; j++) {
          print('inner for loop');
          if (allId[i] == memId[j]) {
            print('if statement');
            c++;
          } else {
            print('else statement');
          }
        }
        dayCount[allId[i]] = c;
        print(c);
        c = 0;
      }
    }

    print(dayCount);
    // uploadData();
    keys = dayCount.keys.toList();
    vals = dayCount.values.toList();

    setState(() {
      //getList();
    });
    return (dayCount);
  }*/

  Future<Map<String, int>> getDetails() async {
    print('get details');
    dayCount.clear();
    allId.clear();
    memId.clear();
    pracDays.clear();
    print(dayCount);
    var firestore = Firestore.instance;

    QuerySnapshot memsnap =
        await firestore.collection('RecodeBook').getDocuments();
    print('&');
    int count = memsnap.documents.length;
    print(count);

    QuerySnapshot querySnapshot2 =
        await Firestore.instance.collection("Members").getDocuments();
    var list2 = querySnapshot2.documents;
    list2.forEach((f) {
      allId.add(f.documentID);
      // allId = allId.toSet().toList();
      print(allId);
    });
    print(allId);
    QuerySnapshot querySnapshot =
        await Firestore.instance.collection("RecodeBook").getDocuments();
    var list = querySnapshot.documents;
    list.forEach((f) {
      pracDays.add(f.documentID);
    });
    print(pracDays);
    count = pracDays.length;
    for (int i = 0; i < count; i++) {
      print('1st for loop');

      print(pracDays[i]);

      await Firestore.instance
          .collection('RecodeBook')
          .document(pracDays[i])
          .get()
          .then((DocumentSnapshot ds) {
        print(ds.exists);
        print(ds['Names']);
        newList = List.from(ds['Index']);
        print(newList);
        memId.addAll(newList);
        newList.clear();
        print(allId);
      }).catchError((e) {
        print(e);
      });
      //print(allId.length);
    }

    countID();
  }

  countID() {
    print('count id');
    print(memId);
    // print('#');
    int lenMem = memId.length; //members who came practice
    int lenAll = allId.length; //all members
    int c = 0;
    print(lenMem);
    print(lenAll);

    for (int i = 0; i < lenAll; i++) {
      print('outer for loop');
      for (int j = 0; j < lenMem; j++) {
        print('inner for loop');
        if (allId[i] == memId[j]) {
          print('if statement');
          c++;
        } else {
          print('else statement');
        }
      }
      dayCount[allId[i]] = c;
      print(allId);
      print(memId);
      print('C is ');
      print(c);
      c = 0;
    }

    print(dayCount);
    // uploadData();
    keys = dayCount.keys.toList();
    vals = dayCount.values.toList();
// var map = new SortedMap((Pair a, Pair b)=>Comparable.compare(a.value, b.value));

    //dayCount = sortMap(dayCount);
    //dayCount = sortMap(dayCount);

    var sortedEntries = dayCount.entries.toList()
      ..sort((e1, e2) {
        var diff = e2.value.compareTo(e1.value);
        if (diff == 0) diff = e2.key.compareTo(e1.key);
        return diff;
      });

    var newMap = Map<String, int>.fromEntries(sortedEntries);
    newMapx = newMap;
    print('Printing new map');
    print(newMap);

    //for (var entry in sortedEntries) { dayCount..remove(entry.key)..[entry.key] = entry.value; }

    if (run == 1) {
      run = 0;
      setAsc();
      return newMapx;
    }
    run = 1;
    return newMap;
  }

  setAsc() {
    // final reverseM = LinkedHashMap.fromEntries(m.entries.reversed);
    dayCount.clear();

    int len = newMapx.length;
    reversed = newMapx;
    //print(newMapx.length);
    for (int i = 0; i < len; i++) {
      print(reversed);
      String x = reversed.entries.last.key.toString();
      int y = reversed.entries.last.value;
      dayCount[x] = y;
      reversed.remove(x);
      print(reversed);
    }
    print('Day Count');
    print(dayCount);
    newMapx = dayCount;
    return newMapx;

/*if (run == 1) {
        dayCount.clear();
        int len = newMapx.length;
        reversed = newMapx;
        newMapx.clear();
        //print(newMapx.length);
        for (int i = 0; i < len; i++) {
          print(reversed);
          String x = reversed.entries.last.key.toString();
          int y = reversed.entries.last.value;
          newMapx[x] = y;
          reversed.remove(x);
          print(reversed);
        }
        run = 0;
}*/
    /*setState(() {
      
      newMapx = dayCount;
    });*/
  }

  /* sortMap(Map dayCount){
    print('sort map');
    print(dayCount);
    List vals = dayCount.values.toList();//sort((dynamic a, dynamic b) => a.compareTo(b));
    List keys = dayCount.keys.toList();
    vals.sort((dynamic a, dynamic b)=>a.compareTo(b)); 
    keys.sort((dynamic a, dynamic b)=>a.compareTo(b)); 
    Map<String,int> newmap;
    print(dayCount.length);
    for(int i = 0; i < dayCount.length; i++){
      print('!');
      for(int j = 0; j < dayCount.length; j++){
        print('!!');
        print(dayCount[j]);
        if(vals[i] == dayCount[j].value){
          newmap[dayCount[j].key] = vals[i]; 
          print('*');
        }
        print('+');
      }
      
    }
    print(newmap);
    print('new amp printed');
  }*/

  /* sortMap(Map _map) {
    print(_map);
    var map = Dictionary.fromMap(_map)
        .orderByDescending((kv) => kv.value)
        .thenByDescending((kv) => kv.key)
        .toDictionary$1((kv) => kv.key, (kv) => kv.value)
        .toMap();
    print(map);
    
    return map;
  }*/

  /* Future uploadData() async {
    Firestore.instance
        .collection('Attendance')
        .document('xyz')R
        .setData(dayCount)
        .then((result) {})
        .catchError((e) {
      print(e);
    });

  }*/
/*Future getPosts() async {
    var firestore = Firestore.instance;
    //firestore.collection('teamapp').orderBy(DocumentReference());  // order colllection as Name
    QuerySnapshot qn = await firestore.collection('Attendance').getDocuments();
    
    return qn.documents;
}*/

  /* Future<List<String>> getList() async {
      print('get list');
    var firestore = Firestore.instance;
   // Map<dynamic, List<dynamic>> info = Map<dynamic, List<dynamic>>();
   List<String> info = List<String>();
    DocumentReference docRef =
        await firestore.collection('Attendance').document('xyz');
print('&');
    return docRef.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        for(int i = 0;i < allId.length;i++){
          String id = datasnapshot.data[allId[i]].toString();
        print(id);
        info.add(id);
        }
        
       // String name = datasnapshot.data[""].toList();
        
        print('#');
        print(info);
        print(info.length);
        info.sort();
        info = info.reversed.toList();

        //count = name.length;
        return info;
      }
    });
    }*/
}
