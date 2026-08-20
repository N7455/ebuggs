import 'package:flutter/material.dart';
import 'package:slide_to_act/slide_to_act.dart';

class CommonSlideButton extends StatefulWidget {
  final String text;
  final VoidCallback onSubmit;
  final bool isLoading;

  const CommonSlideButton({
    super.key,
    required this.text,
    required this.onSubmit,
    this.isLoading = false,
  });

  @override
  State<CommonSlideButton> createState() => _CommonSlideButtonState();
}

class _CommonSlideButtonState extends State<CommonSlideButton> {
  final GlobalKey<SlideActionState> _key = GlobalKey();

  @override
  void didUpdateWidget(covariant CommonSlideButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reset slider when loading changes
    if (widget.isLoading && !oldWidget.isLoading) {
      _key.currentState?.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: widget.isLoading,
      child: SlideAction(
        key: _key,
        outerColor: const Color(0xFF243BCD),
        innerColor: Colors.white,
        elevation: 4,
        sliderButtonIconSize: 24,
        animationDuration: const Duration(milliseconds: 300),
        sliderRotate: false,
        text: widget.isLoading ? "Please wait..." : widget.text,
        textStyle: const TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontFamily: "Inter",
          fontWeight: FontWeight.bold,
        ),
        sliderButtonIcon: const Icon(
          Icons.arrow_forward,
          color: Color(0xFF243BCD),
        ),
        onSubmit: () {
          // Small delay ensures smooth animation
          Future.delayed(const Duration(milliseconds: 200), () {
            if (!widget.isLoading) {
              widget.onSubmit();
              _key.currentState?.reset(); // Reset slider after submission
            }
          });
        },
      ),
    );
  }
}
