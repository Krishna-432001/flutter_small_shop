import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_small_shop/services/auth.dart';
import 'package:device_info_plus/device_info_plus.dart';

class LoginScreen extends StatefulWidget {
  final String title;

  const LoginScreen({super.key, required this.title});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  String _deviceName = '';

  void getDeviceName() async {
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        setState(() {
          _deviceName = androidInfo.model ?? 'unknown';
        });
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        setState(() {
          _deviceName = iosInfo.utsname.machine ?? 'unknown';
        });
      }
    } catch (e) {
      setState(() {
        _deviceName = 'unknown';
      });
    }
  }

  @override
  void initState() {
    _emailController.text = "admin@gmail.com";
    _passwordController.text = "admin";
    getDeviceName();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) =>
                value!.isEmpty ? 'Please enter a valid email' : null,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                validator: (value) =>
                value!.isEmpty ? 'Please enter a valid password' : null,
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Map creds = {
                      'email': _emailController.text,
                      'password': _passwordController.text,
                      'device_name': _deviceName,
                    };
                    Provider.of<Auth>(context, listen: false).login(creds: creds);
                    Navigator.pop(context);
                  }
                },
                style: TextButton.styleFrom(
                  minimumSize: Size(double.infinity, 40),
                  backgroundColor: Colors.blue,
                ),
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Device: $_deviceName',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_small_shop/services/auth.dart';
// import 'package:device_info_plus/device_info_plus.dart';
// class LoginScreen extends StatefulWidget {
//   final String title;
//
//   const LoginScreen({super.key, required this.title});
//
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   TextEditingController _emailController = TextEditingController();
//   TextEditingController _passwordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//   String _deviceName='';
//   void getDeviceName() async {
//     try {
//       if (Platform.isAndroid) {
//         AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
//         _deviceName = androidInfo.model;
//       }
//       else if (Platform.isIOS) {
//         IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
//         _deviceName = iosInfo.utsname.machine;
//       }
//     }
//     catch (e) {
//
//     }
//   }
//   @override
//   void initState(){
//     _emailController.text = "admin@gmail.com";
//     _passwordController.text = "admin";
//     getDeviceName();
//     super.initState();
//   }
//   @override
//   void dispose(){
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:Padding(
//         padding: const EdgeInsets.all(20.0),
//         child:Form(
//           key: _formKey,
//           child:Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               TextFormField(
//                 controller: _emailController,
//                 validator: (value) => value!.isEmpty ? 'Please enter valid email': null
//           ),
//           TextFormField(
//               controller: _passwordController,
//               validator: (value) => value!.isEmpty ? 'Please enter valid password': null
//           ),
//           TextButton(
//             onPressed: (){
//               Map creds={
//                 'email' : _emailController.text,
//                 'password' : _passwordController.text,
//                 'device_name' :_deviceName ?? 'unknown'
//               };
//               if(_formKey.currentState!.validate())
//                 {
//                   print('ok');
//                   print(_emailController.text);
//                   print(_passwordController.text);
//                   Provider.of<Auth>(context, listen: false).login(creds:creds);
//                   Navigator.pop(context);
//                 }
//             },
//             style:TextButton.styleFrom(
//               minimumSize: Size(double.infinity, 40),
//               backgroundColor:Colors.blue,
//             ),
//             child:Text(
//               'Login',
//               style: TextStyle(color:Colors.white),
//             ),
//
//         )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
