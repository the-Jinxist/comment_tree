import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

enum MyLayoutId { base }

class YtMultiChildObject extends MultiChildRenderObjectWidget {
  YtMultiChildObject({
    super.key,
    required Widget parent,
    List<Widget> children = const <Widget>[],
  }) : super(
         children: [
           LayoutId(id: MyLayoutId.base, child: parent),
           // Tag the rest of the children
           ...children.map((child) => child),
         ],
       );

  @override
  RenderObject createRenderObject(BuildContext context) {
    return YtMultiChildObjectRenderObject();
  }

  @override
  void updateRenderObject(
    BuildContext context,
    covariant RenderObject renderObject,
  ) {
    super.updateRenderObject(context, renderObject);
  }
}

class YtMultiChildObjectRenderObject extends RenderBox
    with ContainerRenderObjectMixin<RenderBox, MultiChildLayoutParentData> {
  @override
  void setupParentData(RenderObject child) {
    if (child.parentData is! MultiChildLayoutParentData) {
      child.parentData = MultiChildLayoutParentData();
    }
  }

  (RenderBox?, List<RenderBox>) extractBaseAndChildBoxes() {
    RenderBox? baseChild;
    final otherChildren = <RenderBox>[];

    // Iterate through all children
    var child = firstChild;
    while (child != null) {
      final parentData = child.parentData as MultiChildLayoutParentData;
      if (parentData.id == MyLayoutId.base) {
        baseChild = child;
      } else {
        otherChildren.add(child);
      }
      child = childAfter(child);
    }

    return (baseChild, otherChildren);
  }

  @override
  void performLayout() {
    RenderBox? baseChild;
    List otherChildren = <RenderBox>[];

    // Iterate through all children
    (baseChild, otherChildren) = extractBaseAndChildBoxes();
    assert(baseChild != null, "base child cannot be equal to null");

    double dy = 0;
    final biggestSize = constraints.biggest;

    baseChild!.layout(
      constraints.tighten(width: biggestSize.width),
      parentUsesSize: true,
    );

    dy = baseChild.size.height + 10;

    for (final child in otherChildren) {
      final parentData = child.parentData as MultiChildLayoutParentData;
      log(" before: ${parentData.offset}");

      parentData.offset = Offset(50, dy);

      log(" after: ${parentData.offset}");

      child.layout(
        constraints.tighten(
          width: biggestSize.width - (parentData.offset.dx + 20),
        ),
        parentUsesSize: true,
      );

      dy = dy + child.size.height + 10;
    }

    final maxWidth = _maxChildWidth(baseChild);
    size = constraints.constrain(Size(maxWidth, dy));
  }

  double _maxChildWidth(RenderBox? baseChild) {
    double maxWidth = baseChild?.size.width ?? 0;

    RenderBox? child = firstChild;

    while (child != null) {
      maxWidth = math.max(child.size.width, maxWidth);
      child = childAfter(child);
    }

    return maxWidth;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    RenderBox? baseChild;
    List otherChildren = <RenderBox>[];

    // Iterate through all children
    (baseChild, otherChildren) = extractBaseAndChildBoxes();
    assert(baseChild != null, "base child cannot be equal to null");

    final parentData = baseChild!.parentData as MultiChildLayoutParentData;
    context.paintChild(baseChild, offset + parentData.offset);

    final rawParentNode = offset + parentData.offset;
    final treeParentNode = Offset(rawParentNode.dx + 10, rawParentNode.dy + 25);

    List<Offset> childOffests = [];

    for (final child in otherChildren) {
      final childData = child.parentData as MultiChildLayoutParentData;
      context.paintChild(child, offset + childData.offset);

      childOffests.add(offset + childData.offset);
    }

    final canvas = context.canvas;
    final paintLine = Paint()
      ..color = Colors.pink
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final path = Path();
    path.moveTo(treeParentNode.dx, treeParentNode.dy);

    for (final offset in childOffests) {
      path.cubicTo(
        treeParentNode.dx,
        offset.dy + 20,
        treeParentNode.dx - 10,
        offset.dy + 10,
        offset.dx - 10,
        offset.dy + 10,
      );
      canvas.drawPath(path, paintLine);
      path.moveTo(treeParentNode.dx, treeParentNode.dy);
    }
  }
}
