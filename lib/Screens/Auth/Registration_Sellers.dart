import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SellerRegistrationScreen extends StatefulWidget {
  @override
  _SellerRegistrationScreenState createState() => _SellerRegistrationScreenState();
}

class _SellerRegistrationScreenState extends State<SellerRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  String _firstName = '';
  String _lastName = '';
  String _businessSector = '';
  String _gstin = '';
  String _pan = '';
  String _email = '';
  String _phone = '';
  String _password = '';
  bool _termsAccepted = false;

  void _registerSeller() async {
    if (_formKey.currentState!.validate() && _termsAccepted) {
      await FirebaseFirestore.instance.collection('users').add({
        'role': 'seller',
        'firstName': _firstName,
        'lastName': _lastName,
        'businessSector': _businessSector,
        'gstin': _gstin,
        'pan': _pan,
        'email': _email,
        'phone': _phone,
        'password': _password, // Store password here
      });
      // Navigate to login or home screen
      Navigator.pushReplacementNamed(context, '/');
    }
  }

  InputDecoration _buildInputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(color: Colors.grey[700]),
      filled: true,
      fillColor: Colors.grey[200],
      contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: Colors.transparent),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: Colors.redAccent, width: 2.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seller Registration', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  'Create Seller Account',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  decoration: _buildInputDecoration('First Name'),
                  onChanged: (value) => _firstName = value,
                  validator: (value) => value!.isEmpty ? 'Please enter first name' : null,
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: _buildInputDecoration('Last Name'),
                  onChanged: (value) => _lastName = value,
                  validator: (value) => value!.isEmpty ? 'Please enter last name' : null,
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: _buildInputDecoration('Business Sector'),
                  onChanged: (value) => _businessSector = value,
                  validator: (value) => value!.isEmpty ? 'Please enter business sector' : null,
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: _buildInputDecoration('GSTIN'),
                  onChanged: (value) => _gstin = value,
                  validator: (value) => value!.isEmpty ? 'Please enter GSTIN' : null,
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: _buildInputDecoration('PAN'),
                  onChanged: (value) => _pan = value,
                  validator: (value) => value!.isEmpty ? 'Please enter PAN' : null,
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: _buildInputDecoration('Email'),
                  onChanged: (value) => _email = value,
                  validator: (value) => value!.isEmpty ? 'Please enter email' : null,
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: _buildInputDecoration('Phone Number'),
                  onChanged: (value) => _phone = value,
                  validator: (value) => value!.isEmpty ? 'Please enter phone number' : null,
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: _buildInputDecoration('Password'),
                  obscureText: true,
                  onChanged: (value) => _password = value,
                  validator: (value) => value!.isEmpty ? 'Please enter password' : null,
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Checkbox(
                      value: _termsAccepted,
                      onChanged: (value) => setState(() => _termsAccepted = value!),
                      activeColor: Colors.deepPurple,
                    ),
                    Expanded(child: Text('Accept terms and conditions')),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _registerSeller,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 40.0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(
                    'Register',
                    style: TextStyle(fontSize: 18,color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
