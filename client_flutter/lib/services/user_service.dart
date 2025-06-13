import 'dart:convert';
import 'package:client_flutter/models/user_model.dart';
import 'package:http/http.dart' as http;

const String baseUrl = 'http://192.168.8.213:5000/api/users';

class UserService {
  Future<List<User>> getAllUsers() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((json) => User.fromJson(json)).toList();
      } else {
        print('Failed to load users: ${response.statusCode}');
        throw Exception('Failed to load users');
      }
    } catch (e) {
      print('Error fetching users: $e');
      rethrow;
    }
  }
}
