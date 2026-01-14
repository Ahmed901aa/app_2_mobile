import 'package:app_2_mobile/core/resources/color_manager.dart';
import 'package:app_2_mobile/core/resources/values_manager.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/banner/banner_auto_play_controller.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/banner/banner_content.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/banner/banner_image.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/banner/banner_indicators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BannerItem {
  final String title;
  final String subtitle;
  final String imageUrl;

  const BannerItem({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });
}

class FeaturedBanner extends StatefulWidget {
  final List<BannerItem> items;
  final void Function(int index)? onTap;

  const FeaturedBanner({super.key, required this.items, this.onTap});

  @override
  State<FeaturedBanner> createState() => _FeaturedBannerState();
}

class _FeaturedBannerState extends State<FeaturedBanner> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final BannerAutoPlayController _autoPlay;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 10))..repeat(reverse: true);
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _autoPlay = BannerAutoPlayController(
      itemCount: widget.items.length,
      onNext: () => setState(() => _currentIndex = (_currentIndex + 1) % widget.items.length),
    )..start();
  }

  @override
  void dispose() {
    _controller.dispose();
    _autoPlay.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) return const SizedBox.shrink();
    final currentItem = widget.items[_currentIndex];

    return GestureDetector(
      onTap: () => widget.onTap?.call(_currentIndex),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: Insets.s16.w, vertical: Insets.s16.h),
        height: 150.h,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.r), color: ColorManager.lightGrey),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: Stack(
            fit: StackFit.expand,
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 800),
                switchInCurve: Curves.easeIn,
                switchOutCurve: Curves.easeOut,
                child: BannerImage(key: ValueKey<String>(currentItem.imageUrl), imageUrl: currentItem.imageUrl, scaleAnimation: _scaleAnimation),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withValues(alpha: 0.6)],
                  ),
                ),
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 600),
                child: BannerContent(key: ValueKey<String>(currentItem.title), title: currentItem.title, subtitle: currentItem.subtitle),
              ),
              BannerIndicators(itemCount: widget.items.length, currentIndex: _currentIndex, onTap: (index) => setState(() => _currentIndex = index)),
            ],
          ),
        ),
      ),
    );
  }
}
