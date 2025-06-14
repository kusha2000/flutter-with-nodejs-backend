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

  Future<void> updateUser(User user) async {
    try {
      await _userService.updateUser(user);
      int index = _users.indexWhere((u) => u.id == user.id);
      if (index != -1) {
        _users[index] = user;
        notifyListeners(); // Notify listeners after updating the user
      }
    } catch (error) {
      print('Failed to update user: $error');
    }
  }

  Future<void> deleteUser(String id) async {
    try {
      await _userService.deleteUser(id);
      _users.removeWhere((user) => user.id == id);
      notifyListeners(); // Notify listeners after deleting the user
    } catch (error) {
      print('Failed to delete user: $error');
    }
  }
}
