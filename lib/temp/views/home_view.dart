import 'package:flutter/material.dart';
import 'package:medica_tech/temp/utils/theme_selector.dart';
import 'package:medica_tech/temp/utils/view_wrapper.dart';
import 'package:medica_tech/temp/widgets/navigation_arrow.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  double screenWidth;
  double screenHeight;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return ViewWrapper(desktopView: desktopView(), mobileView: mobileView());
  }

  Widget desktopView() {
    return Stack(
      children: [
        NavigationArrow(isBackArrow: false),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: screenHeight * 0.1),
            Expanded(
              child: Container(
                width: screenWidth * 0.45,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Bienvenue chez MedicaTech',
                            style: TextStyle(
                                fontSize: 50, color: Color(0xff21a179)),
                          ),
                        ),
                        Expanded(
                          child: Image.asset(
                            "assets/images/poster.jpg",
                            height: 400,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.05),
                    subHeader('Consultation medicale .', getFontSize(false)),
                    SizedBox(height: screenHeight * 0.01),
                    subHeader('Traitement medicale.', getFontSize(false)),
                    SizedBox(height: screenHeight * 0.01),
                    subHeader('Suivie des dossiers medicale en ligne.',
                        getFontSize(false)),
                    SizedBox(height: screenHeight * 0.1),
                  ],
                ),
              ),
            ),
            SizedBox(width: screenWidth * 0.03),
            profilePicture()
          ],
        )
      ],
    );
  }

  Widget mobileView() {
    return Column(
      children: [
        profilePicture(),
        SizedBox(height: screenHeight * 0.02),
        header(30),
        SizedBox(height: screenHeight * 0.01),
        subHeader(
            'Consultation medicale  - Traitement medicale - Suivie des dossiers medicale en ligne',
            15)
      ],
    );
  }

  double getImageSize() {
    if (screenWidth > 1600 && screenHeight > 800) {
      return 400;
    } else if (screenWidth > 1300 && screenHeight > 600) {
      return 350;
    } else if (screenWidth > 1000 && screenHeight > 400) {
      return 300;
    } else {
      return 250;
    }
  }

  double getFontSize(bool isHeader) {
    double fontSize = screenWidth > 950 && screenHeight > 550 ? 30 : 25;
    return isHeader ? fontSize * 2.25 : fontSize;
  }

  Widget profilePicture() {
    return Container(
      alignment: Alignment.centerRight,
      height: getImageSize(),
      width: getImageSize(),
      child: Column(
        children: [],
      ),
    );
  }

  Widget header(double fontSize) {
    return RichText(
      text: TextSpan(
        // Note: Styles for TextSpans must be explicitly defined.
        // Child text spans will inherit styles from parent
        style: ThemeSelector.selectHeadline(context),
        children: const <TextSpan>[
          TextSpan(text: 'Bienvenue chez MedicaTech '),
        ],
      ),
    );
  }

  Widget subHeader(String text, double fontSize) {
    return Row(
      children: [
        Icon(
          Icons.done,
          color: Colors.green,
        ),
        Text(text, style: ThemeSelector.selectSubHeadline(context)),
      ],
    );
  }
}
