import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sosty/ui/common/styles/styles.dart';

class CarouselImage extends StatefulWidget {
  const CarouselImage({
    Key? key,
    required this.images,
    this.height,
  }) : super(key: key);

  final List<String> images;
  final double? height;

  @override
  State<CarouselImage> createState() => _CarouselImageState();
}

class _CarouselImageState extends State<CarouselImage> {
  int _currentPage = 0;
  double _currentPageValue = 0.0;
  final double _scaleFactor = 0.8;
  final _imageHeight = 350.0;
  final PageController _pageController = PageController(viewportFraction: 0.88);
  final Duration _animatedDuration = const Duration(milliseconds: 300);

  Widget _dotIndicator(index) {
    final isActive = _currentPage == index;
    return AnimatedContainer(
      height: 10,
      width: isActive ? 20 : 10,
      margin: const EdgeInsets.only(right: 5),
      duration: _animatedDuration,
      decoration: BoxDecoration(
        color:
            isActive ? Theme.of(context).primaryColor : Styles.secondaryColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(22),
        ),
      ),
    );
  }

  Widget _buildPageItem(int index) {
    Matrix4 matrix = Matrix4.identity();
    double currScale = 0.0;
    double currTrans = 0.0;
    double height = widget.height ?? _imageHeight;

    if (index == _currentPageValue.floor()) {
      currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPageValue.floor() + 1) {
      currScale =
          _scaleFactor + (_currentPageValue - index + 1) * (1 - _scaleFactor);
      currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPageValue.floor() - 1) {
      currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      currTrans = height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, height * (1 - _scaleFactor) / 2, 1);
    }

    return Transform(
      transform: matrix,
      child: Container(
        margin: const EdgeInsets.only(
          top: 20.0,
          right: 5.0,
          bottom: 20.0,
          left: 5.0,
        ),
        padding: const EdgeInsets.only(bottom: 20.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: CachedNetworkImageProvider(
              widget.images[index],
            ),
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPageValue = _pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: widget.height ?? _imageHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            shape: BoxShape.rectangle,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 15.0,
              )
            ],
          ),
          child: PageView.builder(
            itemCount: widget.images.length,
            controller: _pageController,
            onPageChanged: (value) {
              setState(() {
                _currentPage = value;
              });
            },
            itemBuilder: (context, position) {
              return _buildPageItem(position);
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.images.length,
            (index) => _dotIndicator(index),
          ),
        ),
      ],
    );
  }
}
