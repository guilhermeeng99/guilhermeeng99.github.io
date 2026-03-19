import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScrollFadeIn extends StatefulWidget {
  const ScrollFadeIn({
    required this.child,
    this.offset = 30.0,
    this.duration = const Duration(milliseconds: 600),
    this.curve = Curves.easeOut,
    this.visibleThreshold = 0.15,
    super.key,
  });

  final Widget child;
  final double offset;
  final Duration duration;
  final Curve curve;
  final double visibleThreshold;

  @override
  State<ScrollFadeIn> createState() => _ScrollFadeInState();
}

class _ScrollFadeInState extends State<ScrollFadeIn>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<double> _slide;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    final curved = CurvedAnimation(parent: _controller, curve: widget.curve);
    _opacity = curved;
    _slide = Tween<double>(begin: widget.offset, end: 0).animate(curved);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onVisible() {
    if (!_isVisible) {
      _isVisible = true;
      unawaited(_controller.forward());
    }
  }

  @override
  Widget build(BuildContext context) {
    return _VisibilityDetector(
      threshold: widget.visibleThreshold,
      onVisible: _onVisible,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Opacity(
            opacity: _opacity.value,
            child: Transform.translate(
              offset: Offset(0, _slide.value),
              child: child,
            ),
          );
        },
        child: widget.child,
      ),
    );
  }
}

class _VisibilityDetector extends SingleChildRenderObjectWidget {
  const _VisibilityDetector({
    required super.child,
    required this.threshold,
    required this.onVisible,
  });

  final double threshold;
  final VoidCallback onVisible;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderVisibilityDetector(
      threshold: threshold,
      onVisible: onVisible,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    _RenderVisibilityDetector renderObject,
  ) {
    renderObject
      ..threshold = threshold
      ..onVisible = onVisible;
  }
}

class _RenderVisibilityDetector extends RenderProxyBox {
  _RenderVisibilityDetector({
    required this.threshold,
    required this.onVisible,
  });

  double threshold;

  VoidCallback onVisible;
  bool _fired = false;

  @override
  void paint(PaintingContext context, Offset offset) {
    super.paint(context, offset);
    if (_fired) return;

    final viewport = RenderAbstractViewport.maybeOf(this);
    if (viewport == null) return;

    final revealOffset = viewport.getOffsetToReveal(this, 0);
    final viewportSize = viewport.paintBounds.height;
    final itemTop = revealOffset.offset;
    final itemBottom = itemTop + size.height;

    final scrollOffset = viewport is RenderViewportBase
        ? viewport.offset
        : null;

    if (scrollOffset == null) return;

    final pixels = scrollOffset.pixels;
    final visibleTop = pixels;
    final visibleBottom = pixels + viewportSize;

    final visibleHeight =
        (itemBottom.clamp(visibleTop, visibleBottom) -
                itemTop.clamp(visibleTop, visibleBottom))
            .clamp(0.0, size.height);

    final ratio = size.height > 0 ? visibleHeight / size.height : 0.0;

    if (ratio >= threshold) {
      _fired = true;
      WidgetsBinding.instance.addPostFrameCallback((_) => onVisible());
    }
  }
}
