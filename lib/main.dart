import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp()); // calls the widget MyApp to run it 
}

// Break up code into components - "separation of concerns"
// Widget is an example of that

// A widget can be created by a new class extending 'Stateless Widget'
// A widget has a 'build' method that returns type 'widget'.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text Recognition App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
        title: Text('Text Recognition App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                // Open image picker to select an image
                XFile? image = await ImagePicker().pickImage(
                  source: ImageSource.gallery,
                  imageQuality: 50, // Adjust image quality as needed
                );
                if (image != null) {
                  // Navigate to the new screen to display the selected image
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DisplayImageScreen(image.path)),
                  );
                }
              },
              child: Text('Upload Image'),
            ),
          ],
        ),
      ),
    );
  }
}

class DisplayImageScreen extends StatefulWidget {
  final String imagePath;
  DisplayImageScreen(this.imagePath);

  @override
  _DisplayImageScreenState createState() => _DisplayImageScreenState();
}

class _DisplayImageScreenState extends State<DisplayImageScreen> {
  String recognizedText = 'Performing OCR...';
  String recog_text = "...";
  @override
  void initState() {
    super.initState();
    performOcr();
  }

  Future<void> performOcr() async {
    final textRecognizer = TextRecognizer();

    try {
      final RecognizedText recognizedText = await textRecognizer.processImage(InputImage.fromFilePath(widget.imagePath)); 
      setState(() {
        recog_text = recognizedText.text;
      });
    } catch (e) {
      setState(() {
        recognizedText = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Display Image'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.file(File(widget.imagePath)),
            SizedBox(height: 20),
            Text(recog_text),
          ],
        ),
      ),
    );
  }
}


