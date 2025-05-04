import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/comments_provider.dart';

class CommentsScreen extends StatefulWidget {
  final int postId;
  const CommentsScreen({Key? key, required this.postId}) : super(key: key);

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CommentsProvider>(context, listen: false).loadComments(widget.postId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Comments')),
      body: Consumer<CommentsProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) return const Center(child: CircularProgressIndicator());
          if (provider.error != null) return Center(child: Text('Error: ${provider.error}'));
          return ListView.builder(
            itemCount: provider.comments.length,
            itemBuilder: (context, index) {
              final comment = provider.comments[index];
              return ListTile(
                title: Text(comment.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(comment.email),
                    const SizedBox(height: 4),
                    Text(comment.body),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}