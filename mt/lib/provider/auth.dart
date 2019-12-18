import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mt/models/http_exception.dart';

class Auth with ChangeNotifier {
  //String _token;
  //DateTime _expiryDate;
  //String _userId;

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyDUJ3WB2oF-mJY435wHmf3-qQJNQg5fUAM';

    try {
      final response = await http.post(url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));

      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        print('error');
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    try {
      final response = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
          


      print('hvgv');
     // FirebaseUser user = response.user;
  
      print('hvgv');

      //print(response.additionalUserInfo.profile);

    } catch (error) {
      
      print(error);
      print('some error in sign in');
      throw HttpException(error);
    }
    // return _authenticate(email, password, 'signInWithCustomToken');
  }
}
