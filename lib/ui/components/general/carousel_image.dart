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
  _CarouselImageState createState() => _CarouselImageState();
}

class _CarouselImageState extends State<CarouselImage> {
  final PageController _pageController = PageController(viewportFraction: 0.88);
  double _currentPage = 0.0;
  final double _scaleFactor = 0.8;
  final _imageHeight = 350.0;

  Widget _dotIndicator(index) {
    final isActive = _currentPage == index;
    return Container(
      height: 10,
      width: isActive ? 20 : 10,
      margin: const EdgeInsets.only(right: 5),
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
    double _height = widget.height ?? _imageHeight;

    if (index == _currentPage.floor()) {
      currScale = 1 - (_currentPage - index) * (1 - _scaleFactor);
      currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPage.floor() + 1) {
      currScale =
          _scaleFactor + (_currentPage - index + 1) * (1 - _scaleFactor);
      currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPage.floor() - 1) {
      currScale = 1 - (_currentPage - index) * (1 - _scaleFactor);
      currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
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
        _currentPage = _pageController.page!;
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
