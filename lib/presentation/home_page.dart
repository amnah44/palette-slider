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
          blur: 6,
          colorOpacity: 0.5,
          blurColor:
              colors.isNotEmpty ? colors[_currentPage].color : Colors.white,
          overlay: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "The prise of a book : ",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Colors.black45,
                      ),
                    ),
                    Text(
                      "${sliderDataList[_currentPage].priseBook}\$",
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 30,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 24, right: 24),
                  child: Text(
                    "Created by Amnah_",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Colors.black26,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 24, right: 24),
                  child: Divider(
                    color: Colors.black12,
                    thickness: 1,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 24, right: 24, bottom: 12),
                  child: Text(
                    "${sliderDataList[_currentPage].titleBook}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 36,
                      color: Colors.black38,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Text(
                    "${sliderDataList[_currentPage].descriptionBook}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: Colors.black26,
                    ),
                  ),
                ),
                const Spacer(),
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
              ],
            ),
          ),
          child: Container(),
        ),
      ),
    );
  }
}
