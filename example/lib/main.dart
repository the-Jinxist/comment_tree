import 'package:comment_tree/comment_tree.dart';
import 'package:example/comment.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Comment Tree Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const subCommentText =
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit.";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Comment Tree Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CommentTreeWidget(
              parent: const Comment(),
              children: [
                Comment(comment: subCommentText),
                Comment(comment: subCommentText),
                Comment(comment: subCommentText),
                CommentTreeWidget(
                  parent: Comment(comment: subCommentText),
                  children: [
                    Comment(comment: subCommentText),
                    Comment(comment: subCommentText),
                    Comment(),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
