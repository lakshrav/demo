import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:spell_check_on_client/spell_check_on_client.dart';
import 'package:flutter/services.dart';


void main() {
  runApp(MyApp());
}

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
                          builder: (context) =>
                              DisplayImageScreen(croppedImage.path)),
                    );
                  }
                }
              },
              child: Text('Upload Image'),
            ),
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
          toolbarColor: Colors.deepOrange,
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
        title: Text('Display Image'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.file(File(widget.imagePath)),
              // SizedBox(height: 20),
              Text(recog_text, style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05)),
            ],
          ),
        ),
      ),
    );
  }
}
