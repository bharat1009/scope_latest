import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:scopeindia/user/dashboard/dashboard.dart';

class Updateuser extends StatefulWidget {
  final String email;
  final String name;
  final String dob;
  final String gender;
  final String phone;
  final String educationQualification;
  final String city;
  final String trainingMode;
  const Updateuser({super.key,
    required this.email,
    required this.name,
    required this.dob,
    required this.gender,
    required this.phone,
    required this.educationQualification,
    required this.city,
    required this.trainingMode,});

  @override
  State<Updateuser> createState() => _UpdateuserState();
}

class _UpdateuserState extends State<Updateuser> {
  final _formkey1=GlobalKey<FormState>();
  var passwordController=TextEditingController();
  var confirmController=TextEditingController();
  var emailController=TextEditingController();

  final _nameController = TextEditingController();
  final _dobController = TextEditingController();
  final _genderController = TextEditingController();
  final _phoneController = TextEditingController();
  final _educationController = TextEditingController();
  final _cityController = TextEditingController();
  final _trainingModeController = TextEditingController();

  String? _trainingmode;
  List<String> courseList = [
    'PHP Full Stack',
    'PYTHON Full Stack',
    'JAVA Full Stack',
    'C#.NET Core 7 Full Stack',
    'MEAN Full Stack',
    'MERN Full Stack',
    'Data Science & Al (Python Guru)',
    'Python Mastery (Python/Django/MySQL)',
    'Google Flutter Mobile App Development (iOS/Android)',
    'UI/UX Designing',
    'Digital Marketing Master Program',
    'Software Testing Advanced (Manual/Automation)',
    'Software Testing Manual (ISTQB)',
    'ISTQB Certification (EXAM Reg.)',
    'Selenium TestNG & Cucumber/Appium Mobile/QTP/Loadrunner/Jmeter/Jira',
    'Computer Networking (CCNA)',
    'Server Admin (MCSE)',
    'Server Admin (RHCE)',
    'Networking & Server Admin (CCNA/MCSE/Hardware)',
    'Networking & Server Admin (CCNA/RHCE/Hardware)',
    'Networking & Server Admin (CCNA/MCSE/RHCE/Hardware)',
    'Security Surveillance & Networking Internship (CCNA/CCTV/Hardware)',
    'Cloud Admin (AWS/MS AZURE)',
    'Cloud & Networking Admin (CCNA/AWS/Hardware)',
    'Cloud & Networking Admin (CCNA/MS Azure/Hardware)',
    'Cloud & Networking Admin (CCNA/AWS)',
    'Cloud & Networking Admin (CCNA/MS Azure)',
    'Cloud & Server Admin (MCSE/AWS/Hardware)',
    'Cloud & Server Admin (MCSE/MS Azure/Hardware)',
    'Cloud & Server Admin (RHCE/AWS/Hardware)',
    'Cloud & Server Admin (RHCE/MS Azure/Hardware)',
    'Cloud, Networking, & Server Admin (CCNA/AWS/AZURE/MCSE/RHCE/Hardware)',
    'DevOps Mastery (All together)',
    'DevOps - Selective',
    'Academic Project',
    'MS Office (Word/Excel/Power Point/Outlook)',
    'Data Analytics',
    'Advanced MS Excel',
    'Graphic Designing (Photoshop)',
    'Graphic Designing (Photoshop/Illustrator)',
    'None of the above, will discuss directly',
  ];

  List<String> selectedCourses = [];


  var undo=0;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;


  // Future<void> _deleteUser() async {
  //   try {
  //     User? user = FirebaseAuth.instance.currentUser;
  //     if (user != null) {
  //       // Delete user data from Firestore
  //       await firestore.collection('User Register').doc(user.uid).delete();
  //       // Delete user from Firebase Authentication
  //       await user.delete();
  //       // Show success message
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text('User account and data deleted successfully')),
  //       );
  //     }
  //   } catch (e) {
  //     // Show error message
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Failed to delete user: $e')),
  //     );
  //   }
  // }



  @override
  void initState() {
    super.initState();

    _nameController.text = widget.name;
    _dobController.text = widget.dob;
    _genderController.text = widget.gender;
    _phoneController.text = widget.phone;
    _educationController.text = widget.educationQualification;
    _cityController.text = widget.city;
    _trainingModeController.text = widget.trainingMode;
  }

  // Future<void> _updateData() async {
  //   try {
  //     // Get the current Firebase user
  //     User? user = FirebaseAuth.instance.currentUser;
  //     if (user != null) {
  //       // Fetch the current data from Firestore for the user to check previous values
  //       DocumentSnapshot userDoc = await firestore.collection('Registration data').doc(user.uid).get();
  //       Map<String, dynamic>? data = userDoc.data() as Map<String, dynamic>?;
  //
  //       // Get previous values from Firestore (if they exist)
  //       String previousPhone = data?['phone'] ?? '';
  //       String previousEducationQualification = data?['educationQualification'] ?? '';
  //
  //       // Use the values from the form if they are not null or empty, otherwise use the previous values
  //       String updatedPhone = _phoneController.text.isNotEmpty ? _phoneController.text : previousPhone;
  //       String updatedEducationQualification = _educationController.text.isNotEmpty ? _educationController.text : previousEducationQualification;
  //       String updatedTrainingMode = _trainingmode ?? widget.trainingMode; // If training mode is not selected, use the previous value
  //
  //       // Update the user's document in Firestore
  //       await firestore.collection('Registration data').doc(user.uid).update({
  //         'email_id': widget.email,  // Keeping email the same as passed
  //         'name': _nameController.text,  // Read from the form field
  //         'dob': _dobController.text,  // Read from the form field
  //         'gender': _genderController.text,  // Read from the form field
  //         'phone': updatedPhone,  // Update with phone value (previous if empty)
  //         'educationQualification': updatedEducationQualification,  // Update with education qualification (previous if empty)
  //         'city': widget.city,  // Read-only field
  //         'trainingMode': updatedTrainingMode,  // If the training mode is not changed, keep the old value
  //         'selectedCourses': selectedCourses,  // Courses selected by the user
  //       });
  //
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(content: Text("Profile updated successfully")),
  //       );
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Failed to update data: $e')),
  //     );
  //   }
  // }

  Future<void> _updateData() async {
    try {
      // Get the current Firebase user
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null && user.email != null) {
        // Fetch the current data from Firestore for the user using their email
        QuerySnapshot userDocSnapshot = await firestore
            .collection('Registration data')
            .where('Email_id', isEqualTo: user.email)
            .get();

        // Check if the document exists
        if (userDocSnapshot.docs.isNotEmpty) {
          // Get the first document that matches the email
          DocumentSnapshot userDoc = userDocSnapshot.docs.first;
          Map<String, dynamic>? data = userDoc.data() as Map<String, dynamic>?;

          // Get previous values from Firestore (if they exist)
          String previousPhone = data?['phone'] ?? '';
          String previousEducationQualification = data?['educationQualification'] ?? '';

          // Use the values from the form if they are not null or empty, otherwise use the previous values
          String updatedPhone = _phoneController.text.isNotEmpty ? _phoneController.text : previousPhone;
          String updatedEducationQualification = _educationController.text.isNotEmpty ? _educationController.text : previousEducationQualification;
          String updatedTrainingMode = _trainingmode ?? widget.trainingMode; // If training mode is not selected, use the previous value

          // Update the user's document in Firestore
          await firestore.collection('Registration data').doc(userDoc.id).update({
            'Email_id': user.email,  // Keeping email the same as passed
            'Name': _nameController.text,  // Read from the form field
            'DoB': _dobController.text,  // Read from the form field
            'Gender': _genderController.text,  // Read from the form field
            'Phone': updatedPhone,  // Update with phone value (previous if empty)
            'Education_Qualification': updatedEducationQualification,  // Update with education qualification (previous if empty)
            'City': widget.city,  // Read-only field
            'Training_mode': updatedTrainingMode,  // If the training mode is not changed, keep the old value
          'Course_Selected': jsonEncode(selectedCourses),  // Courses selected by the user
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Profile updated successfully")),
          );
        } else {
          // Handle case where document does not exist for the email
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("User document not found")),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update data: $e')),
      );
    }
  }




  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        flexibleSpace: Image(
          image: AssetImage('assets/appbar.jpg'),
          fit: BoxFit.cover,
        ),
        backgroundColor: Colors.transparent,
        title: Center(
          child: Container(
            height: 80.0,
            width:80,
            child: Image.asset(
              'assets/homepage/logobird.png',
              height: 32,
            ),
          ),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          // Status bar color
          statusBarColor: Colors.transparent,

          statusBarIconBrightness: Brightness.light, // For Android (dark icons)

        ),

      ),
      body: SingleChildScrollView(
        child: Container(

          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/sky.jpg"),
              fit: BoxFit.fill,
            ),),
          child: Column(
              children: [
                Text("Update Profile ",
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[100])
                ),


                Column(
                    children: [
                      Container(

                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Form(
                              key: _formkey1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFormField(
                                    initialValue: widget.name,
                                    readOnly: true,
                                    autovalidateMode: AutovalidateMode.always,
                                    keyboardType: TextInputType.name,style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      // filled: true,
                                      // fillColor: Colors.grey,
                                        border: OutlineInputBorder(),
                                        labelText: "Full Name (required)",
                                        labelStyle: TextStyle(color: Colors.black)
                                    ),

                                  ), //name
                                  SizedBox(height: 10),

                                  TextFormField(
                                    initialValue: widget.dob,
                                    readOnly: true,                                      autovalidateMode: AutovalidateMode.always,
                                    keyboardType: TextInputType.name,style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      // filled: true,
                                      // fillColor: Colors.grey,
                                        border: OutlineInputBorder(),
                                        labelText: "DoB",
                                        labelStyle: TextStyle(color: Colors.black)
                                    ),
                                  ), //dob
                                  SizedBox(height: 10,),

                                  TextFormField(
                                    initialValue: widget.gender ,
                                    readOnly: true,
                                    autovalidateMode: AutovalidateMode.always,
                                    keyboardType: TextInputType.name,style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      // filled: true,
                                      // fillColor: Colors.grey,
                                        border: OutlineInputBorder(),
                                        labelText: "Gender",
                                        labelStyle: TextStyle(color: Colors.black)
                                    ),
                                  ), //gender
                                  SizedBox(height: 10,),

                                  TextFormField(
                                    controller: _phoneController,
                                    autovalidateMode: AutovalidateMode.always,
                                    keyboardType: TextInputType.phone,style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      // filled: true,
                                      // fillColor: Colors.grey,
                                        border: OutlineInputBorder(),
                                        labelText: "Phone Number (required)",
                                        labelStyle: TextStyle(color: Colors.black)
                                    ),
                                    validator: (value){
                                      if(value!.length<10){
                                        return "Please Enter valid phone number";
                                      }
                                      return null;
                                    },
                                  ), //phone
                                  SizedBox(height: 10),

                                  TextFormField(
                                    controller: _educationController,
                                    autovalidateMode: AutovalidateMode.always,
                                    keyboardType: TextInputType.text,style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      // filled: true,
                                      // fillColor: Colors.grey,
                                        border: OutlineInputBorder(),
                                        labelText: "Education Qualification",
                                        labelStyle: TextStyle(color: Colors.black)
                                    ),
                                    validator: (value){
                                      if(value==null || value.isEmpty){
                                        return "Please enter your Education Qualification";
                                      }
                                      return null;
                                    },
                                  ), //education
                                  SizedBox(height: 10),


                                  TextFormField(
                                    initialValue: widget.city,
                                    readOnly: true,
                                    autovalidateMode: AutovalidateMode.always,
                                    keyboardType: TextInputType.text,style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      // filled: true,
                                      // fillColor: Colors.grey,
                                      border: OutlineInputBorder(),
                                      labelText: "City",
                                      labelStyle: TextStyle(color: Colors.black),
                                    ),

                                  ), //city
                                  SizedBox(height: 10),

                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black45,
                                            width: 0.8
                                        ),
                                        borderRadius: BorderRadius.circular(1.0)
                                    ),
                                    child: Column(
                                        children: <Widget>[
                                          Text('Training Mode (required) :', style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                                          Row(
                                            children: <Widget>[
                                              Radio<String>(
                                                value: 'Live online',
                                                groupValue: _trainingmode,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _trainingmode = value;
                                                  });
                                                },
                                              ),
                                              Text('Live online',style: TextStyle(color: Colors.black)),
                                              Radio<String>(
                                                value: 'Classroom',
                                                groupValue: _trainingmode,
                                                onChanged: (value) {
                                                  setState(() {
                                                    _trainingmode = value;
                                                  });
                                                },
                                              ),
                                              Text('Classroom',style: TextStyle(color: Colors.black)),
                                            ],
                                          )
                                        ]),
                                  ),//training mode
                                  SizedBox(height: 10),

                                  MultiSelectDialogField(
                                    items: courseList.map((course) => MultiSelectItem(course, course)).toList(),
                                    title: Text("Select Courses"),
                                    itemsTextStyle: TextStyle(color: Colors.white),
                                    selectedColor: Colors.blue,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black45),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    buttonText: Text("Select Courses",style: TextStyle(color: Colors.black),),
                                    onConfirm: (results) {
                                      setState(() {
                                        selectedCourses = results.cast<String>();
                                      });
                                    },
                                  ),



                                ],
                              ),
                            ),

                            SizedBox(height: 65,),
                            ElevatedButton(
                              onPressed: () {
                                if (_formkey1.currentState!.validate()){

                                  _updateData();
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context)=>const Dashboard()
                                      )
                                  );
                                }


                              },
                              style: ButtonStyle(
                                  padding: WidgetStateProperty.all(
                                      const EdgeInsets.all(10.0)
                                  ),
                                  foregroundColor: WidgetStateProperty.all(Colors.white),
                                  backgroundColor: WidgetStateProperty.all(Colors.deepPurple),
                                  minimumSize: WidgetStateProperty.all(const Size(30, 20)),
                                  textStyle: WidgetStateProperty.all(const TextStyle(fontSize: 22))
                              ),
                              child: const Text("Update"),
                            ),
                            SizedBox(height: 65,),
                          ],
                        ),

                      )    ]
                ),
              ]
          ),
        ),
      ),
    );
  }
}
