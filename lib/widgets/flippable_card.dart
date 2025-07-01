// lib/widgets/flippable_card.dart

import 'dart:math';
import 'package:flutter/material.dart';

class FlippableCard extends StatefulWidget {
  // این ویجت دو فرزند می گیرد: یکی برای جلو و یکی برای پشت کارت
  final Widget front;
  final Widget back;

  const FlippableCard({
    super.key,
    required this.front,
    required this.back,
  });

  @override
  State<FlippableCard> createState() => _FlippableCardState();
}

class _FlippableCardState extends State<FlippableCard> with SingleTickerProviderStateMixin {
  // ۱. کنترل کننده انیمیشن
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isFlipped = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500), // سرعت چرخش
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _flipCard() {
    if (_controller.isAnimating) return; // اگر در حال چرخش بود، کاری نکن

    if (_isFlipped) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    _isFlipped = !_isFlipped;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _flipCard, // ۲. با لمس کاربر، کارت می چرخد
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          // ۳. مقدار انیمیشن از ۰ تا ۱ تغییر می کند. ما آن را به زاویه رادیان تبدیل می کنیم
          final angle = _animation.value * pi; // pi = ۱۸۰ درجه

          // ۴. مشخص می کنیم که آیا پشت کارت باید نمایش داده شود یا جلوی آن
          final isBackVisible = _animation.value >= 0.5;

          return Transform(
            // ۵. چرخش حول محور عمودی (Y)
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001) // این خط برای ایجاد افکت پرسپکتیو است
              ..rotateY(angle),
            alignment: Alignment.center,
            child: Container(
              // ۶. اینجا تصمیم می گیریم کدام سمت کارت را نشان دهیم
              child: isBackVisible
                  ? Transform(
                      // این چرخش اضافی برای این است که پشت کارت آینه ای نباشد
                      transform: Matrix4.identity()..rotateY(pi),
                      alignment: Alignment.center,
                      child: widget.back,
                    )
                  : widget.front,
            ),
          );
        },
      ),
    );
  }
}