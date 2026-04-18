import 'package:flutter/material.dart';
import 'package:super_tooltip/super_tooltip.dart';

class CustomSuperTooltip extends StatelessWidget {
  const CustomSuperTooltip({super.key, required this.child, required this.content, this.backgroundColor, this.controller, this.borderColor, this.isExpanded = false});
  final Widget child;
  final Widget content;
  final Color? backgroundColor;
  final SuperTooltipController? controller;
  final Color? borderColor;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    if (isExpanded) {
      return child; // Don't wrap with tooltip when expanded
    }
    return SuperTooltip(
      controller: controller,
      overlayDimensions: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      style: TooltipStyle(
        backgroundColor: backgroundColor ?? Colors.blue,
        borderColor: borderColor ?? Colors.white,
        borderWidth: 2.0,
        borderRadius: 10.0,
        elevation: 5.0,
        hasShadow: true,
        shadowColor: Colors.black26,
        shadowBlurRadius: 20.0,
        bubbleDimensions: EdgeInsets.all(12),
      ),
      positionConfig: PositionConfiguration(
        preferredDirection: TooltipDirection.right,
        // minimumOutsideMargin: 60.0,
        snapsFarAwayVertically: false,
        snapsFarAwayHorizontally: false,
        right: 100,
      ),
      arrowConfig: const ArrowConfiguration(length: 8.0, baseWidth: 10.0, tipDistance: 30.0),
      interactionConfig: InteractionConfiguration(
        showOnHover: true, // Show on mouse hover (Web/Desktop)
        hideOnHoverExit: true, // Hide when mouse leaves
        toggleOnTap: true, // Toggle on/off with taps
        hideOnTap: true, // Hide when tooltip is tapped
        hideOnBarrierTap: true, // Hide when barrier is tapped
        hideOnScroll: true, // Hide on scroll
        clickThrough: true, // Allow clicks through tooltip
      ),
      animationConfig: AnimationConfiguration(
        fadeInDuration: Duration(milliseconds: 300),
        fadeOutDuration: Duration(milliseconds: 200),
        waitDuration: Duration(milliseconds: 300), // Delay before showing
        showDuration: Duration(milliseconds: 300), // Auto-dismiss after duration
        exitDuration: Duration(milliseconds: 50), // Hover exit delay
      ),
      content: content,
      child: child,
    );
  }
}
