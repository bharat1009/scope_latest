import'package:flutter/material.dart';
import 'package:scopeindia/sideBar/contactUs.dart';
import 'package:scopeindia/sideBar/registerNow.dart';
import 'package:url_launcher/url_launcher.dart';


import '../login/loginPage.dart';
import 'courses.dart';

import 'homePage.dart';

class Aboutus extends StatefulWidget {
  const Aboutus({super.key});

  @override
  State<Aboutus> createState() => _AboutusState();
}

class _AboutusState extends State<Aboutus> {

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
            width:80,
            child: Image.asset(
              'assets/homepage/logobird.png',
              height: 32,
            ),
          ),
        ),

      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/blue background.jpg"),
                  fit: BoxFit.fill,
                ),
              ),
              child: Text(
                'SCOPE INDIA',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            Container(
              height: 650,
              decoration: BoxDecoration(
                  color: Colors.blueAccent
              ),
              child: Column(
                children: [

                  ListTile(
                    leading: const Icon(Icons.home_filled),
                    title: const Text('Home'),
                    onTap: () async {
                      await Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context)=>const Homepage()
                          )
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.library_books_outlined),
                    title: const Text('Courses'),
                    onTap: () async {
                      await Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context)=>const Courses()
                          )
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.people_alt_outlined),
                    title: const Text('Know SCOPE INDIA'),
                    onTap: () async {
                      await Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context)=>const Aboutus()
                          )
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.contact_support_outlined),
                    title: const Text('Contact US'),
                    onTap: () async {
                      await Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context)=>const ContactUs()
                          )
                      );
                    },
                  ),
                  SizedBox(height: 20,),
                  ElevatedButton(

                    onPressed: () async {
                      await ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text("Login to Register Course")) );
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context)=>const Loginpage()
                          )
                      );
                    },
                    style:  ElevatedButton.styleFrom(
                      backgroundColor:  Colors.deepPurple,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text('Course Registration'),
                  ),
                  SizedBox(height: 10,),
                  ElevatedButton(

                    onPressed: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context)=>const Loginpage()
                          )
                      );
                    },
                    style:  ElevatedButton.styleFrom(
                      backgroundColor:  Colors.white,
                      foregroundColor: Colors.deepPurple,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text('     Log In     '),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/blue background.jpg"),
                    fit: BoxFit.fill,opacity: 0.9
                ),

              ),
              child: Column(
                children: [
                  SizedBox(height: 50,),
                  
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 30,),
                        Text("SCOPE INDIA, your career partner!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 42,
                                fontWeight: FontWeight.bold,
                                color: Colors.yellow
                            )),
                        SizedBox(height: 20,),
                        Container(
                          padding: EdgeInsets.fromLTRB(22.5,0,10,0),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(20,0,20,0),
                                child: Column(
                                  children: [

                                    Text("One of the best Training Destination for Software, Networking and Cloud Computing courses in India with 17 years of Industrial experience.",
                                        // textAlign: TextAlign.center,
                                        style: TextStyle(
                                            height: 1.1,
                                            wordSpacing: 0.1,
                                            // letterSpacing: 0.1,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white
                                        )),
                                    SizedBox(height: 40,),
                                    Text("Software, Networking, and Cloud Professional Education Centre in Kerala and Tamil Nadu from Suffix E Solutions with WORKING PROFESSIONALS oriented on-the-job TRAINING model. SCOPE INDIA provides courses for Software Programming in Python (Data Science | Artificial Intelligence | Machine Learning | Deep Learning, Data Analytics), Java, PHP, .Net, MERN, Software Testing Manual and Automation, Cloud Computing (AWS | Azure), Server Administration (MicroSoft MCSE | Linux RHCE), Networking (CCNA), DevOps, Mobile App Development in Flutter, and Digital Marketing. Training with a 100% Trusted Job-Based Internship Model. SCOPE INDIA has a Strong Placement Cell that provides jobs to thousands of students every year. We assure you, you won't regret it after training from SCOPE INDIA! \n\nThis is how SCOPE INDIA can support both newbies and experienced in the industry to upgrade their skills.",
                                        // textAlign: TextAlign.center,
                                        style: TextStyle(
                                            height: 1.2,
                                            // wordSpacing: 0.1,
                                            // letterSpacing: 0.1,
                                            fontSize: 26,
                                            color: Colors.white
                                        )),

                                    SizedBox(height: 20,),
                                  ],
                                ),
                              ),


                             
                              Container(
                                height: 120,
                                width: 300,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/homepage/star.png"),
                                    fit: BoxFit.fill,
                                  ),),
                              ),
                              Container(
                                child: Text("Google 4.9 * Rated Institute",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.white
                                    )),
                              ),


                              SizedBox(height: 40,),
                              Container(
                                padding: EdgeInsets.fromLTRB(08,0,15,0),
                                child: Center(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(1),
                                      ),
                                        backgroundColor: Colors.green,
                                        foregroundColor: Colors.white,
                                        // padding: MaterialStateProperty.all(EdgeInsets.all(10.0)),
                                        minimumSize: Size(400, 60),
                                        textStyle: TextStyle(
                                            fontSize: 20.0
                                        )
                                    ),
                                    onPressed:() async {
                                      await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context)=>const Courses()
                                          )
                                      );

                                    },
                                    child: Text("Courses"),
                                  ),
                                ),
                              ),

                              SizedBox(height: 20,),
                              Container(
                                padding: EdgeInsets.fromLTRB(08,0,15,0),
                                child: Center(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(1),
                                        ),
                                        backgroundColor: Colors.green,
                                        foregroundColor: Colors.white,
                                        // padding: MaterialStateProperty.all(EdgeInsets.all(10.0)),
                                        minimumSize: Size(400, 60),
                                        textStyle: TextStyle(
                                            fontSize: 20.0
                                        )
                                    ),
                                    onPressed: () async {
                                    await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context)=>const RegisterNow()
                                        )
                                    );
                                  },
                                    child: Text("Register Now!"),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20,),

                            ],
                          ),
                        )
                      ],
                    ),
                  ), //description




                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(color:Colors.deepPurple[900], ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 50,),
                    Container(
                      padding: EdgeInsets.fromLTRB(16,0,16,0),
                      child: Column(
                        children: [
                          Text("1000+",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 42,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.yellow
                              )),
                          Text("STUDENTS ARE TRAINED EVERY YEAR",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  height: 1.1,
                                  wordSpacing: 0.1,
                                  // letterSpacing: 0.1,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              )),

                          SizedBox(height: 20,),
                          Text("30+",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 42,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.yellow
                              )),
                          Text("COMPUTER COURSES",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  height: 1.1,
                                  wordSpacing: 0.1,
                                  // letterSpacing: 0.1,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              )),

                          SizedBox(height: 20,),
                          Text("95%",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 42,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.yellow
                              )),
                          Text("STUDENTS ARE GETTING PLACED EVERY YEAR",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  height: 1.1,
                                  wordSpacing: 0.1,
                                  // letterSpacing: 0.1,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              )),

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

                    SizedBox(height: 50,),
                    Center(
                      child: Container(
                        padding: EdgeInsets.all(9),
                        height: 200.0,
                        width:400,
                        child: Image.asset(
                          'assets/homepage/scope India.png',
                          fit: BoxFit.fill,
                          height: 32,
                        ),

                      ),
                    ), //scopeindia

                   Container(
                     padding: EdgeInsets.fromLTRB(22,0,22,0),
                     child: Column(
                       children: [
                         Text("Kerala: Technopark TVM | Thampanoor TVM | Kaloor Kochi, Tamil Nadu: Distillery Road | Palace Road Nagercoil",
                             textAlign: TextAlign.center,
                             style: TextStyle(
                                 height: 1.1,
                                 wordSpacing: 0.1,
                                 // letterSpacing: 0.1,
                                 fontSize: 20,
                                 color: Colors.white
                             )), //address

                         Container(

                           child: Image.asset(
                             'assets/homepage/iso logo.png',
                             fit: BoxFit.fitHeight,
                           ),
                         ),
                       ],
                     ),
                   ),


                    SizedBox(height: 30,),
                    Container(
                      padding: EdgeInsets.all(1.0),
                      child: Column(
                          children: [
                            Text("An ISO 9001:2015 Certified Company",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    height: 1.1,
                                    wordSpacing: 0.1,
                                    fontSize: 16,
                                    color: Colors.lightBlue[200]
                                )),
                            SizedBox(height: 0.1,),

                            Column(
                              children: [
                                Text("All Rights Reserved ",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        height: 1.1,
                                        wordSpacing: 0.1,
                                        fontSize: 16,
                                        color: Colors.lightBlue[200]
                                    )),
                                Column(
                                  children: [

                                    Text(" Suffix E Solutions ©  2007-2024",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            height: 1.1,
                                            wordSpacing: 0.1,
                                            fontSize: 18,
                                            color: Colors.white
                                        )),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 0.1,),



                          ]
                      ),
                    ),
                    SizedBox(height: 50,),
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
                                  color: Colors.white
                              )
                          ),

                        ),
                        TextButton(
                          onPressed: () => _makePhoneCall("+91 9745936073"),
                          child: Text("+91 9745936073 (TVM)",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  height: 1.1,
                                  wordSpacing: 0.1,
                                  fontSize: 20,
                                  color: Colors.white
                              )
                          ),

                        ),
                        TextButton(
                          onPressed: () => _makePhoneCall("+917592939481"),
                          child: Text("+91 7592939481 (EKM)",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  height: 1.1,
                                  wordSpacing: 0.1,
                                  fontSize: 20,
                                  color: Colors.white
                              )
                          ),

                        ),

                        TextButton(
                          onPressed: () => _makePhoneCall("+918075536185"),
                          child: Text("+91 8075536185 (NGL)",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  height: 1.1,
                                  wordSpacing: 0.1,
                                  fontSize: 20,
                                  color: Colors.white
                              )
                          ),

                        ),

                        TextButton(
                          onPressed: () => _sendEmail("info@scopeindia.org"),
                          child: Text("info@scopeindia.org",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  height: 1.1,
                                  wordSpacing: 0.1,
                                  fontSize: 20,
                                  color: Colors.white
                              )
                          ),

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
