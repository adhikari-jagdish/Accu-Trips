import 'package:accu_trips/common/widgets/side_nav/custom_super_tooltip.dart';
import 'package:super_tooltip/super_tooltip.dart';
import 'package:accu_trips/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomNavigationRail extends StatefulWidget {
  final int selectedIndex;
  final List<NavigationRailItem> items;
  final ValueChanged<int> onItemSelected;
  final bool isExpanded;
  final Widget? leading;
  final Color? backgroundColor;

  // Customizable properties
  final double iconSize;
  final double labelFontSize;
  final double itemBorderRadius;
  final double itemPadding;
  final double itemVerticalPadding;
  final double horizontalPadding;
  final double verticalItemSpacing;
  final Color selectedBackground;
  final Color selectedTextColor;
  final Color unselectedTextColor;
  final FontWeight selectedFontWeight;
  final FontWeight unselectedFontWeight;

  const CustomNavigationRail({
    super.key,
    required this.selectedIndex,
    required this.items,
    required this.onItemSelected,
    required this.isExpanded,
    this.leading,
    this.backgroundColor,
    this.iconSize = 20,
    this.labelFontSize = 13,
    this.itemBorderRadius = 10,
    this.itemPadding = 10,
    this.itemVerticalPadding = 8,
    this.horizontalPadding = 6,
    this.verticalItemSpacing = 3,
    this.selectedBackground = Colors.white,
    this.selectedTextColor = const Color(0xFF113C7C),
    this.unselectedTextColor = Colors.white70,
    this.selectedFontWeight = FontWeight.w600,
    this.unselectedFontWeight = FontWeight.w500,
  });

  @override
  State<CustomNavigationRail> createState() => _CustomNavigationRailState();
}

class _CustomNavigationRailState extends State<CustomNavigationRail> {
  late List<SuperTooltipController> _tooltipControllers;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _tooltipControllers = List.generate(widget.items.length, (index) => SuperTooltipController());
  }

  @override
  void didUpdateWidget(CustomNavigationRail oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items.length != widget.items.length) {
      // Dispose old controllers
      for (var controller in _tooltipControllers) {
        controller.dispose();
      }
      // Create new controllers
      _tooltipControllers = List.generate(widget.items.length, (index) => SuperTooltipController());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    for (var controller in _tooltipControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor ?? AppColors.colorPrimary,
      child: Column(
        children: [
          if (widget.leading != null) ...[
            Row(mainAxisAlignment: widget.isExpanded ? MainAxisAlignment.end : MainAxisAlignment.center, children: [widget.leading!]),
            const SizedBox(height: 8),
          ],
          Expanded(
            child: ScrollbarTheme(
              data: ScrollbarThemeData(
                thumbColor: WidgetStateProperty.all(Colors.white70),
                trackColor: WidgetStateProperty.all(Colors.white.withValues(alpha: 0.18)),
                trackBorderColor: WidgetStateProperty.all(Colors.transparent),
                radius: const Radius.circular(999),
                thickness: WidgetStateProperty.all(4),
                minThumbLength: 18,
                mainAxisMargin: 6,
                crossAxisMargin: 2,
              ),
              child: Scrollbar(
                controller: _scrollController,
                thumbVisibility: true,
                trackVisibility: true,
                interactive: true,
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.only(right: 3.0),
                  itemCount: widget.items.length,
                  itemBuilder: (context, index) {
                    final item = widget.items[index];
                    final isSelected = widget.selectedIndex == index;
                    final controller = _tooltipControllers[index];

                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: widget.horizontalPadding, vertical: widget.verticalItemSpacing),
                      child: CustomSuperTooltip(
                        controller: controller,
                        isExpanded: widget.isExpanded,
                        backgroundColor: widget.backgroundColor,
                        borderColor: widget.selectedBackground,
                        content: Text(
                          item.title,
                          style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              widget.onItemSelected(index);
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.easeInOut,
                              padding: EdgeInsets.symmetric(horizontal: widget.itemPadding, vertical: widget.itemVerticalPadding),
                              decoration: BoxDecoration(
                                color: isSelected ? widget.selectedBackground : Colors.transparent,
                                borderRadius: BorderRadius.circular(widget.itemBorderRadius),
                                boxShadow: isSelected ? [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 8, offset: const Offset(0, 2))] : [],
                              ),
                              child: widget.isExpanded ? _buildExpandedItem(item, isSelected) : _buildCollapsedItem(item, isSelected),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandedItem(NavigationRailItem item, bool isSelected) {
    return SizedBox(
      height: 24,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: widget.iconSize,
            height: widget.iconSize,
            child: SvgPicture.asset(item.iconPath, fit: BoxFit.contain, colorFilter: ColorFilter.mode(isSelected ? widget.selectedTextColor : widget.unselectedTextColor, BlendMode.srcIn)),
          ),
          SizedBox(width: 10),
          Flexible(
            child: Text(
              item.title,
              style: TextStyle(
                color: isSelected ? widget.selectedTextColor : widget.unselectedTextColor,
                fontSize: widget.labelFontSize,
                fontWeight: isSelected ? widget.selectedFontWeight : widget.unselectedFontWeight,
                letterSpacing: isSelected ? 0.3 : 0,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCollapsedItem(NavigationRailItem item, bool isSelected) {
    return SvgPicture.asset(
      item.iconPath,
      width: widget.iconSize,
      height: widget.iconSize,
      fit: BoxFit.contain,
      colorFilter: ColorFilter.mode(isSelected ? widget.selectedTextColor : widget.unselectedTextColor, BlendMode.srcIn),
    );
  }
}

class NavigationRailItem {
  final String iconPath;
  final String title;
  final String? route;

  NavigationRailItem({required this.iconPath, required this.title, this.route});
}
