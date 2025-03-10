import 'package:firebase_auth/firebase_auth.dart';
import'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scopeindia/user/homePage2.dart';



class LoginChangedPassword extends StatefulWidget {
  const LoginChangedPassword({super.key});

  @override
  State<LoginChangedPassword> createState() => _LoginChangedPasswordState();
}

class _LoginChangedPasswordState extends State<LoginChangedPassword> {

  final _formkey=GlobalKey<FormState>();
  var username_controller=TextEditingController();
  var password_controller=TextEditingController();

  Future<void> _login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: username_controller.text,
        password: password_controller.text, );
      // Handle successful login
      print('Login successful');
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const Homepage2()),
            (Route<dynamic> route) => false, // This removes all previous routes
      );
    }

    catch (e) {
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text(e.toString() as String)) );
      print('Error: $e');
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final RegExp regex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
        body:SingleChildScrollView(
          child: Container(
            height: 800,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/blue background.jpg"),
                fit: BoxFit.fill,
              ),),
            child: Column(

              children: [
                Text("Welcome Back,",
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[100])
                ),
                Text("Login Using New Password...",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[100])
                ),

                Form(
                  key:_formkey,
                  child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(20),

                          child: Column(
                            children: [
                              TextFormField(
                                controller:username_controller,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.blue.withOpacity(0.1),
                                  border:OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),

                                  ),
                                  labelText: "User Name",
                                  labelStyle: TextStyle(
                                    color: Colors.blue[100],
                                    fontSize: 20,
                                  ),
                                  prefixIcon: Icon(Icons.person),
                                  // prefixIconColor: Colors.blue

                                ),
                                validator: _validateEmail,
                              ),
                              SizedBox(height: 10,),

                              TextFormField(
                                controller: password_controller,
                                keyboardType: TextInputType.name,
                                obscureText: true,
                                decoration: InputDecoration(

                                    filled: true,
                                    fillColor: Colors.blue.withOpacity(0.1),
                                    border:OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),

                                    ),
                                    focusColor: Colors.transparent,
                                    labelText: "Password",
                                    labelStyle: TextStyle(
                                      color: Colors.blue[100],
                                      fontSize: 20,
                                    ),
                                    prefixIcon: Icon(Icons.password),
                                    prefixIconColor: Colors.white

                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),

                              SizedBox(
                                width: 300,
                                height: 45,
                                child: ElevatedButton(
                                  onPressed:(){
                                    if (_formkey.currentState!.validate()){
                                      _login();
                                    }

                                    print(username_controller.text);
                                    print(password_controller.text);
                                    setState((){

                                    });

                                  },
                                  child: Text("Login"),
                                  style: ButtonStyle(
                                      padding: WidgetStateProperty.all(
                                          EdgeInsets.all(10.0)
                                      ),
                                      foregroundColor: WidgetStateProperty.all(Colors.white),
                                      backgroundColor: WidgetStateProperty.all(Colors.green),
                                      minimumSize: WidgetStateProperty.all(Size(30, 20)),
                                      textStyle: WidgetStateProperty.all(TextStyle(fontSize: 22))

                                  ),
                                ),
                              ),


                            ],
                          ),
                        ),


                      ]
                  ),

                )
              ],
            ),
          ),
        )
    );
  }
}
