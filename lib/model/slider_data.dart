class SliderData {
  String? titleBook;
  String? imageBook;
  double? priseBook;
  String? descriptionBook;

  SliderData({
    this.titleBook,
    this.imageBook,
    this.priseBook,
    this.descriptionBook,
  });
}

final sliderDataList = [
  SliderData(
    titleBook: "Python Language",
    imageBook: "images/basicspython.jpg",
    priseBook: 23.5,
    descriptionBook: "Programming basic with python",
  ),
  SliderData(
    titleBook: "Java Language",
    imageBook: "images/beginingjava.jpg",
    priseBook: 32.75,
    descriptionBook: "Beginning Programming with java",
  ),
  SliderData(
    titleBook: "C Language",
    imageBook: "images/beginningc.jpg",
    priseBook: 35,
    descriptionBook: "Beginning Programming with C",
  ),
  SliderData(
    titleBook: "Head First OOP",
    imageBook: "images/head_first.jpg",
    priseBook: 16.5,
    descriptionBook: "Analysis and Design your code",
  ),
];
