part of dapresent_material;

///
///
///
class IgnorePointerAnimatedOpacity extends StatelessWidget {
  const IgnorePointerAnimatedOpacity({
    super.key,
    this.onEnd,
    this.curve = Curves.linear,
    this.alwaysIncludeSemantics = true,
    required this.ignoring,
    required this.duration,
    required this.child,
  });

  final bool ignoring;
  final bool alwaysIncludeSemantics;
  final Duration duration;
  final Curve curve;
  final VoidCallback? onEnd;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: ignoring,
      child: AnimatedOpacity(
        opacity: ignoring ? 0.0 : 1.0,
        duration: duration,
        curve: curve,
        onEnd: onEnd,
        alwaysIncludeSemantics: alwaysIncludeSemantics,
        child: child,
      ),
    );
  }
}
