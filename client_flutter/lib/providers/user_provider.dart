// lib/providers/user_provider.dart
import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/user_service.dart';

class UserProvider with ChangeNotifier {
  final UserService _userService = UserService();
  List<User> _users = [];

  List<User> get users => _users;

  UserProvider() {
    fetchUsers(); // Fetch users when the provider is initialized
  }

  Future<void> fetchUsers() async {
    try {
      _users = await _userService.getAllUsers();
      notifyListeners(); // Notify listeners that the data has changed
    } catch (error) {
      print('Failed to fetch users: $error');
    }
  }

  Future<void> addUser(User user) async {
    try {
      await _userService.createUser(user);
      _users.add(user);
      notifyListeners(); // Notify listeners after adding the user
    } catch (error) {
      print('Failed to add user: $error');
    }
  }
}
