import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:url_launcher/url_launcher.dart';

class RegisterNow extends StatefulWidget {
  const RegisterNow({super.key});

  @override
  State<RegisterNow> createState() => _RegisterNowState();
}

class _RegisterNowState extends State<RegisterNow> {
  bool validateEmail(String email) {
    // Define the regex pattern for a valid email address
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  final _formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController educationController = TextEditingController();
  TextEditingController guardianPhoneController = TextEditingController();
  TextEditingController guardianNameController = TextEditingController();
  TextEditingController guardianOccupationController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();

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
  String? _gender;
  String? _trainingmode;
  String? _location;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  void _addRegistrationData() {
    firestore.collection('Registration data').add({
      'Name': nameController.text,
      'DoB': dobController.text,
      'Gender': _gender.toString(),
      'Education_Qualification': educationController.text,
      'Course_Selected': selectedCourses.toString(),
      'Phone': phoneController.text,
      'Email_id': emailController.text,
      "Guardian's_phone_Number": guardianPhoneController.text,
      'Training_mode': _trainingmode.toString(),
      'Location': dobController.text,
      "Guardian's_name": guardianNameController.text,
      "Guardian's_occupation": guardianOccupationController.text,
      'Address': addressController.text,
      'Country': countryController.text,
      'State': stateController.text,
      'City': cityController.text,
      'PIN/Zip_code': zipCodeController.text,
    }).then((_) {
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registration Successful")),
      );
      print('Data added successfully.');
    }).catchError((error) {
      print('Failed to add data: $error');
    });
  }

  String user = "";
  String dropdownValue = "Male";

  bool checkboxValue1 = false;
  bool checkboxValue2 = false;
  bool checkboxValue3 = false;
  bool checkboxValue4 = false;

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> _sendEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=Your Subject&body=Your Email Body',
    );
    await launchUrl(emailUri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Image(
          image: AssetImage('assets/appbar.jpg'),
          fit: BoxFit.cover,
        ),
        backgroundColor: Colors.transparent,
        title: Center(
          child: Container(
            height: 80.0,
            width: 80,
            child: Image.asset(
              'assets/homepage/logobird.png',
              height: 32,
            ),
          ),
        ),
      ),


      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/blue background.jpg"),
                    fit: BoxFit.fill,
                    opacity: 0.9),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),

                  SingleChildScrollView(
                      child: Container(
                    child: Column(
                      children: [
                        Text("Registration",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 42,
                                fontWeight: FontWeight.bold,
                                color: Colors.yellow)),
                        SizedBox(
                          height: 20,
                        ),
                        Text("It's just a matter of 80 days to an IT job!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                height: 1.1,
                                wordSpacing: 0.1,
                                // letterSpacing: 0.1,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 40,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("assets/blue grey.jpg"),
                                      fit: BoxFit.fitHeight,
                                    ),
                                    border: Border.all(
                                        color: Colors.black45, width: 2.0),
                                    borderRadius: BorderRadius.circular(1.0)),
                                child: Padding(
                                  padding: EdgeInsets.all(30.0),
                                  child: Column(
                                    children: [
                                      ListView(
                                        shrinkWrap: true,
                                        // scrollDirection: Axis.horizontal,
                                        children: [
                                          Container(
                                            width: 350,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(13.2),
                                              child: SingleChildScrollView(
                                                child: Form(
                                                  key: _formkey,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      TextFormField(
                                                        controller: nameController,
                                                        autovalidateMode: AutovalidateMode.always,
                                                        keyboardType: TextInputType.name,
                                                        style: TextStyle(color: Colors.black),
                                                        decoration: InputDecoration(
                                                          border: OutlineInputBorder(
                                                            borderSide: BorderSide(width: 1.0, color: Colors.black),
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(width: 1.0, color: Colors.black), // Border color when focused
                                                          ),
                                                          enabledBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(width: 1.0, color: Colors.black), // Border color when enabled
                                                          ),
                                                          labelText:
                                                          "Full Name (required)",
                                                          labelStyle: TextStyle(
                                                              color:
                                                              Colors.black),
                                                        ),

                                                        validator: (value) {
                                                          if (value == null || value.isEmpty) {
                                                            return "Please Enter Your name";
                                                          }
                                                          return null;
                                                        },
                                                      ), //name
                                                      SizedBox(height: 10),

                                                      TextFormField(
                                                        controller: dobController,
                                                        readOnly: true,
                                                        onTap: () async {
                                                          final DateTime? picked = await showDatePicker(
                                                            context: context,
                                                            initialDate: DateTime.now(),
                                                            firstDate: DateTime(1900),
                                                            lastDate: DateTime.now(),
                                                          );
                                                          if (picked != null) {
                                                            setState(() {
                                                              dobController.text = DateFormat('yyyy-MM-dd').format(picked);
                                                              print(dobController.text);
                                                            });
                                                          }
                                                        },
                                                        decoration:  InputDecoration(
                                                          border: OutlineInputBorder(
                                                            borderSide: BorderSide(width: 1.0, color: Colors.black),
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(width: 1.0, color: Colors.black), // Border color when focused
                                                          ),
                                                          enabledBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(width: 1.0, color: Colors.black), // Border color when enabled
                                                          ),
                                                          labelText:
                                                          "Date of Birth (required)",
                                                          labelStyle: TextStyle(
                                                              color:
                                                              Colors.black),
                                                        ),

                                                        style: TextStyle(color: Colors.black),
                                                        validator: (value) {
                                                          if (value == null || value.isEmpty) {
                                                            return "Please select your date of birth";
                                                          }
                                                          return null;
                                                        },
                                                      ), //dob
                                                      SizedBox(
                                                        height: 10,
                                                      ),

                                                      Container(
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black45,
                                                                width: 0.8),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        1.0)),
                                                        child: Column(
                                                            children: <Widget>[
                                                              Text(
                                                                  'Select your gender (required) :',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                              Column(
                                                                children: <Widget>[
                                                                  Row(
                                                                      children: [ Radio<String>(
                                                                        value: 'Male',
                                                                        groupValue: _gender,
                                                                        onChanged: (value) {
                                                                          setState(() {
                                                                            _gender = value;
                                                                          });
                                                                        },
                                                                        activeColor: Colors.blue,  // Set the active (selected) color of the radio button
                                                                      ),
                                                                        Text('Male', style: TextStyle(color: Colors.black)),]
                                                                  ),
                                                                  Row(
                                                                      children: [   Radio<String>(
                                                                        value: 'Female',
                                                                        groupValue: _gender,
                                                                        onChanged: (value) {
                                                                          setState(() {
                                                                            _gender = value;
                                                                          });
                                                                        },
                                                                        activeColor: Colors.pink,  // Set the active (selected) color of the radio button
                                                                      ),
                                                                        Text('Female', style: TextStyle(color: Colors.black)),]
                                                                  ),
                                                                  Row(
                                                                      children: [ Radio<String>(
                                                                        value: 'Other',
                                                                        groupValue: _gender,
                                                                        onChanged: (value) {
                                                                          setState(() {
                                                                            _gender = value;
                                                                          });
                                                                        },
                                                                        activeColor: Colors.green,  // Set the active (selected) color of the radio button
                                                                      ),
                                                                        Text('Other', style: TextStyle(color: Colors.black)),]
                                                                  ),
                                                            
                                                                ],
                                                              )

                                                            ]),
                                                      ), //gender
                                                      SizedBox(height: 10),

                                                      TextFormField(
                                                        controller:
                                                            educationController,
                                                        autovalidateMode:
                                                            AutovalidateMode
                                                                .always,
                                                        keyboardType:
                                                            TextInputType.text,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                        decoration:
                                                        InputDecoration(
                                                          border: OutlineInputBorder(
                                                            borderSide: BorderSide(width: 1.0, color: Colors.black),
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(width: 1.0, color: Colors.black), // Border color when focused
                                                          ),
                                                          enabledBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(width: 1.0, color: Colors.black), // Border color when enabled
                                                          ),
                                                          labelText:
                                                          "Education Qualification (Required)",
                                                          labelStyle: TextStyle(
                                                              color:
                                                              Colors.black),
                                                        ),

                                                        validator: (value) {
                                                          if (value == null ||
                                                              value.isEmpty) {
                                                            return "Please enter your Education Qualification";
                                                          }
                                                          return null;
                                                        },
                                                      ), //education
                                                      SizedBox(height: 10),

                                                      MultiSelectDialogField(
                                                        items: courseList
                                                            .map((course) =>
                                                                MultiSelectItem(
                                                                    course,
                                                                    course))
                                                            .toList(),
                                                        title: Text(
                                                            "Select Courses"),
                                                        itemsTextStyle:
                                                            TextStyle(
                                                                color: Colors
                                                                    .white),
                                                        selectedColor:
                                                            Colors.blue,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors
                                                                  .black45),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        buttonText: Text(
                                                          "Select Courses",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                        onConfirm: (results) {
                                                          setState(() {
                                                            selectedCourses =
                                                                results.cast<
                                                                    String>();
                                                          });
                                                        },
                                                      ), //course
                                                      SizedBox(
                                                        height: 10,
                                                      ),

                                                      TextFormField(
                                                        controller:
                                                            phoneController,
                                                        autovalidateMode:
                                                            AutovalidateMode
                                                                .always,
                                                        keyboardType:
                                                            TextInputType.phone,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                        decoration:
                                                        InputDecoration(
                                                          border: OutlineInputBorder(
                                                            borderSide: BorderSide(width: 1.0, color: Colors.black),
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(width: 1.0, color: Colors.black), // Border color when focused
                                                          ),
                                                          enabledBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(width: 1.0, color: Colors.black), // Border color when enabled
                                                          ),
                                                          labelText:
                                                          "Phone Number (required)",
                                                          labelStyle: TextStyle(
                                                              color:
                                                              Colors.black),
                                                        ),

                                                        validator: (value) {
                                                          if (value!.length <
                                                              10) {
                                                            return "Please Enter valid phone number";
                                                          }
                                                          return null;
                                                        },
                                                      ), //phone
                                                      SizedBox(height: 10),

                                                      TextFormField(
                                                        controller:
                                                            emailController,
                                                        autovalidateMode:
                                                            AutovalidateMode
                                                                .always,
                                                        keyboardType:
                                                            TextInputType.text,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                        decoration:
                                                        InputDecoration(
                                                          border: OutlineInputBorder(
                                                            borderSide: BorderSide(width: 1.0, color: Colors.black),
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(width: 1.0, color: Colors.black), // Border color when focused
                                                          ),
                                                          enabledBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(width: 1.0, color: Colors.black), // Border color when enabled
                                                          ),
                                                          labelText:
                                                          "Email (required)",
                                                          labelStyle: TextStyle(
                                                              color:
                                                              Colors.black),
                                                        ),

                                                        validator: (value) {
                                                          if (value == null ||
                                                              value.isEmpty) {
                                                            return 'Please enter an email address';
                                                          } else if (!validateEmail(
                                                              value)) {
                                                            return 'Invalid email address';
                                                          }
                                                          return null;
                                                        },
                                                      ), //email
                                                      SizedBox(height: 10),

                                                      TextFormField(
                                                        controller: guardianPhoneController,
                                                        autovalidateMode: AutovalidateMode.always,
                                                        keyboardType: TextInputType.phone,
                                                        style: TextStyle(color: Colors.black),
                                                        decoration: InputDecoration(
                                                          border: OutlineInputBorder(
                                                            borderSide: BorderSide(width: 1.0, color: Colors.black),
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(width: 1.0, color: Colors.black), // Border color when focused
                                                          ),
                                                          enabledBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(width: 1.0, color: Colors.black), // Border color when enabled
                                                          ),
                                                          labelText:
                                                          "Guardian's Phone",
                                                          labelStyle: TextStyle(
                                                              color:
                                                              Colors.black),
                                                        )
                                                      ), //guardian phone
                                                      SizedBox(height: 10),

                                                      Container(
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black45,
                                                                width: 0.8),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        1.0)),
                                                        child: Column(
                                                            children: <Widget>[
                                                              Text(
                                                                  'Training Mode (required) :',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                              Row(
                                                                children: <Widget>[
                                                                  Radio<String>(
                                                                    value:
                                                                        'Live online',
                                                                    groupValue:
                                                                        _trainingmode,
                                                                    onChanged:
                                                                        (value) {
                                                                      setState(
                                                                          () {
                                                                        _trainingmode =
                                                                            value;
                                                                      });
                                                                    },
                                                                    activeColor: Colors.pink,
                                                                  ),
                                                                  Text(
                                                                      'Live online',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.black)),
                                                                  Radio<String>(
                                                                    value:
                                                                        'Classroom',
                                                                    groupValue:
                                                                        _trainingmode,
                                                                    onChanged:
                                                                        (value) {
                                                                      setState(
                                                                          () {
                                                                        _trainingmode =
                                                                            value;
                                                                      });
                                                                    },
                                                                    activeColor: Colors.pink,
                                                                  ),
                                                                  Text(
                                                                      'Classroom',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.black)),
                                                                ],
                                                              )
                                                            ]),
                                                      ), //training mode
                                                      SizedBox(height: 10),

                                                      Container(
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black45,
                                                                width: 0.8),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        1.0)),
                                                        child: Column(
                                                            children: <Widget>[
                                                              Text(
                                                                  'SCOPE INDIA Location (required)',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold)),
                                                              SingleChildScrollView(
                                                                  scrollDirection:
                                                                      Axis
                                                                          .horizontal,
                                                                  child:
                                                                      Container(
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Row(
                                                                          children: <Widget>[
                                                                            Radio<String>(
                                                                              value: 'Technopark TVM',
                                                                              groupValue: _location,
                                                                              onChanged: (value) {
                                                                                setState(() {
                                                                                  _location = value;
                                                                                });
                                                                              },
                                                                              activeColor: Colors.pink,
                                                                            ),
                                                                            Text('Technopark TVM',
                                                                                style: TextStyle(color: Colors.black)),
                                                                            Radio<String>(
                                                                              value: 'Thampanoor TVM',
                                                                              groupValue: _location,
                                                                              onChanged: (value) {
                                                                                setState(() {
                                                                                  _location = value;
                                                                                });
                                                                              },
                                                                              activeColor: Colors.pink,
                                                                            ),
                                                                            Text('Thampanoor TVM ',
                                                                                style: TextStyle(color: Colors.black)),
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          children: <Widget>[
                                                                            Radio<String>(
                                                                              value: 'Kochi',
                                                                              groupValue: _location,
                                                                              onChanged: (value) {
                                                                                setState(() {
                                                                                  _location = value;
                                                                                });
                                                                              },
                                                                              activeColor: Colors.pink,
                                                                            ),
                                                                            Text('Kochi',
                                                                                style: TextStyle(color: Colors.black)),
                                                                            Radio<String>(
                                                                              value: 'Nagercoil',
                                                                              groupValue: _location,
                                                                              onChanged: (value) {
                                                                                setState(() {
                                                                                  _location = value;
                                                                                });
                                                                              },
                                                                              activeColor: Colors.pink,
                                                                            ),
                                                                            Text('Nagercoil',
                                                                                style: TextStyle(color: Colors.black)),
                                                                            Radio<String>(
                                                                              value: 'Online',
                                                                              groupValue: _location,
                                                                              onChanged: (value) {
                                                                                setState(() {
                                                                                  _location = value;
                                                                                });
                                                                              },
                                                                              activeColor: Colors.pink,
                                                                            ),
                                                                            Text('Online',
                                                                                style: TextStyle(color: Colors.black)),
                                                                          ],
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ))
                                                            ]),
                                                      ), //location
                                                      SizedBox(height: 10),

                                                      TextFormField(
                                                        controller:
                                                            guardianNameController,
                                                        autovalidateMode:
                                                            AutovalidateMode
                                                                .always,
                                                        keyboardType:
                                                            TextInputType.text,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                        decoration:
                                                        InputDecoration(
                                                          border: OutlineInputBorder(
                                                            borderSide: BorderSide(width: 1.0, color: Colors.black),
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(width: 1.0, color: Colors.black), // Border color when focused
                                                          ),
                                                          enabledBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(width: 1.0, color: Colors.black), // Border color when enabled
                                                          ),
                                                          labelText:
                                                          "Guardian's Name",
                                                          labelStyle: TextStyle(
                                                              color:
                                                              Colors.black),
                                                        )
                                                      ), //guardianName
                                                      SizedBox(height: 10),

                                                      TextFormField(
                                                        controller:
                                                            guardianOccupationController,
                                                        autovalidateMode:
                                                            AutovalidateMode
                                                                .always,
                                                        keyboardType:
                                                            TextInputType.text,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                        decoration:
                                                        InputDecoration(
                                                          border: OutlineInputBorder(
                                                            borderSide: BorderSide(width: 1.0, color: Colors.black),
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(width: 1.0, color: Colors.black), // Border color when focused
                                                          ),
                                                          enabledBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(width: 1.0, color: Colors.black), // Border color when enabled
                                                          ),
                                                          labelText:
                                                          "Guardian's Occupation",
                                                          labelStyle: TextStyle(
                                                              color:
                                                              Colors.black),
                                                        )
                                                      ), //guardianOccupation
                                                      SizedBox(height: 10),

                                                      Container(
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black45,
                                                                width: 0.8),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        2.03)),
                                                        child: Column(
                                                          children: [
                                                            Text(
                                                              "Preferred Training Timings (required)",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                            Center(
                                                              child:
                                                                  CheckboxListTile(
                                                                    tileColor: Colors.white,


                                                                title:
                                                                    const Text(
                                                                  'Between 8am - 10am',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                value:
                                                                    checkboxValue1,
                                                                onChanged:
                                                                    (bool?
                                                                        value) {
                                                                  setState(() {
                                                                    checkboxValue1 =
                                                                        value!;
                                                                    timeDilation =
                                                                        value
                                                                            ? 5.0
                                                                            : 1.0;
                                                                  });
                                                                },
                                                              ),
                                                            ),
                                                            Center(
                                                              child:
                                                                  CheckboxListTile(
                                                                title:
                                                                    const Text(
                                                                  'Between 9am - 1pm',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                value:
                                                                    checkboxValue2,
                                                                onChanged:
                                                                    (bool?
                                                                        value) {
                                                                  setState(() {
                                                                    checkboxValue2 =
                                                                        value!;
                                                                    timeDilation =
                                                                        value
                                                                            ? 5.0
                                                                            : 1.0;
                                                                  });
                                                                },
                                                              ),
                                                            ),
                                                            Center(
                                                              child:
                                                                  CheckboxListTile(
                                                                title:
                                                                    const Text(
                                                                  'Between 1pm - 6pm',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                value:
                                                                    checkboxValue3,
                                                                onChanged:
                                                                    (bool?
                                                                        value) {
                                                                  setState(() {
                                                                    checkboxValue3 =
                                                                        value!;
                                                                    timeDilation =
                                                                        value
                                                                            ? 5.0
                                                                            : 1.0;
                                                                  });
                                                                },
                                                              ),
                                                            ),
                                                            Center(
                                                              child:
                                                                  CheckboxListTile(
                                                                title:
                                                                    const Text(
                                                                  'Between 6pm - 10pm',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                value:
                                                                    checkboxValue4,
                                                                onChanged:
                                                                    (bool?
                                                                        value) {
                                                                  setState(() {
                                                                    checkboxValue4 =
                                                                        value!;
                                                                    timeDilation =
                                                                        value
                                                                            ? 5.0
                                                                            : 1.0;
                                                                  });
                                                                },
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ), //timings
                                                      SizedBox(height: 10),

                                                      TextFormField(
                                                        controller:
                                                            addressController,
                                                        autovalidateMode:
                                                            AutovalidateMode
                                                                .always,
                                                        keyboardType:
                                                            TextInputType.text,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                        decoration:
                                                        InputDecoration(
                                                          border: OutlineInputBorder(
                                                            borderSide: BorderSide(width: 1.0, color: Colors.black),
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(width: 1.0, color: Colors.black), // Border color when focused
                                                          ),
                                                          enabledBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(width: 1.0, color: Colors.black), // Border color when enabled
                                                          ),
                                                          labelText:
                                                          "Address",
                                                          labelStyle: TextStyle(
                                                              color:
                                                              Colors.black),
                                                        )
                                                      ), //Address
                                                      SizedBox(height: 10),

                                                      TextFormField(
                                                        controller:
                                                            countryController,
                                                        autovalidateMode:
                                                            AutovalidateMode
                                                                .always,
                                                        keyboardType:
                                                            TextInputType.text,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                        decoration:
                                                        InputDecoration(
                                                          border: OutlineInputBorder(
                                                            borderSide: BorderSide(width: 1.0, color: Colors.black),
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(width: 1.0, color: Colors.black), // Border color when focused
                                                          ),
                                                          enabledBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(width: 1.0, color: Colors.black), // Border color when enabled
                                                          ),
                                                          labelText:
                                                          "Country",
                                                          labelStyle: TextStyle(
                                                              color:
                                                              Colors.black),
                                                        )
                                                      ), //Country
                                                      SizedBox(height: 10),

                                                      TextFormField(
                                                        controller:
                                                            stateController,
                                                        autovalidateMode:
                                                            AutovalidateMode
                                                                .always,
                                                        keyboardType:
                                                            TextInputType.text,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                        decoration:
                                                        InputDecoration(
                                                          border: OutlineInputBorder(
                                                            borderSide: BorderSide(width: 1.0, color: Colors.black),
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(width: 1.0, color: Colors.black), // Border color when focused
                                                          ),
                                                          enabledBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(width: 1.0, color: Colors.black), // Border color when enabled
                                                          ),
                                                          labelText:
                                                          "State",
                                                          labelStyle: TextStyle(
                                                              color:
                                                              Colors.black),
                                                        )
                                                      ), //state
                                                      SizedBox(height: 10),

                                                      TextFormField(
                                                        controller:
                                                            cityController,
                                                        autovalidateMode:
                                                            AutovalidateMode
                                                                .always,
                                                        keyboardType:
                                                            TextInputType.text,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                        decoration:
                                                        InputDecoration(
                                                          border: OutlineInputBorder(
                                                            borderSide: BorderSide(width: 1.0, color: Colors.black),
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(width: 1.0, color: Colors.black), // Border color when focused
                                                          ),
                                                          enabledBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(width: 1.0, color: Colors.black), // Border color when enabled
                                                          ),
                                                          labelText:
                                                          "City",
                                                          labelStyle: TextStyle(
                                                              color:
                                                              Colors.black),
                                                        )
                                                      ), //city
                                                      SizedBox(height: 10),

                                                      TextFormField(
                                                        controller:
                                                            zipCodeController,
                                                        autovalidateMode:
                                                            AutovalidateMode
                                                                .always,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                        decoration:
                                                        InputDecoration(
                                                          border: OutlineInputBorder(
                                                            borderSide: BorderSide(width: 1.0, color: Colors.black),
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(width: 1.0, color: Colors.black), // Border color when focused
                                                          ),
                                                          enabledBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(width: 1.0, color: Colors.black), // Border color when enabled
                                                          ),
                                                          labelText:
                                                          "PIN/Zip Code",
                                                          labelStyle: TextStyle(
                                                              color:
                                                              Colors.black),
                                                        )
                                                      ), //zipcode
                                                      SizedBox(height: 10),

                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Center(
                                                        child: ElevatedButton(
                                                          style: ButtonStyle(
                                                              backgroundColor:
                                                                  WidgetStateProperty.all(
                                                                      Colors
                                                                          .green),
                                                              foregroundColor:
                                                                  WidgetStateProperty.all(
                                                                      Colors
                                                                          .white),
                                                              padding: WidgetStateProperty.all(
                                                                  EdgeInsets.all(
                                                                      15.0)),
                                                              textStyle: WidgetStateProperty
                                                                  .all(TextStyle(
                                                                      fontSize:
                                                                          15.0))),
                                                          onPressed:
                                                              _addRegistrationData,
                                                          child: Text(
                                                              "Complete Registration >>>"),
                                                        ),
                                                      ),
                                                      SizedBox(height: 20),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(1),
                                ),
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                                // padding: MaterialStateProperty.all(EdgeInsets.all(10.0)),
                                minimumSize: Size(400, 60),
                                textStyle: TextStyle(fontSize: 20.0)),
                            onPressed: () {
                              print("Courses");
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Courses")),
                              );
                            },
                            child: Text("Courses"),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(1),
                                ),
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                                // padding: MaterialStateProperty.all(EdgeInsets.all(10.0)),
                                minimumSize: Size(400, 60),
                                textStyle: TextStyle(fontSize: 20.0)),
                            onPressed: () {
                              print("Register now");
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Register Now")),
                              );
                            },
                            child: Text("Register Now!"),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  )), //description

                  SizedBox(
                    height: 40,
                  ),
                  Text("Locations")
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.deepPurple[900],
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            child: Column(
                              children: [
                                Container(
                                  height: 400,
                                  width: 350,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white,
                                          width: 2.0
                                      ),
                                      borderRadius: BorderRadius.circular(25.0)
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 20,),
                                      Text("Technopark TVM, Kerala",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 26,color: Colors.white),),
                                      SizedBox(height: 10,),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.location_on_outlined),
                                          Text(" Phase 1, Main Gate, Diamond Arcade, \n Near Technopark, Trivandrum",style: TextStyle(fontSize: 16,color: Colors.white),),
                                        ],
                                      ),
                                      SizedBox(height: 10,),
                                      TextButton(onPressed: () => _makePhoneCall("+919745936073"),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.phone),
                                            Text(" +919745936073",style: TextStyle(fontSize: 16,color: Colors.white),),
                                          ],
                                        ),
                                      ),

                                      SizedBox(height: 10,),
                                      TextButton(onPressed: () => _sendEmail("info@scopeindia.org"),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.mail),
                                            Text("  info@scopeindia.org",style: TextStyle(fontSize: 16,color: Colors.white),),
                                          ],
                                        ),
                                      ),

                                      SizedBox(height: 10,),
                                      TextButton(
                                        onPressed: () async {
                                          final Uri url = Uri.parse('https://www.scopeindia.org');
                                          if (await canLaunchUrl(url)) {
                                            await launchUrl(url);
                                          } else {
                                            throw 'Could not launch $url';
                                          }
                                          },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.link),
                                            Text("   www.scopeindia.org",style: TextStyle(fontSize: 16,color: Colors.white),),
                                          ],
                                        ),
                                      ),

                                      SizedBox(height: 10,),
                                      TextButton(
                                          onPressed: () async {
                                          final Uri mapUrl = Uri.parse('https://maps.app.goo.gl/jse93E7F3MMh2wsZ9');
                                          if (await canLaunchUrl(mapUrl)) {
                                            await launchUrl(mapUrl);
                                          } else {
                                            throw 'Could not launch $mapUrl';
                                          }
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.map_outlined),
                                            Text("  Location Route Map",style: TextStyle(fontSize: 16,color: Colors.white),),
                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                ), //technopark

                                Container(
                                  height: 400,
                                  width: 350,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white,
                                          width: 2.0
                                      ),
                                      borderRadius: BorderRadius.circular(25.0)
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 20,),
                                      Text("Thampanoor TVM, Kerala",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 26,color: Colors.white),),
                                      SizedBox(height: 10,),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.location_on_outlined),
                                          Text(" TC 25/1403/3, Athens Plaza, SS Kovil \nRoad, Thampanoor, Trivandrum, \nKerala 695001",style: TextStyle(fontSize: 16,color: Colors.white),),
                                        ],
                                      ),
                                      SizedBox(height: 10,),
                                      TextButton(onPressed: () => _makePhoneCall("+919745936073"),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.phone),
                                            Text(" +919745936073",style: TextStyle(fontSize: 16,color: Colors.white),),
                                          ],
                                        ),
                                      ),

                                      SizedBox(height: 10,),
                                      TextButton(onPressed: () => _sendEmail("info@scopeindia.org"),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.mail),
                                            Text("  info@scopeindia.org",style: TextStyle(fontSize: 16,color: Colors.white),),
                                          ],
                                        ),
                                      ),

                                      SizedBox(height: 10,),
                                      TextButton(
                                        onPressed: () async {
                                          final Uri url = Uri.parse('https://www.scopeindia.org');
                                          if (await canLaunchUrl(url)) {
                                            await launchUrl(url);
                                          } else {
                                            throw 'Could not launch $url';
                                          }
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.link),
                                            Text("   www.scopeindia.org",style: TextStyle(fontSize: 16,color: Colors.white),),
                                          ],
                                        ),
                                      ),

                                      SizedBox(height: 10,),
                                      TextButton(
                                        onPressed: () async {
                                          final Uri mapUrl = Uri.parse('https://maps.app.goo.gl/DbSxnCranSy5SbXC6');
                                          if (await canLaunchUrl(mapUrl)) {
                                            await launchUrl(mapUrl);
                                          } else {
                                            throw 'Could not launch $mapUrl';
                                          }
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.map_outlined),
                                            Text("  Location Route Map",style: TextStyle(fontSize: 16,color: Colors.white),),
                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                ), //thampanoor

                                Container(
                                  height: 400,
                                  width: 350,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white,
                                          width: 2.0
                                      ),
                                      borderRadius: BorderRadius.circular(25.0)
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10,),
                                      Text("Kochi, Kerala",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 26,color: Colors.white),),
                                      SizedBox(height: 10,),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.location_on_outlined),
                                          Text("  SCOPE INDIA, Vasanth Nagar Rd,\nnear JLN Metro Station, Kaloor, Kochi,\nKerala 682025",style: TextStyle(fontSize: 16,color: Colors.white),),
                                        ],
                                      ),
                                      SizedBox(height: 20,),
                                      TextButton(onPressed: () => _makePhoneCall("+919745936073"),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.phone),
                                            Text(" +917592939481",style: TextStyle(fontSize: 16,color: Colors.white),),
                                          ],
                                        ),
                                      ),

                                      SizedBox(height: 10,),
                                      TextButton(onPressed: () => _sendEmail("kochi@scopeindia.org"),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.mail),
                                            Text("  kochi@scopeindia.org",style: TextStyle(fontSize: 16,color: Colors.white),),
                                          ],
                                        ),
                                      ),

                                      SizedBox(height: 10,),
                                      TextButton(
                                        onPressed: () async {
                                          final Uri url = Uri.parse('https://www.scopeindia.org');
                                          if (await canLaunchUrl(url)) {
                                            await launchUrl(url);
                                          } else {
                                            throw 'Could not launch $url';
                                          }
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.link),
                                            Text("   www.scopeindia.org",style: TextStyle(fontSize: 16,color: Colors.white),),
                                          ],
                                        ),
                                      ),

                                      SizedBox(height: 10,),
                                      TextButton(
                                          onPressed: () async {
                                          final Uri mapUrl = Uri.parse('https://maps.app.goo.gl/wWeeHv7eE4WuBvHUA');
                                          if (await canLaunchUrl(mapUrl)) {
                                            await launchUrl(mapUrl);
                                          } else {
                                            throw 'Could not launch $mapUrl';
                                          }
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.map_outlined),
                                            Text("  Location Route Map",style: TextStyle(fontSize: 16,color: Colors.white),),
                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                ), //kochi

                                Container(
                                  height: 400,
                                  width: 350,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white,
                                          width: 2.0
                                      ),
                                      borderRadius: BorderRadius.circular(25.0)
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 20,),
                                      Text("Nagercoil, Tamil Nadu",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 26,color: Colors.white),),
                                      SizedBox(height: 10,),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.location_on_outlined),
                                          Text(" SCOPE INDIA, Near WCC College,\nPalace Rd, Nagercoil, Tamil Nadu 629001",style: TextStyle(fontSize: 16,color: Colors.white),),
                                        ],
                                      ),
                                      SizedBox(height: 10,),
                                      TextButton(onPressed: () => _makePhoneCall("+918075536185"),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.phone),
                                            Text(" +918075536185",style: TextStyle(fontSize: 16,color: Colors.white),),
                                          ],
                                        ),
                                      ),

                                      SizedBox(height: 10,),
                                      TextButton(onPressed: () => _sendEmail("ngl@scopeindia.org"),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.mail),
                                            Text("  ngl@scopeindia.org",style: TextStyle(fontSize: 16,color: Colors.white),),
                                          ],
                                        ),
                                      ),

                                      SizedBox(height: 10,),
                                      TextButton(
                                        onPressed: () async {
                                          final Uri url = Uri.parse('https://www.scopeindia.org');
                                          if (await canLaunchUrl(url)) {
                                            await launchUrl(url);
                                          } else {
                                            throw 'Could not launch $url';
                                          }
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.link),
                                            Text("   www.scopeindia.org",style: TextStyle(fontSize: 16,color: Colors.white),),
                                          ],
                                        ),
                                      ),

                                      SizedBox(height: 10,),
                                      TextButton(
                                          onPressed: () async {
                                          final Uri mapUrl = Uri.parse('https://maps.app.goo.gl/feJJkn8snXKyaNZa8');
                                          if (await canLaunchUrl(mapUrl)) {
                                            await launchUrl(mapUrl);
                                          } else {
                                            throw 'Could not launch $mapUrl';
                                          }
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.map_outlined),
                                            Text("  Location Route Map",style: TextStyle(fontSize: 16,color: Colors.white),),
                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                ), //nagercoil 1

                                Container(
                                  height: 400,
                                  width: 350,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white,
                                          width: 2.0
                                      ),
                                      borderRadius: BorderRadius.circular(25.0)
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 20,),
                                      Text("Nagercoil, Tamil Nadu",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 26,color: Colors.white),),
                                      SizedBox(height: 10,),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.location_on_outlined),
                                          Text(" SCOPE INDIA, Pharma Street, 5/2 Ward 28,\nDistillery Road, Putheri Nagercoil\n(Near WCC Jn)",style: TextStyle(fontSize: 16,color: Colors.white),),
                                        ],
                                      ),
                                      SizedBox(height: 10,),
                                      TextButton(onPressed: () => _makePhoneCall("+918075536185"),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.phone),
                                            Text(" +918075536185",style: TextStyle(fontSize: 16,color: Colors.white),),
                                          ],
                                        ),
                                      ),

                                      SizedBox(height: 10,),
                                      TextButton(onPressed: () => _sendEmail("ngl@scopeindia.org"),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.mail),
                                            Text("  ngl@scopeindia.org",style: TextStyle(fontSize: 16,color: Colors.white),),
                                          ],
                                        ),
                                      ),

                                      SizedBox(height: 10,),
                                      TextButton(
                                        onPressed: () async {
                                          final Uri url = Uri.parse('https://www.scopeindia.org');
                                          if (await canLaunchUrl(url)) {
                                            await launchUrl(url);
                                          } else {
                                            throw 'Could not launch $url';
                                          }
                                        },
                                          child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.link),
                                            Text("   www.scopeindia.org",style: TextStyle(fontSize: 16,color: Colors.white),),
                                          ],
                                        ),
                                      ),

                                      SizedBox(height: 10,),
                                      TextButton(
                                        onPressed: () async {
                                          final Uri mapUrl = Uri.parse('https://maps.app.goo.gl/dDFZyRGQ5ZVKtYM18');
                                          if (await canLaunchUrl(mapUrl)) {
                                            await launchUrl(mapUrl);
                                          } else {
                                            throw 'Could not launch $mapUrl';
                                          }
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(Icons.map_outlined),
                                            Text("  Location Route Map",style: TextStyle(fontSize: 16,color: Colors.white),),
                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                ), //nagercoil 2

                                Container(
                                  height: 200.0,
                                  width:400,
                                  child: Image.asset(
                                    'assets/white2.png',
                                    fit: BoxFit.fill,
                                    height: 32,
                                  ),

                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 400,
                            width: 350,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 2.0),
                                borderRadius: BorderRadius.circular(25.0)),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Thampanoor TVM, Kerala",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 26,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.location_on_outlined),
                                    Text(
                                      " TC 25/1403/3, Athens Plaza, SS Kovil \nRoad, Thampanoor, Trivandrum, \nKerala 695001",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextButton(
                                  onPressed: () {
                                    print("Text Button Is Pressed");
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.phone),
                                      Text(
                                        " +919745936073",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextButton(
                                  onPressed: () {
                                    print("Text Button Is Pressed");
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.mail),
                                      Text(
                                        "  info@scopeindia.org",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextButton(
                                  onPressed: () async {
                                    final Uri url = Uri.parse('https://www.scopeindia.org');
                                    if (await canLaunchUrl(url)) {
                                      await launchUrl(url);
                                    } else {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.link),
                                      Text(
                                        "   www.scopeindia.org",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextButton(
                                  onPressed: () async {
                                    final Uri mapUrl = Uri.parse('https://maps.app.goo.gl/dwCSD8qvTtJ99Uc96');
                                    if (await canLaunchUrl(mapUrl)) {
                                      await launchUrl(mapUrl);
                                    } else {
                                      throw 'Could not launch $mapUrl';
                                    }
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.map_outlined),
                                      Text(
                                        "  Location Route Map",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 400,
                            width: 350,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 2.0),
                                borderRadius: BorderRadius.circular(25.0)),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Kochi, Kerala",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 26,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.location_on_outlined),
                                    Text(
                                      "  SCOPE INDIA, Vasanth Nagar Rd,\nnear JLN Metro Station, Kaloor, Kochi,\nKerala 682025",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextButton(
                                  onPressed: () {
                                    print("Text Button Is Pressed");
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.phone),
                                      Text(
                                        " +917592939481",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextButton(
                                  onPressed: () {
                                    print("Text Button Is Pressed");
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.mail),
                                      Text(
                                        "  kochi@scopeindia.org",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextButton(
                                  onPressed: () {
                                    print("Text Button Is Pressed");
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.link),
                                      Text(
                                        "   www.scopeindia.org",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextButton(
                                  onPressed: () {
                                    print("Text Button Is Pressed");
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.map_outlined),
                                      Text(
                                        "  Location Route Map",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 400,
                            width: 350,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 2.0),
                                borderRadius: BorderRadius.circular(25.0)),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Nagercoil, Tamil Nadu",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 26,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.location_on_outlined),
                                    Text(
                                      " SCOPE INDIA, Near WCC College,\nPalace Rd, Nagercoil, Tamil Nadu 629001",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextButton(
                                  onPressed: () {
                                    print("Text Button Is Pressed");
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.phone),
                                      Text(
                                        " +918075536185",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextButton(
                                  onPressed: () {
                                    print("Text Button Is Pressed");
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.mail),
                                      Text(
                                        "  ngl@scopeindia.org",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextButton(
                                  onPressed: () {
                                    print("Text Button Is Pressed");
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.link),
                                      Text(
                                        "   www.scopeindia.org",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextButton(
                                  onPressed: () {
                                    print("Text Button Is Pressed");
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.map_outlined),
                                      Text(
                                        "  Location Route Map",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 400,
                            width: 350,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 2.0),
                                borderRadius: BorderRadius.circular(25.0)),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Nagercoil, Tamil Nadu",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 26,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.location_on_outlined),
                                    Text(
                                      " SCOPE INDIA, Pharma Street, 5/2 Ward 28,\nDistillery Road, Putheri Nagercoil\n(Near WCC Jn)",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextButton(
                                  onPressed: () {
                                    print("Text Button Is Pressed");
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.phone),
                                      Text(
                                        " +918075536185",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextButton(
                                  onPressed: () {
                                    print("Text Button Is Pressed");
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.mail),
                                      Text(
                                        "  ngl@scopeindia.org",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextButton(
                                  onPressed: () {
                                    print("Text Button Is Pressed");
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.link),
                                      Text(
                                        "   www.scopeindia.org",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextButton(
                                  onPressed: () {
                                    print("Text Button Is Pressed");
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.map_outlined),
                                      Text(
                                        "  Location Route Map",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 200.0,
                            width: 400,
                            child: Image.asset(
                              'assets/white2.png',
                              fit: BoxFit.fill,
                              height: 32,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: Container(
                        height: 200.0,
                        width: 400,
                        child: Image.asset(
                          'assets/homepage/scope India.png',
                          fit: BoxFit.fill,
                          height: 32,
                        ),
                      ),
                    ), //scopeindia

                    Text(
                        "Kerala: Technopark TVM | Thampanoor TVM | Kaloor Kochi, Tamil Nadu: Distillery Road | Palace Road Nagercoil",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            height: 1.1,
                            wordSpacing: 0.1,
                            // letterSpacing: 0.1,
                            fontSize: 20,
                            color: Colors.white)), //address

                    Container(
                      child: Image.asset(
                        'assets/homepage/iso logo.png',
                        fit: BoxFit.fitHeight,
                      ),
                    ),

                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding: EdgeInsets.all(1.0),
                      child: Column(children: [
                        Text("An ISO 9001:2015 Certified Company",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                height: 1.1,
                                wordSpacing: 0.1,
                                fontSize: 16,
                                color: Colors.lightBlue[200])),
                        SizedBox(
                          height: 0.1,
                        ),
                        Column(
                          children: [
                            Text("All Rights Reserved ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    height: 1.1,
                                    wordSpacing: 0.1,
                                    fontSize: 16,
                                    color: Colors.lightBlue[200])),
                            Column(
                              children: [
                                Text(" Suffix E Solutions ©  2007-2024",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        height: 1.1,
                                        wordSpacing: 0.1,
                                        fontSize: 18,
                                        color: Colors.white)),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 0.1,
                        ),
                      ]),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Column(
                      children: [
                        TextButton(
                          onPressed: () => _makePhoneCall("+919745936073"),
                          child: Text("+91 9745936073 (TKP)",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  height: 1.1,
                                  wordSpacing: 0.1,
                                  fontSize: 20,
                                  color: Colors.white)),
                        ),
                        TextButton(
                          onPressed: () => _makePhoneCall("+91 9745936073"),
                          child: Text("+91 9745936073 (TVM)",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  height: 1.1,
                                  wordSpacing: 0.1,
                                  fontSize: 20,
                                  color: Colors.white)),
                        ),
                        TextButton(
                          onPressed: () => _makePhoneCall("+917592939481"),
                          child: Text("+91 7592939481 (EKM)",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  height: 1.1,
                                  wordSpacing: 0.1,
                                  fontSize: 20,
                                  color: Colors.white)),
                        ),
                        TextButton(
                          onPressed: () => _makePhoneCall("+918075536185"),
                          child: Text("+91 8075536185 (NGL)",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  height: 1.1,
                                  wordSpacing: 0.1,
                                  fontSize: 20,
                                  color: Colors.white)),
                        ),
                        TextButton(
                          onPressed: () => _sendEmail("info@scopeindia.org"),
                          child: Text("info@scopeindia.org",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  height: 1.1,
                                  wordSpacing: 0.1,
                                  fontSize: 20,
                                  color: Colors.white)),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
