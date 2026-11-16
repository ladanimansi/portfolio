import 'dart:async';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AnimatedTypingText extends StatefulWidget {
  final List<String> texts;
  final TextStyle? style;
  final Duration typingSpeed;
  final Duration deletingSpeed;
  final Duration pauseDuration;

  const AnimatedTypingText({
    super.key,
    required this.texts,
    this.style,
    this.typingSpeed = const Duration(milliseconds: 90),
    this.deletingSpeed = const Duration(milliseconds: 50),
    this.pauseDuration = const Duration(milliseconds: 1600),
  });

  @override
  State<AnimatedTypingText> createState() => _AnimatedTypingTextState();
}

class _AnimatedTypingTextState extends State<AnimatedTypingText> {
  int _textIndex = 0;
  int _charIndex = 0;
  bool _isDeleting = false;
  bool _showCursor = true;
  Timer? _typingTimer;
  Timer? _cursorTimer;

  @override
  void initState() {
    super.initState();
    _startCursorBlink();
    _startTyping();
  }

  void _startCursorBlink() {
    _cursorTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (mounted) {
        setState(() => _showCursor = !_showCursor);
      }
    });
  }

  void _startTyping() {
    if (widget.texts.isEmpty) return;

    final currentFullText = widget.texts[_textIndex];

    if (!_isDeleting) {
      if (_charIndex < currentFullText.length) {
        _charIndex++;
        setState(() {});
        _typingTimer = Timer(widget.typingSpeed, _startTyping);
      } else {
        // Paused at full text before deleting
        _typingTimer = Timer(widget.pauseDuration, () {
          _isDeleting = true;
          _startTyping();
        });
      }
    } else {
      if (_charIndex > 0) {
        _charIndex--;
        setState(() {});
        _typingTimer = Timer(widget.deletingSpeed, _startTyping);
      } else {
        // Move to next text
        _isDeleting = false;
        _textIndex = (_textIndex + 1) % widget.texts.length;
        _typingTimer = Timer(const Duration(milliseconds: 400), _startTyping);
      }
    }
  }

  @override
  void dispose() {
    _typingTimer?.cancel();
    _cursorTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.texts.isEmpty) return const SizedBox.shrink();

    final currentFullText = widget.texts[_textIndex];
    final displayedText = currentFullText.substring(0, _charIndex);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: ShaderMask(
            shaderCallback: (bounds) => AppColors.primaryGradient.createShader(
              Rect.fromLTWH(0, 0, bounds.width, bounds.height),
            ),
            child: Text(
              displayedText,
              style: widget.style ??
                  const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
            ),
          ),
        ),
        Opacity(
          opacity: _showCursor ? 1.0 : 0.0,
          child: Container(
            margin: const EdgeInsets.only(left: 3),
            width: 3,
            height: (widget.style?.fontSize ?? 20) * 1.15,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ],
    );
  }
}

