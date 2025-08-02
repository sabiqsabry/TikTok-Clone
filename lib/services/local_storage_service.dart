import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String _userKey = 'current_user';
  static const String _videosKey = 'videos';
  static const String _likedVideosKey = 'liked_videos';
  static const String _followingUsersKey = 'following_users';

  static LocalStorageService? _instance;
  static SharedPreferences? _preferences;

  LocalStorageService._();

  static Future<LocalStorageService> getInstance() async {
    if (_instance == null) {
      _instance = LocalStorageService._();
      _preferences = await SharedPreferences.getInstance();
    }
    return _instance!;
  }

  // User management
  Future<void> saveUser(Map<String, dynamic> userData) async {
    await _preferences!.setString(_userKey, jsonEncode(userData));
  }

  Map<String, dynamic>? getUser() {
    final userString = _preferences!.getString(_userKey);
    if (userString != null) {
      return jsonDecode(userString) as Map<String, dynamic>;
    }
    return null;
  }

  // Videos management
  Future<void> saveVideos(List<Map<String, dynamic>> videos) async {
    await _preferences!.setString(_videosKey, jsonEncode(videos));
  }

  List<Map<String, dynamic>> getVideos() {
    final videosString = _preferences!.getString(_videosKey);
    if (videosString != null) {
      final List<dynamic> videosList = jsonDecode(videosString);
      return videosList.cast<Map<String, dynamic>>();
    }
    return [];
  }

  // Liked videos management
  Future<void> toggleLikedVideo(String videoId) async {
    final likedVideos = getLikedVideos();
    if (likedVideos.contains(videoId)) {
      likedVideos.remove(videoId);
    } else {
      likedVideos.add(videoId);
    }
    await _preferences!.setStringList(_likedVideosKey, likedVideos);
  }

  List<String> getLikedVideos() {
    return _preferences!.getStringList(_likedVideosKey) ?? [];
  }

  // Following users management
  Future<void> toggleFollowingUser(String userId) async {
    final followingUsers = getFollowingUsers();
    if (followingUsers.contains(userId)) {
      followingUsers.remove(userId);
    } else {
      followingUsers.add(userId);
    }
    await _preferences!.setStringList(_followingUsersKey, followingUsers);
  }

  List<String> getFollowingUsers() {
    return _preferences!.getStringList(_followingUsersKey) ?? [];
  }

  // Clear all data
  Future<void> clearAllData() async {
    await _preferences!.clear();
  }
}
