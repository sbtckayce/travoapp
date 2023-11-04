import 'package:flutter/material.dart';
import '/animations/fade_animation.dart';

import '../utils/overplay_util.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({
    super.key,
    required this.buttonKey,
    required this.layerLink,
    required this.width,
    required this.widget,
    required this.color,
  });
  final GlobalKey buttonKey;
  final LayerLink layerLink;

  final double width;
  final Widget widget;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return FadeAnimation(
      child: CompositedTransformTarget(
        link: layerLink,
        child: GestureDetector(
          key: buttonKey,
          onTap: () {
            OverlayUtil().showOverlay(
                width: width,
                buttonKey: buttonKey,
                widget: widget,
                layerLink: layerLink,
                context: context,
                );
          },
          child: Icon(
            Icons.info_outline,
            color: color,
          ),
        ),
      ),
    );
  }
}
