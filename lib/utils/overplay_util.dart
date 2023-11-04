import 'package:flutter/material.dart';

import '../constants/constants.dart';

class OverlayUtil {
  OverlayEntry? overlayEntry;
  OverlayState? overlayState;
  Offset getWidgetInfo(GlobalKey buttonKey) {
    final result = buttonKey.currentContext!.findRenderObject() as RenderBox;
    final offset = result.localToGlobal(result.size.topRight(Offset.zero));
    return offset;
  }

  void showOverlay({
    required GlobalKey buttonKey,
    required LayerLink layerLink,
    required double width,
    required Widget widget,
    required BuildContext context,
   
  }) {
    final offset = getWidgetInfo(buttonKey);
    overlayEntry = OverlayEntry(builder: (BuildContext context) {
      return Positioned(
        left: offset.dx,
        top: offset.dy,
        child: CompositedTransformFollower(
          link: layerLink,
          targetAnchor: Alignment.bottomRight,
          showWhenUnlinked: false,
          child: Container(
              width: width,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color:Theme.of(context).colorScheme.onBackground ,
                  border: Border.all(width: 1, color: primaryColor)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            destroy(overlayEntry);
                          },
                          child: Icon(
                            Icons.close_outlined,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  widget
                ],
              )),
        ),
      );
    });
    overlayState = Overlay.of(context);
    overlayState!.insert(overlayEntry!);
  }

  void destroy(OverlayEntry? overlayEntry) {
    overlayEntry!.remove();
  }
}
