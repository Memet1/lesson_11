import 'package:flutter/material.dart';
import '../models/post.dart';
import '../services/post_service.dart';

class PostProvider with ChangeNotifier {
  final PostService _service;
  List<Post> _posts = [];
  bool _isLoading = false;
  String? _error;

  PostProvider(this._service);

  List<Post> get posts => _posts;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadPosts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _posts = await _service.fetchPosts();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> deletePost(int id) async {
    final success = await _service.deletePost(id);
    if (success) {
      _posts.removeWhere((p) => p.id == id);
      notifyListeners();
    }
    return success;
  }
}