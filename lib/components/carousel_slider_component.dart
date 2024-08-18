import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../Models/carousel_item_model.dart';
import '../utils/deisgn_system.dart';

class CarouselSliderComponent extends StatelessWidget {
  final List<CarouselItemModel> carouselData;
  final Function(int) onCarouselChanged;
  final int currentIndex;

  const CarouselSliderComponent({
    Key? key,
    required this.carouselData,
    required this.onCarouselChanged,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: carouselData.map((data) {
            return Builder(
              builder: (BuildContext context) {
                return Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 120,
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: data.backgroundColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              'Available Balance',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            data.balance,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 50,
                      left: 0,
                      right: 0,
                      child: Image.asset(
                        data.imagePath,
                        height: 300,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                );
              },
            );
          }).toList(),
          options: CarouselOptions(
            height: 300,
            enlargeCenterPage: false,
            viewportFraction: 1.0,
            autoPlay: false,
            onPageChanged: (index, reason) {
              onCarouselChanged(index);
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: carouselData.map((url) {
            int index = carouselData.indexOf(url);
            return Container(
              width: 8.0,
              height: 4.0,
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: currentIndex == index
                    ? WatWalletDesignSystem.primaryColor
                    : Colors.grey,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
