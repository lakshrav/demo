import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentPageIndex = 0;

  final List<Widget> _pages = [
    // Define the content of each page here
    Container(
      color: const Color.fromARGB(255, 255, 255, 255),
      child: Center(
        child: Text(
          'Welcome to Ingred-Ease - A one stop portal for all your concerns about packaged food products. All you need is a camera and one minute for a path to a more transparent diet!',
          style: TextStyle(fontFamily: 'Gilroy', fontSize: 20, color: const Color.fromARGB(255, 0, 0, 0)),
          textAlign: TextAlign.center,
        ),
      ),
    ),
Container(
  color: const Color.fromARGB(255, 255, 255, 255),
  child: Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center, // Center the column vertically
      children: [
        Text(
          'All you have to do is to upload an image (or take a snap) of the ingredient list of the food item you want to know more about.',
          style: TextStyle(fontSize: 24, color: Color.fromARGB(255, 0, 0, 0)),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10), // Add some space between the texts
        Text(
          'Note: Please ensure that you upload an image of the ingredient list, and not the nutritional table.',
          style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 0, 0, 0)),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20), // Add some space between the text and the images
        Row(
          mainAxisAlignment: MainAxisAlignment.center, // Center the row horizontally
          children: [
            Image.asset(
              'assets/images/tick_image.png', // Replace with your image path
              width: 100, // Set the width as needed
              height: 100, // Set the height as needed
            ),
            SizedBox(width: 10), // Add a small space between the images
            Image.asset(
              'assets/images/cross_image.png', // Replace with your image path
              width: 100, // Set the width as needed
              height: 100, // Set the height as needed
            ),
          ],
        ),
      ],
    ),
  ),
),

  
    Container(
  color: const Color.fromARGB(255, 255, 255, 255),
  child: Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
        'After you upload the image, you can crop it and then view the contents of the food item.',          style: TextStyle(fontSize: 24, color: Color.fromARGB(255, 0, 0, 0)),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20), // Space between text and image
        Image.asset(
          'assets/images/third_screen.png', // Replace with your image path
          width: 200, // Set the width as needed
          height: 200, // Set the height as needed
        ),
        SizedBox(height: 20), // Space between image and explanation text
        Text(
          'The algorithm considers several factors before providing you with a final score indicative of the probable healthiness of the product. Among other factors, our score is based on the relative position of healthy and unhealthy ingredients in the list. Disclaimer: Score is indicative and predicted based on our algorithm. Always be aware of products that you are consuming.',
          style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 0, 0, 0)),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  ),
)

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Onboarding Screen'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: _pages[_currentPageIndex],
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                if (_currentPageIndex < _pages.length - 1) {
                  _currentPageIndex++;
                } else {
                  // Navigate to the actual app
                  Navigator.pushReplacementNamed(context, '/home');
                }
              });
            },
            child: Text(_currentPageIndex == _pages.length - 1
                ? 'Get Started'
                : 'Next'),
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
        ],
      ),
    );
  }
}
