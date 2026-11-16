import 'package:flutter/material.dart';
import 'package:portfolio/app/core/constants/app_colors.dart';

enum ButtonType { gradient, outline, text }

class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final ButtonType type;
  final double? width;
  final double height;
  final bool isSecondary;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.type = ButtonType.gradient,
    this.width,
    this.height = 48,
    this.isSecondary = false,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: widget.width,
        height: widget.height,
        transform: _isHovered
            ? Matrix4.translationValues(0.0, -3.0, 0.0)
            : Matrix4.identity(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: widget.type == ButtonType.gradient
              ? AppColors.primaryGradient
              : null,
          color: widget.type == ButtonType.outline
              ? (_isHovered
                  ? AppColors.primary.withAlpha((0.1 * 255).round())
                  : Colors.transparent)
              : null,
          border: widget.type == ButtonType.outline
              ? Border.all(
                  color: _isHovered ? AppColors.accent : AppColors.primary,
                  width: 1.5,
                )
              : null,
          boxShadow: _isHovered && widget.type == ButtonType.gradient
              ? [
                  BoxShadow(
                    color: AppColors.primary.withAlpha((0.4 * 255).round()),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ]
              : [],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: widget.onPressed,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.icon != null) ...[
                    Icon(
                      widget.icon,
                      size: 16,
                      color: widget.type == ButtonType.outline
                          ? AppColors.primary
                          : Colors.white,
                    ),
                    const SizedBox(width: 6),
                  ],
                  Flexible(
                    child: Text(
                      widget.text,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: widget.type == ButtonType.outline
                            ? (_isHovered ? AppColors.accent : AppColors.primary)
                            : Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
