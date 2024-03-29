import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../models/user.dart';
import 'login/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, this.firebaseUser}) : super(key: key);

  final User? firebaseUser;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserModel? user;
  String? fullName;
  String? email;
  String? phone;


  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    try {
      if (widget.firebaseUser != null) {

        DocumentSnapshot<Map<String, dynamic>> userSnapshot = await FirebaseFirestore.instance
            .collection('Userjaa')
            .doc(widget.firebaseUser!.email)
            .get();

        if (userSnapshot.exists) {
          setState(() {
             user = UserModel.fromSnapshot(userSnapshot);
          });
        } else {
          // Handle the case where the user document doesn't exist
          print('User document not found');
       }
      }
    } catch (e) {
      print('Error fetching user data: $e');
      // Display an error message to the user
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // TODO: Navigate to edit profile page
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder(
            future: getUserData(),
            builder: (context, snapshot) {
              // Display a progress indicator while data is being fetched
              if (snapshot.connectionState == ConnectionState.waiting) {
                print('User found'); //Center(child: CircularProgressIndicator());
              }

              // Handle errors and display a message
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              // Display profile content
              return buildProfileContent(context, snapshot);
            },
          ),
        ),
      ),
    );
  }
  Widget buildProfileContent(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: Column(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 93.0,
                      backgroundColor: Theme.of(context).colorScheme.onPrimary,
                      child: CircleAvatar(
                        radius: 90.0,
                        backgroundImage: AssetImage('images/person.jpeg'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        user?.fullName ?? 'No name found',
                        style: Theme.of(context).textTheme.headline5,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Text(
                        user?.email ?? 'No email found',
                      style: TextStyle(color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 24),
        Text(
          'Name',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.left,
        ),
        SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.black),
            ),
          ),
          child: Text(
          user?.fullName ?? 'No name found',
            style: TextStyle(fontSize: 24),
            textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: 24),
        Text(
          'Email',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.left,
        ),
        SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.black),
            ),
          ),
          child: Text(
            user?.email ?? 'No email found',
            style: TextStyle(fontSize: 24),
            textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: 24),
        Text(
          'Phone Number',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.left,
        ),
        SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.black),
            ),
          ),
          child: Text(
            user?.phone ?? 'No phone found',
            style: TextStyle(fontSize: 24),
            textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: 24),
        Text(
          'Password',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.left,
        ),
        SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.black),
            ),
          ),
          child: Text(
            '********',
            style: TextStyle(fontSize: 24),
            textAlign: TextAlign.justify,
          ),
        ),
        SizedBox(height: 24),
        ElevatedButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
                  (route) => false, // Clear all routes in the stack
            );
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.red, // Background color
            onPrimary: Colors.white, // Text color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // Rounded corners
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              "Logout",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}

class LogoutButton extends StatelessWidget {
  final BuildContext context;
  final VoidCallback onPressed;

  const LogoutButton({
    required this.context,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text("Logout"),
    );
  }
}
