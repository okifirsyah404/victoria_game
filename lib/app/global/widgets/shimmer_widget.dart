import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:victoria_game/app/global/themes/colors_theme.dart';

class ShimmerWidget extends StatefulWidget {
  const ShimmerWidget({super.key, required this.child});
  final Widget child;

  @override
  State<ShimmerWidget> createState() => _ShimmerWidgetState();
}

class _ShimmerWidgetState extends State<ShimmerWidget> {
  var myChildSize = Size.zero;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      child: widget.child,
      baseColor: ColorsTheme.neutralColor[600] ?? ColorsTheme.neutralColor,
      highlightColor: ColorsTheme.neutralColor[400] ?? ColorsTheme.neutralColor,
    );
  }
}
