import 'package:accu_trips/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Reusable CRUD table widget with search, add button, header, rows and pagination.
/// Used across all Accounts sub-modules for a consistent look.
class CrudTable<T> extends StatelessWidget {
  const CrudTable({
    super.key,
    required this.title,
    required this.columns,
    required this.items,
    required this.rowBuilder,
    required this.isLoading,
    this.onSearch,
    this.onAdd,
    this.addLabel,
    this.onRefresh,
    this.currentPage,
    this.totalPages,
    this.totalCount,
    this.onPageChanged,
  });

  final String title;
  final List<(String label, int flex)> columns;
  final List<T> items;
  final Widget Function(T item, int index) rowBuilder;
  final bool isLoading;
  final ValueChanged<String>? onSearch;
  final VoidCallback? onAdd;
  final String? addLabel;
  final VoidCallback? onRefresh;
  final int? currentPage;
  final int? totalPages;
  final int? totalCount;
  final ValueChanged<int>? onPageChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 12, offset: const Offset(0, 3))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title bar with search and add button
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.responsiveValue(mobile: 12.0, tablet: 16.0, desktop: 20.0),
              vertical: context.responsiveValue(mobile: 10.0, tablet: 14.0, desktop: 16.0),
            ),
            child: Row(
              spacing: 12,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: context.responsiveValue(mobile: 16.0, tablet: 18.0, desktop: 20.0),
                      fontWeight: FontWeight.w700,
                      color: AppColors.colorPrimaryDark,
                      letterSpacing: -0.3,
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (onSearch != null)
                      SizedBox(
                        width: context.responsiveValue(mobile: 160.0, tablet: 200.0, desktop: 260.0),
                        height: 36,
                        child: TextField(
                          onChanged: onSearch,
                          style: const TextStyle(fontSize: 13),
                          decoration: InputDecoration(
                            hintText: 'Search...',
                            hintStyle: const TextStyle(fontSize: 12, color: Color(0xFF92A5C3)),
                            prefixIcon: const Icon(Icons.search, size: 17, color: Color(0xFF9CA3AF)),
                            contentPadding: EdgeInsets.zero,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: AppColors.colorPrimaryDark, width: 1.5),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFF9FAFB),
                          ),
                        ),
                      ),
                    if (onAdd != null) ...[
                      const SizedBox(width: 10),
                      SizedBox(
                        height: 36,
                        child: ElevatedButton.icon(
                          onPressed: onAdd,
                          icon: const Icon(Icons.add, size: 16, color: Colors.white),
                          label: Text(
                            addLabel ?? 'Add New',
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12.5),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF5A623),
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ),
                    ],
                    if (onRefresh != null) ...[
                      const SizedBox(width: 8),
                      SizedBox(
                        height: 36,
                        width: 36,
                        child: IconButton(
                          onPressed: onRefresh,
                          icon: const Icon(Icons.refresh, size: 18, color: AppColors.colorPrimaryDark),
                          tooltip: 'Refresh',
                          style: IconButton.styleFrom(
                            backgroundColor: const Color(0xFFF0F4FA),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),

          // Table header + body (horizontally scrollable)
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                const double minTableWidth = 900;
                final tableWidth = constraints.maxWidth < minTableWidth ? minTableWidth : constraints.maxWidth;
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: tableWidth,
                    height: constraints.maxHeight,
                    child: Column(
                      children: [
                        _buildTableHeader(context),
                        Expanded(
                          child: isLoading
                              ? const Center(child: CircularProgressIndicator(color: AppColors.colorPrimary, strokeWidth: 2.5))
                              : items.isEmpty
                              ? Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.inbox_outlined, size: 48, color: Colors.grey.shade300),
                                      const SizedBox(height: 10),
                                      const Text('No records found', style: TextStyle(color: Color(0xFF6B7280), fontSize: 13)),
                                    ],
                                  ),
                                )
                              : ListView.builder(itemCount: items.length, itemBuilder: (ctx, i) => rowBuilder(items[i], i)),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Pagination
          if (currentPage != null) _CrudPagination(currentPage: currentPage!, totalPages: totalPages ?? 1, totalCount: totalCount ?? items.length, onPageChanged: onPageChanged),
        ],
      ),
    );
  }

  Widget _buildTableHeader(BuildContext context) {
    return Container(
      color: AppColors.colorPrimary,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: context.responsiveValue(mobile: 10.0, tablet: 16.0, desktop: 20.0)),
      child: Row(
        children: List.generate(columns.length * 2 - 1, (index) {
          if (index.isEven) {
            final col = columns[index ~/ 2];
            return Expanded(
              flex: col.$2,
              child: Text(
                col.$1,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 10.5, fontWeight: FontWeight.w700, letterSpacing: 0.5, color: Colors.white),
              ),
            );
          } else {
            return Container(width: 1, height: 18, color: Colors.white24, margin: const EdgeInsets.symmetric(horizontal: 3));
          }
        }),
      ),
    );
  }
}

// Row cell helper

class CrudRowCell extends StatelessWidget {
  const CrudRowCell({super.key, required this.text, this.flex = 1, this.isWidget = false, this.child});
  final String text;
  final int flex;
  final bool isWidget;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child:
          child ??
          Text(
            text,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, color: AppColors.colorPrimaryDark),
          ),
    );
  }
}

// Pagination

class _CrudPagination extends StatelessWidget {
  const _CrudPagination({required this.currentPage, required this.totalPages, required this.totalCount, this.onPageChanged});
  final int currentPage;
  final int totalPages;
  final int totalCount;
  final ValueChanged<int>? onPageChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xFFF3F4F6))),
      ),
      child: Row(
        children: [
          Text('Page $currentPage of $totalPages  •  $totalCount entries', style: const TextStyle(fontSize: 11, color: Color(0xFF6B7280))),
          const Spacer(),
          _pageBtn(Icons.chevron_left, currentPage > 1 ? () => onPageChanged?.call(currentPage - 1) : null),
          ...List.generate(totalPages.clamp(0, 7), (i) {
            final p = i + 1;
            return _numBtn(p, p == currentPage);
          }),
          if (totalPages > 7) ...[
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 3),
              child: Text('...', style: TextStyle(fontSize: 11, color: Color(0xFF6B7280))),
            ),
            _numBtn(totalPages, totalPages == currentPage),
          ],
          _pageBtn(Icons.chevron_right, currentPage < totalPages ? () => onPageChanged?.call(currentPage + 1) : null),
        ],
      ),
    );
  }

  Widget _pageBtn(IconData icon, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 1),
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Icon(icon, size: 14, color: onTap != null ? AppColors.colorPrimary : const Color(0xFFD1D5DB)),
      ),
    );
  }

  Widget _numBtn(int page, bool isSelected) {
    return GestureDetector(
      onTap: () => onPageChanged?.call(page),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 1),
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.colorPrimaryDark : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: isSelected ? AppColors.colorPrimary : const Color(0xFFE5E7EB)),
        ),
        child: Center(
          child: Text(
            '$page',
            style: TextStyle(fontSize: 11, fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400, color: isSelected ? Colors.white : const Color(0xFF374151)),
          ),
        ),
      ),
    );
  }
}
