import 'package:flutter/material.dart';

class Comment extends StatelessWidget {
  const Comment({super.key, this.subComment, this.comment});

  final String? comment;
  final List<Comment>? subComment;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(radius: 10),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                comment ??
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
              ),
            ),
          ],
        ),
        if ((subComment ?? []).isNotEmpty) ...[
          Column(
            children: (subComment ?? []).map((e) {
              return Padding(
                padding: EdgeInsets.only(left: 20, top: 10, right: 10),
                child: e,
              );
            }).toList(),
          ),
        ],
      ],
    );
  }
}
