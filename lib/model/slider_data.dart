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
    descriptionBook: "Python is a general-purpose interpreted, interactive, object-oriented, and high-level programming language. It was created by Guido van Rossum during 1985- 1990.",
  ),
  SliderData(
    titleBook: "Java Language",
    imageBook: "images/beginingjava.jpg",
    priseBook: 32.75,
    descriptionBook: "JAVA was developed by James Gosling at Sun Microsystems Inc in the year 1995.",
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
    descriptionBook: "Wouldn't it be dreamy if there was an analysis and design book that was more fun than going to an HR benefits meeting? It's probably nothing but a fantasy...",
  ),
];
