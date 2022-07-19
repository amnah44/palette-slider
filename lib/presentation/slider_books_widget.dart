import 'package:flutter/material.dart';

import '../model/slider_data.dart';

class SliderBooksWidget extends StatelessWidget {
  SliderBooksWidget({Key? key, required this.index}) : super(key: key);

  int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: Text(
                  "${sliderDataList[index].titleBook?.toUpperCase()}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: 35,
                    fontFamily: 'MelanieRegular',
                    color: Colors.black12,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.55,
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      sliderDataList[index].imageBook ?? "",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
