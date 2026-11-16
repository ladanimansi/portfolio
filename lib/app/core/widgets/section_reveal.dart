import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SectionReveal extends StatefulWidget {
  final Widget child;
  final int sectionIndex;
  final RxInt activeIndex;
  final Duration duration;

  const SectionReveal({
    super.key,
    required this.child,
    required this.sectionIndex,
    required this.activeIndex,
    this.duration = const Duration(milliseconds: 650),
  });

  @override
  State<SectionReveal> createState() => _SectionRevealState();
}

class _SectionRevealState extends State<SectionReveal>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _scaleAnimation;
  Worker? _worker;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _fadeAnimation = Tween<double>(begin: 0.15, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 24.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    _scaleAnimation = Tween<double>(begin: 0.98, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    // Initial animation for section 0 or immediately
    if (widget.sectionIndex == 0) {
      _controller.forward();
    } else {
      _controller.value = 1.0; // visible by default for smooth scrolling
    }

    // Listen to section changes from GetX
    _worker = ever(widget.activeIndex, (int currentActive) {
      if (currentActive == widget.sectionIndex) {
        _controller.reset();
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _worker?.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _fadeAnimation.value,
          child: Transform.translate(
            offset: _slideAnimation.value,
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: widget.child,
            ),
          ),
        );
      },
    );
  }
}
