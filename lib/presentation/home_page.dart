import 'dart:async';

import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:untitled3/model/slider_data.dart';
import 'package:untitled3/presentation/slider_books_widget.dart';
import 'package:untitled3/presentation/slider_dots.dart';

import '../util/custom_shape.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController(initialPage: 0);
  List<PaletteColor> colors = [];
  List<String> images = [];
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    _getListOfImage();

    _updatePalette();

    Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_currentPage < sliderDataList.length) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _getListOfImage() {
    for (int index = 0; index < sliderDataList.length; index++) {
      images.add(sliderDataList[index].imageBook!);
    }
  }

  _updatePalette() async {
    for (String image in images) {
      final PaletteGenerator generator =
          await PaletteGenerator.fromImageProvider(
        AssetImage(image),
        size: const Size(200, 200),
      );

      colors.add(generator.lightMutedColor != null
          ? generator.lightMutedColor!
          : PaletteColor(Colors.black26, 2));
    }
    setState(() {});
  }

  _onPageChange(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor:
          colors.isNotEmpty ? colors[_currentPage].color : Colors.white,
      statusBarBrightness: Brightness.dark,
    ));

    return Scaffold(
      body: SafeArea(
        child: Blur(
          blur: 8,
          colorOpacity: 0.6,
          blurColor:
              colors.isNotEmpty ? colors[_currentPage].color : Colors.white,
          overlay: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: Positioned(
                    bottom: 0,
                    child: ClipPath(
                      clipper: RoundedClipper(540),
                      child: Container(
                        color: colors.isNotEmpty
                            ? colors[_currentPage].color
                            : Colors.white,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            PageView.builder(
                              onPageChanged: _onPageChange,
                              controller: _pageController,
                              scrollDirection: Axis.horizontal,
                              itemCount: sliderDataList.length,
                              itemBuilder: (builderContext, index) =>
                                  SliderBooksWidget(index: index),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Stack(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            for (int index = 0;
                                index < sliderDataList.length;
                                index++)
                              if (index == _currentPage)
                                SliderDots(isActive: true)
                              else
                                SliderDots(isActive: false)
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.fromLTRB(24,16,24,8),
                      child: Text(
                        "${sliderDataList[_currentPage].titleBook}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 24, right: 24),
                      child: Text(
                        "${sliderDataList[_currentPage].descriptionBook}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.black26,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  margin: const EdgeInsets.all(16.0),
                  padding: const EdgeInsets.fromLTRB(1, 1.5, 1, 1),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.07,
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(26),
                    child: Blur(
                      blur: 8,
                      blurColor: colors.isNotEmpty ? colors[_currentPage].color : Colors.white,
                      colorOpacity: 0.8,
                      overlay: Center(
                        child: Text(
                          "${sliderDataList[_currentPage].priseBook}\$",
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 30,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      child: Container(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          child: Container(),
        ),
      ),
    );
  }
}
