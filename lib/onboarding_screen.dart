import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentPageIndex = 0;

  final List<Widget> _pages = [
    // Page 1
    Container(
      color: Colors.white, // Change background to white
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Welcome to Ingred-Ease - A one stop portal for all your concerns about packaged food products. All you need is a camera and one minute for a path to a more transparent diet!',
            style: TextStyle(
              fontFamily: 'Gilroy',
              fontSize: 20,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ),
    // Page 2
    Container(
      color: Colors.white, // Change background to white
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'All you have to do is to upload an image (or take a snap) of the ingredient list of the food item you want to know more about.',
            style: TextStyle(
              fontFamily: 'Gilroy',
              fontSize: 20,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            'Note: Please ensure that you upload an image of the ingredient list, and not the nutritional table.',
            style: TextStyle(
              fontFamily: 'Gilroy',
              fontSize: 18,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Image.asset(
                    'assets/images/tick_image.png',
                    fit: BoxFit.contain, // Adjust fit as needed
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Image.asset(
                    'assets/images/cross_image.png',
                    fit: BoxFit.contain, // Adjust fit as needed
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    // Page 3
    Container(
      color: Colors.white, // Change background to white
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'After you upload the image, you can crop it and then view the contents of the food item.',
            style: TextStyle(
              fontFamily: 'Gilroy',
              fontSize: 20,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Image.asset(
            'assets/images/third_screen.png',
            width: 250, // Adjust width as needed
            height: 250, // Adjust height as needed
          ),
          SizedBox(height: 20),
          Text(
            'The algorithm considers several factors before providing you with a final score indicative of the probable healthiness of the product. Disclaimer: Score is indicative and predicted based on our algorithm. Always be aware of products that you are consuming.',
            style: TextStyle(
              fontFamily: 'Gilroy',
              fontSize: 20,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'IngredEase',
          style: TextStyle(color: Colors.white), // Set AppBar text color to white
        ),
        backgroundColor: Color(0xFF12d18e), // Change the app bar color to green
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: _pages[_currentPageIndex],
          ),
          Container(
            color: Colors.white, // Set bottom background color to white
            padding: const EdgeInsets.only(bottom: 10),
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (_currentPageIndex < _pages.length - 1) {
                      _currentPageIndex++;
                    } else {
                      Navigator.pushReplacementNamed(context, '/home');
                    }
                  });
                },
                child: Text(
                  _currentPageIndex == _pages.length - 1 ? 'Get Started' : 'Next',
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.02,
                    horizontal: MediaQuery.of(context).size.width * 0.1,
                  ),
                  backgroundColor: Color(0xFFe7faf4),
                  foregroundColor: Color(0xFF12d18e),
                  shadowColor: Colors.transparent,
                  side: BorderSide.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
