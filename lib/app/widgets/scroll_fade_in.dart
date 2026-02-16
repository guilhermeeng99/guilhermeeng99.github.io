import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ScrollFadeIn extends HookWidget {
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
  Widget build(BuildContext context) {
    final isVisible = useState(false);
    final animController = useAnimationController(duration: duration);
    final opacity = useAnimation(
      CurvedAnimation(parent: animController, curve: curve),
    );
    final slide = useAnimation(
      Tween<double>(begin: offset, end: 0).animate(
        CurvedAnimation(parent: animController, curve: curve),
      ),
    );

    useEffect(() {
      if (isVisible.value) {
        unawaited(animController.forward());
      }
      return null;
    }, [isVisible.value]);

    return _VisibilityDetector(
      threshold: visibleThreshold,
      onVisible: () {
        if (!isVisible.value) {
          isVisible.value = true;
        }
      },
      child: Opacity(
        opacity: opacity,
        child: Transform.translate(
          offset: Offset(0, slide),
          child: child,
        ),
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
