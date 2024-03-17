import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ProfileEditPage extends StatefulWidget {
  final AppUser appUser;
  final User firebaseUser;

  const ProfileEditPage({Key? key, required this.appUser, required this.firebaseUser}) : super(key: key);

  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  final _formKey = GlobalKey<FormState>(); // Add this line

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.appUser.firstName);
    _lastNameController = TextEditingController(text: widget.appUser.lastName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Use the _formKey variable here
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                ),
                onSaved: (value) => setState(() {
                  widget.appUser.firstName = value;
                }),
              ),
              SizedBox(height: 12.0),
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                ),
                onSaved: (value) => setState(() {
                  widget.appUser.lastName = value;
                }),
              ),
              SizedBox(height: 12.0),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                initialValue: widget.firebaseUser.email,
                enabled: false,
              ),
              SizedBox(height: 12.0),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
                initialValue: '••••••••', // You cannot display the actual password for security reasons
                enabled: false,
              ),
              SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    try {
                      await FirebaseFirestore.instance.collection('users').doc(widget.firebaseUser.uid).set(widget.appUser.toMap());
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Save successful'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Save failed: $e'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}