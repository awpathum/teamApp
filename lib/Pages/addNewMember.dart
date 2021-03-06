import 'dart:io';
import 'dart:math';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:teamapp/Pages/collectionid.dart';
import 'package:teamapp/Pages/home.dart';
import 'dart:async';
import 'package:teamapp/Services/crud.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keyboard/keyboard.dart';
import 'package:teamapp/CustomClass/memberData.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class addNewMember extends StatefulWidget {
  @override
  _addNewMemberState createState() => _addNewMemberState();
}

class _addNewMemberState extends State<addNewMember> {
  crudMethods crudObj = new crudMethods();
  File image;
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  //String _indexNo, _nicNo, _name, _faculty, _telephone,_year;
  final _formKey = GlobalKey<FormState>();
  var indexmemData;
  var useIndex;
  var nicmemeData;
  var useNIC;
  var namememData;
  var useName;
  var facultymemData;
  var useFaculty;
  var telephonememData;
  var useTelephone;
  var yearmemData;
  var useYear;
  var imagememData;
  var useimage;
  var fnamememData;
  var useFname;

  _addNewMemberState() {
    var indexmemeData = new memData();
    useIndex = indexmemeData.indexNo;
    var nicmemeData = new memData();
    useIndex = nicmemeData.nicNo;
    var namememeData = new memData();
    useIndex = namememeData.name;
    var facultymemeData = new memData();
    useIndex = facultymemeData.faculty;
    var telephonememeData = new memData();
    useIndex = telephonememeData.telephone;
    var yearmemeData = new memData();
    useIndex = yearmemeData.year;
    var imagememeData = new memData();
    useIndex = imagememeData.image;
    var fnamememData = new memData();
    useFname = facultymemeData.fname;
  }
  //final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final indexField = TextFormField(
      
      validator: (input) {
        if (input.isEmpty) {
          return 'Please Enter Index Number';
        }
        if (input.substring(0, 2) != '20') {
          return 'Index number not valid';
        }
      },
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Index Number",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
      onSaved: (input) => useIndex = input,
    );

    final nicField = TextFormField(
      validator: (input) {
        if (!input.endsWith('V')) {
          return 'NIC not valid';
        }
      },
      /*{
        if (input.isEmpty) {
          return 'Please Enter NIC Number';
        }
      },*/
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "NIC Number",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
      onSaved: (input) => useNIC = input,
    );

    final nameField = TextFormField(
      validator: (input) {
        if (input.isEmpty) {
          return 'Please Enter The Name';
        }
      },
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Name With Initials",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
      onSaved: (input) => useName = input,
    );
    final fnameField = TextFormField(
      validator: (input) {
        if (input.isEmpty) {
          return 'Please Enter First Name';
        }
      },
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "First Name",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
      onSaved: (input) => useFname = input,
    );

    final facultyField = TextFormField(
      /* validator: (input) {
        if (input.isEmpty) {
          return 'Please Enter The Faculty';
        }
      },*/
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Faculty",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
      onSaved: (input) => useFaculty = input,
    );

    final yearField = TextFormField(
      validator: (input) {
        if (input.isNotEmpty) {
          if (!(input.startsWith('1') ||
              input.startsWith('2') ||
              input.startsWith('3') ||
              input.startsWith('4') ||
              input.startsWith('5'))) {
            return 'Year is not valid';
          }
        }
        /* if (input.isEmpty) {
          return 'Please Enter The Year';
        }
        if (input is String) {
          return ('Please Enter a Valid Year');
        }*/
      },
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Year",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
      onSaved: (input) => useYear = input,
    );

    final telephoneField = TextFormField(
      /* validator: (input) {
        if (input.isEmpty) {
          return 'Please Enter Contact Number';
        }
      },*/
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Telephone",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
      onSaved: (input) => useTelephone = input,
    );

    final submitButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      
      color: Color(0xff8f826b),
      child: FloatingActionButton(
        backgroundColor: Color(0xff8f826b),
        elevation: 5.0,
        onPressed: () {
          final FormState = _formKey.currentState;

          if (FormState.validate()) {
            uploadData();
            
            
            
          }
        },
        child: Icon(Icons.check,color:Colors.white,),
      ),
    );

    final imageField = Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: image == null ? Text('No image selected.') : Image.file(image),
        ),
        Column(
          children: <Widget>[
             Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: IconButton(
            onPressed: getImageFC,
            tooltip: 'Pick Image',
            icon: Icon(Icons.add_a_photo),
            iconSize: 30.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: IconButton(
            onPressed: getImageFG,
            tooltip: 'Pick Image',
            icon: Icon(EvaIcons.imageOutline),
            iconSize: 30.0,
          ),
        ),
          ],
        )
      ],
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            EvaIcons.arrowBackOutline,
          ),
          color: Colors.white,
        onPressed: (){
          Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
        },),
        
        title: Text('Add New Member',style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xff8f826b),
      ),
      floatingActionButton: submitButton,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            color: Colors.white,
            child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 50.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 12.0,
                      ),
                      indexField,
                      SizedBox(
                        height: 45.0,
                      ),
                      nicField,
                      SizedBox(
                        height: 45.0,
                      ),
                      nameField,
                      SizedBox(
                        height: 45.0,
                      ),
                      fnameField,
                      SizedBox(
                        height: 45.0,
                      ),
                      facultyField,
                      SizedBox(
                        height: 45.0,
                      ),
                      yearField,
                      SizedBox(
                        height: 45.0,
                      ),
                      telephoneField,
                      SizedBox(
                        height: 45.0,
                      ),
                      Row(
                        children: <Widget>[
                          imageField,
                          SizedBox(
                            width: 68.0,
                          ),
                         // submitButton,
                        ],
                      )
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }

  Future getImageFC() async {
    File picture = await ImagePicker.pickImage(
        source: ImageSource.camera, maxWidth: 150, maxHeight: 150.0);
    setState(() {
      image = picture;
    });
  }
  Future getImageFG() async {
    File picture = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxWidth: 150, maxHeight: 150.0);
    setState(() {
      image = picture;
    });
  }
  /*Future<String> uploadImage() async {
    final StorageReference ref =
        FirebaseStorage.instance.ref().child('{$useIndex}_profilepic.jpg');
    final StorageUploadTask task = ref.putFile(image);
    StorageTaskSnapshot taskSnapshot = await task.onComplete;
    var dwnurl = await (await task.onComplete).ref.getDownloadURL();
uploadData.url = dwnurl;
    setState(() {
      print('uploaded');
      image = null;
      
    });
    
  }*/

  /*Future<String> uploadImage(var imageFile ) async {
    StorageReference ref = storage.ref().child("/photo.jpg");
    StorageUploadTask uploadTask = ref.putFile(imageFile);

    var dowurl = await (await uploadTask.onComplete).ref.getDownloadURL();
    url = dowurl.toString();

    return url; 
  }*/

  Future uploadData() async {
    // var url;
    _formKey.currentState.save();
    final StorageReference ref =
        FirebaseStorage.instance.ref().child('{$useIndex}_profilepic.jpg');
    final StorageUploadTask task = ref.putFile(image);
    StorageTaskSnapshot taskSnapshot = await task.onComplete;
    var dwnurl = await (await task.onComplete).ref.getDownloadURL();
//url = dwnurl;
   
    print(dwnurl);
    Map<String, dynamic> memberDetails = {
      'IndexNo': this.useIndex,
      'NIC': this.useNIC,
      'Name': this.useName,
      'FirstName': this.useFname,
      'Faculty': useFaculty,
      'Year': this.useYear,
      'Telephone': this.useTelephone,
      'Profilepic': dwnurl,
    };

    Firestore.instance
        .collection('Members')
        .document(this.useIndex)
        .setData(memberDetails)
        .then((result) {
      _formKey.currentState.reset();

      Fluttertoast.showToast(
          msg: "Done",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 16.0);
    }).catchError((e) {
      print(e);
    });

     setState(() {
      print('uploaded');
      image = null;
    });

    /*crudObj.addData(memeberDetails).then((result) {
      _formKey.currentState.reset();
      //add image to firesorage

      //memId.add(this.useIndex);

      

      Fluttertoast.showToast(
          msg: "Done",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 16.0);
    }).catchError((e) {
      print(e);
    });*/
  }
}
