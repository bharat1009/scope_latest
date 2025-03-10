import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:scopeindia/login/loginPage.dart';
import 'package:scopeindia/user/dashboard/deleteUser.dart';
import 'package:scopeindia/user/dashboard/updateUser.dart';

import '../../sideBar/homePage.dart';
import 'changePass.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  var _email;

  late String name_;
  late String dob_;
  late String gender_;
  late String phone_;
  late String educationQualification_;
  late String city_;
  late String trainingMode_;
  late String Courses_;

  // A function to delete user data and the user account
  Future<void> _deleteUser() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Delete user data from Firestore
        await _firestore.collection('User Register').doc(user.uid).delete();
        // Delete user from Firebase Authentication
        await user.delete();
        // Show success message
      }
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete user: $e')),
      );
    }
  }

  void deleteDataByEmail(String emailId) async {
    // Reference to the Firestore collection
    final CollectionReference registrationCollection =
        FirebaseFirestore.instance.collection('Registration data');

    try {
      // Query Firestore to find the document(s) with the matching email ID
      QuerySnapshot querySnapshot = await registrationCollection
          .where('Email_id', isEqualTo: emailId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Loop through each document and delete it
        for (var doc in querySnapshot.docs) {
          await doc.reference.delete();
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Deleted document with ID: ${doc.id}')));
        }
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                'All documents with Email_id $emailId have been deleted.')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('No document found with Email_id $emailId')));
        print;
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error deleting data: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: const Image(
            image: AssetImage('assets/sky.jpg'),
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
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            // Status bar color
            statusBarColor: Colors.transparent,

            statusBarIconBrightness:
                Brightness.light, // For Android (dark icons)
          ),
        ),
        body: SingleChildScrollView(
            child: Center(
                child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/bg.jpg"),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              ListTile(
                leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/profile pic.jpg')),
                title: Text(user!.email.toString() + ',',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple)),
              ),
              SizedBox(
                height: 30,
              ),
              // Container(
              //   width: 350,
              //   color: Colors.blue[200]?.withOpacity(0.7),
              //   child: StreamBuilder<QuerySnapshot>(
              //     stream: FirebaseFirestore.instance
              //         .collection('Registration data')
              //         .where('Email_id', isEqualTo: user?.email.toString())
              //         .limit(5)
              //         .snapshots(),
              //     builder: (context, snapshot) {
              //       if (snapshot.connectionState == ConnectionState.waiting) {
              //         return Center(child: CircularProgressIndicator());
              //       }
              //       if (snapshot.hasError) {
              //         return Center(child: Text('Error: ${snapshot.error}'));
              //       }
              //
              //       // Check if the snapshot has data
              //       if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              //         return Center(child: Text('No data found'));
              //       }
              //
              //       final docs = snapshot.data!.docs;
              //
              //       // Set to store unique courses
              //       Set<String> uniqueCourses = {};
              //       for (var doc in docs) {
              //         String course = doc['Course_Selected'] ?? 'No Course';
              //         uniqueCourses.add(course); // Add to Set to ensure uniqueness
              //       }
              //
              //       // Extract user data
              //       final data = docs.first.data() as Map<String, dynamic>;
              //
              //       String name = data['Name'] ?? 'No Name';
              //       String dob = data['DoB'] ?? 'No Date of Birth';
              //       String gender = data['Gender'] ?? 'No Gender';
              //       String phone = data['Phone'] ?? 'No Phone';
              //       String educationQualification = data['Education_Qualification'] ?? 'No Education';
              //       String city = data['City'] ?? 'No City';
              //       String trainingMode = data['Training_mode'] ?? 'No Training Mode';
              //
              //
              //       return Column(
              //         children: [
              //           // User details section
              //           Card(
              //             margin: EdgeInsets.all(10),
              //             elevation: 5,
              //             color: Colors.purple[100],
              //             child: Column(
              //               children: [
              //                   ListTile(
              //                     title: Text.rich(
              //                       TextSpan(
              //                         children: [
              //                           TextSpan(
              //                             text: 'Name: ',
              //                             style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
              //                           ),
              //                           TextSpan(
              //                             text: name,
              //                             style: TextStyle(
              //                                 color: Colors.deepPurple[900],fontWeight: FontWeight.bold),
              //                           ),
              //                         ],
              //                       ),
              //                     ),
              //                   ),
              //                 Divider(color: Colors.brown[900]),
              //                   ListTile(
              //                     title: Text.rich(
              //                       TextSpan(
              //                         children: [
              //                           TextSpan(
              //                             text: 'Date of Birth: ',
              //                             style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
              //                           ),
              //                           TextSpan(
              //                             text: dob,
              //                             style: TextStyle(
              //                                 color: Colors.deepPurple[900],fontWeight: FontWeight.bold),
              //                           ),
              //                         ],
              //                       ),
              //                     ),
              //                   ),
              //                 Divider(color: Colors.brown[900]),
              //                   ListTile(
              //                     title: Text.rich(
              //                       TextSpan(
              //                         children: [
              //                           TextSpan(
              //                             text: 'Gender: ',
              //                             style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
              //                           ),
              //                           TextSpan(
              //                             text: gender,
              //                             style: TextStyle(
              //                                 color: Colors.deepPurple[900],fontWeight: FontWeight.bold),
              //                           ),
              //                         ],
              //                       ),
              //                     ),
              //                   ),
              //                 Divider(color: Colors.brown[900]),
              //                   ListTile(
              //                     title: Text.rich(
              //                       TextSpan(
              //                         children: [
              //                           TextSpan(
              //                             text: 'Phone: ',
              //                             style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
              //                           ),
              //                           TextSpan(
              //                             text: phone,
              //                             style: TextStyle(
              //                                 color: Colors.deepPurple[900],fontWeight: FontWeight.bold),
              //                           ),
              //                         ],
              //                       ),
              //                     ),
              //                   ),
              //                 Divider(color: Colors.brown[900]),
              //                   ListTile(
              //                     title: Text.rich(
              //                       TextSpan(
              //                         children: [
              //                           TextSpan(
              //                             text: 'Education Qualification: ',
              //                             style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
              //                           ),
              //                           TextSpan(
              //                             text: educationQualification,
              //                             style: TextStyle(
              //                                 color: Colors.deepPurple[900],fontWeight: FontWeight.bold),
              //                           ),
              //                         ],
              //                       ),
              //                     ),
              //                   ),
              //                 Divider(color: Colors.brown[900]),
              //                   ListTile(
              //                     title: Text.rich(
              //                       TextSpan(
              //                         children: [
              //                           TextSpan(
              //                             text: 'City: ',
              //                             style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
              //                           ),
              //                           TextSpan(
              //                             text: city,
              //                             style: TextStyle(
              //                                 color: Colors.deepPurple[900],fontWeight: FontWeight.bold),
              //                           ),
              //                         ],
              //                       ),
              //                     ),
              //                   ),
              //                 Divider(color: Colors.brown[900]),
              //                   ListTile(
              //                     title: Text.rich(
              //                       TextSpan(
              //                         children: [
              //                           TextSpan(
              //                             text: 'Training Mode: ',
              //                             style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
              //                           ),
              //                           TextSpan(
              //                             text: trainingMode,
              //                             style: TextStyle(
              //                                 color: Colors.deepPurple[900],fontWeight: FontWeight.bold),
              //                           ),
              //                         ],
              //                       ),
              //                     ),
              //                   ),
              //
              //
              //               ],
              //             ),
              //           ),
              //
              //           // Unique courses section
              //           Card(
              //             margin: EdgeInsets.all(10),
              //             elevation: 5,
              //             color: Colors.purple[100],
              //             child: Column(
              //               children: [
              //                 ListTile(
              //
              //                   title: Text('Courses Selected:', style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
              //                 ),
              //                 Divider(color: Colors.brown[900]),
              //                 // Displaying each course in a ListTile inside a Column
              //                 for (var course in uniqueCourses)
              //                   ListTile(
              //                     title: Text(course,style: TextStyle(color: Colors.deepPurple,fontWeight: FontWeight.bold),),
              //                   ),
              //
              //               ],
              //             ),
              //           ),
              //         ],
              //       );
              //     },
              //   ),
              // ),

              Container(
                width: 350,
                color: Colors.blue[200]?.withOpacity(0.7),
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Registration data')
                      .where('Email_id', isEqualTo: user?.email.toString())
                      .limit(5)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    // Check if the snapshot has data
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(child: Text('No data found'));
                    }

                    final docs = snapshot.data!.docs;

                    // Set to store unique courses
                    Set<String> uniqueCourses = {};
                    for (var doc in docs) {
                      String course = doc['Course_Selected'] ?? 'No Course';
                      uniqueCourses
                          .add(course); // Add to Set to ensure uniqueness
                    }

                    // Extract user data
                    final data = docs.first.data() as Map<String, dynamic>;
                    String name = data['Name'] ?? 'No Name';
                    String dob = data['DoB'] ?? 'No Date of Birth';
                    String gender = data['Gender'] ?? 'No Gender';
                    String phone = data['Phone'] ?? 'No Phone';
                    String educationQualification =
                        data['Education_Qualification'] ?? 'No Education';
                    String city = data['City'] ?? 'No City';
                    String trainingMode =
                        data['Training_mode'] ?? 'No Training Mode';
                    String courseString = data['Course_Selected'] ?? "";
                    String cleanedString =
                        courseString.replaceAll('[', '').replaceAll(']', '');
                    List<String> courses = cleanedString
                        .split(',')
                        .map((course) => course.trim())
                        .toList();

                    return Column(
                      children: [
                        // User details section
                        Card(
                          margin: EdgeInsets.all(10),
                          elevation: 5,
                          color: Colors.purple[100],
                          child: Column(
                            children: [
                              ListTile(
                                title: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Name: ',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: name,
                                        style: TextStyle(
                                            color: Colors.deepPurple[900],
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(color: Colors.brown[900]),
                              ListTile(
                                title: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Date of Birth: ',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: dob,
                                        style: TextStyle(
                                            color: Colors.deepPurple[900],
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(color: Colors.brown[900]),
                              ListTile(
                                title: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Gender: ',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: gender,
                                        style: TextStyle(
                                            color: Colors.deepPurple[900],
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(color: Colors.brown[900]),
                              ListTile(
                                title: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Phone: ',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: phone,
                                        style: TextStyle(
                                            color: Colors.deepPurple[900],
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(color: Colors.brown[900]),
                              ListTile(
                                title: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Education Qualification: ',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: educationQualification,
                                        style: TextStyle(
                                            color: Colors.deepPurple[900],
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(color: Colors.brown[900]),
                              ListTile(
                                title: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'City: ',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: city,
                                        style: TextStyle(
                                            color: Colors.deepPurple[900],
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(color: Colors.brown[900]),
                              ListTile(
                                title: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Training Mode: ',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: trainingMode,
                                        style: TextStyle(
                                            color: Colors.deepPurple[900],
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Unique courses section
                        Card(
                          margin: EdgeInsets.all(10),
                          elevation: 5,
                          color: Colors.purple[100],
                          child: Column(
                            children: [
                              ListTile(
                                title: Text('Courses Selected:',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                              ),
                              Divider(color: Colors.brown[900]),
                              // Displaying each course in a ListTile inside a Column
                              if (courses.isEmpty)
                                ListTile(
                                  title: Text(
                                    'No courses selected',
                                    style: TextStyle(
                                        color: Colors.deepPurple[900],
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              // Loop through the courses list
                              ...courses
                                  .map((course) => ListTile(
                                        title: Text(
                                          course
                                              .toString(), // Make sure each item is a string
                                          style: TextStyle(
                                              color: Colors.deepPurple[900],
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ))
                                  .toList(),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          style: ButtonStyle(
                              padding:
                                  WidgetStateProperty.all(EdgeInsets.all(10.0)),
                              foregroundColor: WidgetStateProperty.all(
                                  Colors.deepPurple[900]),
                              backgroundColor:
                                  WidgetStateProperty.all(Colors.blue[100]),
                              minimumSize:
                                  WidgetStateProperty.all(Size(100, 20)),
                              textStyle: WidgetStateProperty.all(
                                  TextStyle(fontSize: 22))),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Updateuser(
                                  email: user!.email!,
                                  name: name,
                                  dob: dob,
                                  gender: gender,
                                  phone: phone,
                                  educationQualification:
                                      educationQualification,
                                  city: city,
                                  trainingMode: trainingMode,
                                ),
                              ),
                            );
                          },
                          child: const Text('Update Account'),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                              padding:
                                  WidgetStateProperty.all(EdgeInsets.all(10.0)),
                              foregroundColor: WidgetStateProperty.all(
                                  Colors.deepPurple[900]),
                              backgroundColor:
                                  WidgetStateProperty.all(Colors.blue[100]),
                              minimumSize:
                                  WidgetStateProperty.all(Size(30, 20)),
                              textStyle: WidgetStateProperty.all(
                                  TextStyle(fontSize: 22))),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DeleteUser(),
                              ),
                            );
                          },
                          // {
                          //
                          //   // _deleteUser;
                          //   // String? emailId = user?.email.toString();
                          //   // if (emailId!.isNotEmpty) {
                          //   //   deleteDataByEmail(emailId);
                          //   // } else {
                          //   //   ScaffoldMessenger.of(context).showSnackBar(
                          //   //       const SnackBar(
                          //   //           content:
                          //   //           Text('Unable to delete Data')));
                          //   // }
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //     const SnackBar(
                          //         content:
                          //         Text('User account and data deleted successfully')),
                          //   );
                          //   Navigator.pushReplacement(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) => const Loginpage()));
                          // }, // Call the _deleteUser function
                          child: const Text('       Delete Account       '),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                              padding:
                                  WidgetStateProperty.all(EdgeInsets.all(10.0)),
                              foregroundColor: WidgetStateProperty.all(
                                  Colors.deepPurple[900]),
                              backgroundColor:
                                  WidgetStateProperty.all(Colors.blue[100]),
                              minimumSize:
                                  WidgetStateProperty.all(Size(30, 20)),
                              textStyle: WidgetStateProperty.all(
                                  TextStyle(fontSize: 22))),
                          onPressed: () {
                            setState(() {
                              _email = user?.email.toString();
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ChangePass(email: _email)));
                          }, // Call the _deleteUser function
                          child: const Text('       Change Password       '),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Homepage()));
                          },
                          style: ButtonStyle(
                              padding:
                                  WidgetStateProperty.all(EdgeInsets.all(10.0)),
                              foregroundColor: WidgetStateProperty.all(
                                  Colors.deepPurple[900]),
                              backgroundColor:
                                  WidgetStateProperty.all(Colors.blue[100]),
                              minimumSize:
                                  WidgetStateProperty.all(Size(30, 20)),
                              textStyle: WidgetStateProperty.all(
                                  TextStyle(fontSize: 22))),
                          child: const Text('         Log Out        '),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ))));
  }
}
