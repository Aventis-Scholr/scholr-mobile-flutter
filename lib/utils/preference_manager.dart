import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager {
  static const _userIdKey = 'user_id';
  static const _usernameKey = 'username';
  static const _tokenKey = 'token';
  static const _rolesKey = 'roles';

  static Future<void> saveUser(int userId, String username, String token, List<String> roles) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_userIdKey, userId);
    await prefs.setString(_usernameKey, username);
    await prefs.setString(_tokenKey, token);
    await prefs.setStringList(_rolesKey, roles);
  }

  static Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_userIdKey);
  }

  static Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_usernameKey);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  static Future<List<String>?> getUserRoles() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_rolesKey);
  }

  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
