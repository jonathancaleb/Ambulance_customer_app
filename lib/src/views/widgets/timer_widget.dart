import 'package:bukk_customer_app/views/widgets/app_button.dart';
import 'package:flutter/material.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({
    Key? key,
    required this.durationInSeconds,
  }) : super(key: key);
  final int durationInSeconds;

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _progress = 1.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(seconds: widget.durationInSeconds));
    _controller.addListener(() {
      if (_controller.isAnimating) {
        setState(() {
          _progress = _controller.value;
        });
      } else {
        setState(() {
          _progress = 1.0;
        });
      }
    });

    _startAnimation();
  }

  void _startAnimation() {
    if (!_controller.isAnimating) {
      _controller.reverse(
          from: _controller.value == 0 ? 1.0 : _controller.value);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        SizedBox(
          width: 200,
          height: 200,
          child: CircularProgressIndicator(
            backgroundColor: Colors.transparent,
            value: _progress,
            strokeWidth: 10,
            color: const Color(0xff042B52),
          ),
        ),
        Container(
            width: 190,
            height: 190,
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: Colors.grey.shade300),
            child: Center(
                child: AppButton(
              color: const Color(0xff042B52),
              onTap:
                  !_controller.isCompleted ? null : Navigator.of(context).pop,
              text: 'Cancel',
            ))),
      ],
    );
  }
}
