import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:spell_check_on_client/spell_check_on_client.dart';
import 'package:flutter/services.dart';
import 'package:path_drawing/path_drawing.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
 
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          bodyText1: TextStyle(fontFamily: 'Gilroy'),
          bodyText2: TextStyle(fontFamily: 'Lato'),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Set the AppBar background color to green
      ),
      backgroundColor: Colors.white, // Set the background color to green
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
              child: Text(
                'NutriScan',
                style: TextStyle(
                  fontFamily: 'Gilroy',
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color:Color(0xFF0ea771), 
                ),
              ),
            ),
            SizedBox(height: 10), // Adjust the space between texts
            Text(
              'Check the quality of the products you are consuming.',
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 20, // Adjust font size as needed
              ),
              textAlign: TextAlign.center, // Center-align the text
            ),
            SizedBox(height: 20), // Space before the button
            GestureDetector(
              onTap: () async {
                XFile? image = await ImagePicker().pickImage(
                  source: ImageSource.gallery,
                  imageQuality: 100, // adjust as required
                );
                if (image != null) {
                  File? croppedImage = await cropImage(image.path);
                  if (croppedImage != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DisplayImageScreen(croppedImage.path),
                      ),
                    );
                  }
                }
              },

              child: CustomPaint(
                painter: DottedBorderPainter(borderColor: Color(0xFF0ea771), strokeWidth: 3, dashWidth: 5),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[100], // Light grey fill

                    borderRadius: BorderRadius.circular(30), // Increase the border radius for softer edges
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/upload_2.png',
                        width: 30,
                        height: 30,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Upload Image',
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 16,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20), // Space before the button
            ElevatedButton(
  
              onPressed: () async {
                // Open Camera functionality
              },
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
              child: Text(
                'Open Camera',
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1), // Add space at the bottom
          ],
        ),
      ),
    );
  }

  Future<File?> cropImage(String imagePath) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imagePath,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9,
      ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Color(0xFF0ea771),
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          minimumAspectRatio: 1.0,
        ),
      ],
    );

    if (croppedFile != null) {
      return File(croppedFile.path);
    }
    return null;
  }
}

class DottedBorderPainter extends CustomPainter {
  final Color borderColor;
  final double strokeWidth;
  final double dashWidth;

  DottedBorderPainter({required this.borderColor, this.strokeWidth = 1, this.dashWidth = 5});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final Path path = Path()
      ..addRRect(RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height), Radius.circular(30)));

    final dashArray = CircularIntervalList<double>(<double>[dashWidth, dashWidth]);

    canvas.drawPath(
      dashPath(path, dashArray: dashArray),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class DisplayImageScreen extends StatefulWidget {
  final String imagePath;
  DisplayImageScreen(this.imagePath);

  @override
  _DisplayImageScreenState createState() => _DisplayImageScreenState();
}

class _DisplayImageScreenState extends State<DisplayImageScreen> {
  String recognizedText = 'Performing OCR...';
  String recog_text = '...';
  SpellCheck? spellCheck;

  @override
  void initState() {
    super.initState();
    performOcr();
  }

  Future<void> performOcr() async {
    final textRecognizer = TextRecognizer();

    try {
      String language = 'en';
      String content = await rootBundle.loadString('assets/en_words.txt');
      spellCheck = SpellCheck.fromWordsContent(content,
          letters: LanguageLetters.getLanguageForLanguage(language));
      final RecognizedText recognizedText = await textRecognizer.processImage(
          InputImage.fromFilePath(widget.imagePath));
      String CorrectedText = spellCheck!.didYouMean(recognizedText.text);

      setState(() {
        recog_text = CorrectedText;
      });
    } catch (e) {
      setState(() {
        recog_text = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0ea771),
         iconTheme: IconThemeData(color: Colors.white), // Set the AppBar background color to green
        title: Text('Display Ingredients', style: TextStyle(color: Colors.white,fontFamily: 'Lato')),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Text(
                    recog_text,
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
