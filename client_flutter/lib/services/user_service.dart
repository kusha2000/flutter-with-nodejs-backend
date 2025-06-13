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

  Future<User> getUser(String id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$id'));
      if (response.statusCode == 200) {
        return User.fromJson(json.decode(response.body));
      } else {
        print('Failed to load user: ${response.statusCode}');
        throw Exception('Failed to load user');
      }
    } catch (e) {
      print('Error fetching user: $e');
      rethrow;
    }
  }

  Future<void> createUser(User user) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: json.encode(user.toJson()),
      );
      if (response.statusCode != 201) {
        print('Failed to create user: ${response.statusCode}');
        throw Exception('Failed to create user');
      }
    } catch (e) {
      print('Error creating user: $e');
      rethrow;
    }
  }

}
