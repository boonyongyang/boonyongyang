import 'package:flutter/material.dart';
import '../../utils/responsive_utils.dart';

class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final double? maxWidth;
  final bool centerContent;

  const ResponsiveContainer({
    super.key,
    required this.child,
    this.padding,
    this.maxWidth,
    this.centerContent = true,
  });

  @override
  Widget build(BuildContext context) {
    final effectivePadding =
        padding ?? ResponsiveUtils.getContentPadding(context);
    final effectiveMaxWidth =
        maxWidth ?? ResponsiveUtils.getMaxContentWidth(context);

    Widget content = Container(
      padding: effectivePadding,
      constraints: BoxConstraints(
        maxWidth: effectiveMaxWidth,
      ),
      child: child,
    );

    if (centerContent) {
      content = Center(child: content);
    }

    return content;
  }
}

/// A responsive grid that automatically adjusts columns based on screen size
class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final double spacing;
  final double runSpacing;
  final int? mobileColumns;
  final int? tabletColumns;
  final int? desktopColumns;

  const ResponsiveGrid({
    super.key,
    required this.children,
    this.spacing = 16.0,
    this.runSpacing = 16.0,
    this.mobileColumns,
    this.tabletColumns,
    this.desktopColumns,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final isTablet = ResponsiveUtils.isTablet(context);

    int columns;
    if (isMobile) {
      columns = mobileColumns ?? 1;
    } else if (isTablet) {
      columns = tabletColumns ?? 2;
    } else {
      columns = desktopColumns ?? 3;
    }

    if (columns == 1) {
      return Column(
        children: children
            .map((child) => Padding(
                  padding: EdgeInsets.only(bottom: runSpacing),
                  child: child,
                ))
            .toList(),
      );
    }

    return Wrap(
      spacing: spacing,
      runSpacing: runSpacing,
      children: children
          .map((child) => SizedBox(
                width: (MediaQuery.of(context).size.width -
                        (spacing * (columns - 1)) -
                        (ResponsiveUtils.getHorizontalPadding(context) * 2)) /
                    columns,
                child: child,
              ))
          .toList(),
    );
  }
}

/// Responsive text that scales based on screen size
class ResponsiveText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final double? scaleFactor;

  const ResponsiveText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.scaleFactor,
  });

  @override
  Widget build(BuildContext context) {
    final fontScale = scaleFactor ?? ResponsiveUtils.getFontScale(context);
    final adjustedStyle = style?.copyWith(
      fontSize: (style?.fontSize ?? 14) * fontScale,
    );

    return Text(
      text,
      style: adjustedStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
