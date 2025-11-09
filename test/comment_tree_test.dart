import 'package:comment_tree/core/comment_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CommentTreeWidget Tests |', () {
    testWidgets('Verify that the CommentTreeWidget can be rendered', (
      tester,
    ) async {
      final widget = MaterialApp(home: CommentTreeWidget(parent: Text('Here')));
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();

      expect(find.text('Here'), findsOne);
    });

    testWidgets(
      'Verify that the CommentTreeWidget can be rendered with the children',
      (tester) async {
        final widget = MaterialApp(
          home: CommentTreeWidget(
            parent: Text('Here'),
            children: [Text('child one')],
          ),
        );
        await tester.pumpWidget(widget);
        await tester.pumpAndSettle();

        expect(find.text('Here'), findsOne);
        expect(find.text('child one'), findsOne);
      },
    );
  });
}
