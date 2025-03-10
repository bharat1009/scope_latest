import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:scopeindia/sideBar/homePage.dart';


class DeleteUser extends StatefulWidget {
  const DeleteUser({super.key});

  @override
  State<DeleteUser> createState() => _DeleteUserState();
}

class _DeleteUserState extends State<DeleteUser> {

  final _formkey = GlobalKey<FormState>();
   late TextEditingController passwordController;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _user = FirebaseAuth.instance.currentUser;

  void initState() {
    super.initState();
    passwordController = TextEditingController();
  }
  @override
  void dispose() {
    passwordController.dispose(); // Dispose of the controller when done
    super.dispose();
  }
  Future<void> _deleteUser() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Reauthenticate the user
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: passwordController.text, // Replace with actual user password
        );
        await user.reauthenticateWithCredential(credential);

        // Delete user data from Firestore
        await _firestore.collection('User Register').doc(user.uid).delete();

        // Delete user from Firebase Authentication
        await user.delete();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User deleted successfully')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete user: $e')),
      );
    }
  }






  String? _validatePassword(String? value) {
    if (value!.isEmpty) {
      return 'Password is required'; }
    else if (value.length < 8) {
      return 'Password must be at least 8 characters long'; }
    else if (!RegExp(r'^(?=.*[A-Z])').hasMatch(value)) {
      return 'Password must include at least one uppercase letter'; }
    else if (!RegExp(r'^(?=.*[a-z])').hasMatch(value)) {
      return 'Password must include at least one lowercase letter'; }
    else if (!RegExp(r'^(?=.*\d)').hasMatch(value)) {
      return 'Password must include at least one number'; }
    else if (!RegExp(r'^(?=.*[\W_])').hasMatch(value)) {
      return 'Password must include at least one special character'; }
    return null; }

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
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      body: Container(
        height: 810,
        width: 500,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/blue background.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                "Confirm Delete User ",
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[100],
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 350,

                child: Text(_user!.email.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22.5),),
              ),
              SizedBox(height: 20),
              Form(
                key: _formkey,
                child: TextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.emailAddress,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.blue.withOpacity(0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    labelText: "Enter Password for confirmation ",
                    labelStyle: TextStyle(
                      color: Colors.blue[100],
                      fontSize: 20,
                    ),
                    prefixIcon: Icon(Icons.mail),
                  ),
                  validator: _validatePassword,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formkey.currentState?.validate() ?? false) {
                    _deleteUser();



                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Homepage()),
                    );
                  }

                },
                child: Text('Delete User'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
