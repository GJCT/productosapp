import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

class AuthServices extends ChangeNotifier{

  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _fireBaseTocken = 'AIzaSyDC93iPa_p1Sn37WY-h0fZ8f0F7BghuUHc';

  final storage = const FlutterSecureStorage();

  //Retornar algo es un error, de lo contrario status 200 
  Future<String?> createUser(String email, String password) async{
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final url = Uri.https(_baseUrl, '/v1/accounts:signUp',{
      'key': _fireBaseTocken
    });

    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    if(decodedResp.containsKey('idToken')){
      //TOKEN Seguridad ante todo
      await storage.write(key: 'idToken', value: decodedResp['idToken']);
      //decodedResp['idToken'];
      return null;
    } else {
      return decodedResp['error']['message'];
    }
  }

  Future<String?> loginUser(String email, String password) async{
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final url = Uri.https(_baseUrl, '/v1/accounts:signInWithPassword',{
      'key': _fireBaseTocken
    });

    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    if(decodedResp.containsKey('idToken')){
      //TOKEN Seguridad ante todo
      await storage.write(key: 'idToken', value: decodedResp['idToken']);
      //decodedResp['idToken'];
      return null;
    } else {
      return decodedResp['error']['message'];
    }
  }

  Future logout() async{
    await storage.delete(key: 'idToken');
    return;
  }

  Future<String> readToken() async{
    return await storage.read(key: 'idToken') ?? '';
  }
}