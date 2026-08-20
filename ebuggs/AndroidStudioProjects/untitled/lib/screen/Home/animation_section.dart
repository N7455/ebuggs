import 'package:flutter/material.dart';

class PromoCarousel extends StatefulWidget {
  const PromoCarousel({Key? key}) : super(key: key);

  @override
  State<PromoCarousel> createState() => _PromoCarouselState();
}

class _PromoCarouselState extends State<PromoCarousel> {
  late PageController _pageController;
  int _currentIndex = 0;
  bool _isAnimating = false;

  final List<String> promoImages = [
    'assets/images/Frame.png',
  ];

  List<String> get _loopedImages {
    return [
      promoImages.last, // Fake last at the beginning
      ...promoImages,
      promoImages.first, // Fake first at the end
    ];
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1, viewportFraction: 0.9);
    Future.delayed(const Duration(seconds: 3), _autoScroll);
  }

  void _autoScroll() async {
    if (!_pageController.hasClients || _isAnimating) return;
    _isAnimating = true;

    int nextPage = _pageController.page!.round() + 1;

    await _pageController.animateToPage(
      nextPage,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );

    _isAnimating = false;
    Future.delayed(const Duration(seconds: 3), _autoScroll);
  }

  void _handlePageChanged(int index) {
    final itemCount = promoImages.length;

    if (index == 0) {
      Future.microtask(() {
        _pageController.jumpToPage(itemCount);
        setState(() => _currentIndex = itemCount - 1);
      });
    } else if (index == itemCount + 1) {
      Future.microtask(() {
        _pageController.jumpToPage(1);
        setState(() => _currentIndex = 0);
      });
    } else {
      setState(() => _currentIndex = index - 1);
    }
  }

  Widget buildPageView() => SizedBox(
    height: 160,
    width: double.infinity,
    child: PageView.builder(
      controller: _pageController,
      itemCount: _loopedImages.length,
      onPageChanged: _handlePageChanged,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            _loopedImages[index],
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => const Center(
            ),
          ),
        ),
      ),
    ),
  );

  Widget buildIndicator() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: List.generate(promoImages.length, (index) {
      final isActive = _currentIndex == index;
      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        width: isActive ? 16 : 8,
        height: 8,
        decoration: BoxDecoration(
          color: isActive ? Colors.blue : Colors.grey.shade400,
          borderRadius: BorderRadius.circular(4),
        ),
      );
    }),
  );

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [buildPageView(), const SizedBox(height: 8), buildIndicator()],
    );
  }
}
