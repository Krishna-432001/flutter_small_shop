import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/Profile.dart';

class ProfileDetailScreen extends StatefulWidget {
  @override
  _ProfileDetailScreenState createState() => _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends State<ProfileDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _phone = '';
  String _address = '';
  String _pincode = '';
  String _country = '';
  String _gender = '';
  String _captcha = '';

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final profile = Profile(
        name: _name,
        email: _email,
        phone: _phone,
        address: _address,
        pincode: _pincode,
        country: _country,
        gender: _gender,
        captcha: _captcha,
      );

      final response = await http.post(
        Uri.parse('https://your-laravel-backend-url/api/profile'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(profile.toJson()),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile saved successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save profile.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile Details')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Center(
                child: CircleAvatar(
                  radius: 50,
                  child: Icon(
                    Icons.person,
                    size: 50,
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Phone'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _phone = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Address'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
                onSaved: (value) {
                  _address = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Pincode'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your pincode';
                  }
                  return null;
                },
                onSaved: (value) {
                  _pincode = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Country'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your country';
                  }
                  return null;
                },
                onSaved: (value) {
                  _country = value!;
                },
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Gender'),
                value: _gender,
                items: ['Male', 'Female', 'Other']
                    .map((label) => DropdownMenuItem(
                  child: Text(label),
                  value: label,
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _gender = value!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select your gender';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Captcha'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the captcha';
                  }
                  return null;
                },
                onSaved: (value) {
                  _captcha = value!;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveProfile,
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}