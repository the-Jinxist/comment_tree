<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

# Comment Tree Package

A package that provides a widget used to replicate the comment tree view in the new youtube app

## Features

This package adds a link between the parent widgets and it's children widgets

## Getting started

```yaml

dependencies:
  comment_tree: <latest_version>

```

## Usage

```dart

CommentTreeWidget(
    treeColor: Theme.of(context).colorScheme.primaryContainer,
    parent: Comment(comment: subCommentText),
    children: [
    Comment(comment: subCommentText),
    Comment(comment: subCommentText),
    Comment(),
    ],
),

```

Which would look like this:

[![screen](https://raw.githubusercontent.com/the-Jinxist/comment_tree/main/media/tree_example.png)](https://github.com/the-Jinxist/comment_tree.git)