import 'package:flutter/material.dart';
import '../models/comment.dart';
import '../services/post_service.dart';

class CommentsProvider with ChangeNotifier {
  final PostService _service;
  List<Comment> _comments = [];
  bool _isLoading = false;
  String? _error;

  CommentsProvider(this._service);

  List<Comment> get comments => _comments;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadComments(int postId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _comments = await _service.fetchComments(postId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}