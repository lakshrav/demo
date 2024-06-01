// import 'dart:developer';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:spell_check_on_client/spell_check_on_client.dart';
// import 'package:flutter/services.dart';
// import 'package:path_drawing/path_drawing.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'firebase_options.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         textTheme: const TextTheme(
//           bodyLarge: TextStyle(fontFamily: 'Gilroy'),
//           bodyMedium: TextStyle(fontFamily: 'Lato'),
//         ),
//       ),
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//       ),
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Column(
//           children: [
//             Padding(
//               padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
//               child: Text(
//                 'NutriScan',
//                 style: TextStyle(
//                   fontFamily: 'Gilroy',
//                   fontSize: 40,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFF0ea771),
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               'Check the quality of the products you are consuming.',
//               style: TextStyle(
//                 fontFamily: 'Lato',
//                 fontSize: 20,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 20),
//             GestureDetector(
//               onTap: () async {
//                 XFile? image = await ImagePicker().pickImage(
//                   source: ImageSource.gallery,
//                   imageQuality: 100,
//                 );
//                 if (image != null) {
//                   File? croppedImage = await cropImage(image.path);
//                   if (croppedImage != null) {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => DisplayImageScreen(croppedImage.path),
//                       ),
//                     );
//                   }
//                 }
//               },
//               child: CustomPaint(
//                 painter: DottedBorderPainter(borderColor: Color(0xFF0ea771), strokeWidth: 3, dashWidth: 5),
//                 child: Container(
//                   width: MediaQuery.of(context).size.width * 0.8,
//                   height: 100,
//                   decoration: BoxDecoration(
//                     color: Colors.grey[100],
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Image.asset(
//                         'assets/images/upload_2.png',
//                         width: 30,
//                         height: 30,
//                       ),
//                       SizedBox(height: 10),
//                       Text(
//                         'Upload Image',
//                         style: TextStyle(
//                           fontFamily: 'Lato',
//                           fontSize: 16,
//                           color: Colors.grey[800],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 XFile? image = await ImagePicker().pickImage(
//                   source: ImageSource.camera,
//                   imageQuality: 100,
//                 );
//                 if (image != null) {
//                   File? croppedImage = await cropImage(image.path);
//                   if (croppedImage != null) {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => DisplayImageScreen(croppedImage.path),
//                       ),
//                     );
//                   }
//                 }
//               },
//               style: ElevatedButton.styleFrom(
//                 padding: EdgeInsets.symmetric(
//                   vertical: MediaQuery.of(context).size.height * 0.02,
//                   horizontal: MediaQuery.of(context).size.width * 0.1,
//                 ),
//                 backgroundColor: Color(0xFFe7faf4),
//                 foregroundColor: Color(0xFF12d18e),
//                 shadowColor: Colors.transparent,
//                 side: BorderSide.none,
//               ),
//               child: Text(
//                 'Open Camera',
//                 style: TextStyle(
//                   fontFamily: 'Lato',
//                   fontSize: 16,
//                 ),
//               ),
//             ),
//             SizedBox(height: MediaQuery.of(context).size.height * 0.1),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<File?> cropImage(String imagePath) async {
//     CroppedFile? croppedFile = await ImageCropper().cropImage(
//       sourcePath: imagePath,
//       aspectRatioPresets: [
//         CropAspectRatioPreset.square,
//         CropAspectRatioPreset.ratio3x2,
//         CropAspectRatioPreset.original,
//         CropAspectRatioPreset.ratio4x3,
//         CropAspectRatioPreset.ratio16x9,
//       ],
//       uiSettings: [
//         AndroidUiSettings(
//           toolbarTitle: 'Crop Image',
//           toolbarColor: Color(0xFF0ea771),
//           toolbarWidgetColor: Colors.white,
//           initAspectRatio: CropAspectRatioPreset.original,
//           lockAspectRatio: false,
//         ),
//         IOSUiSettings(
//           minimumAspectRatio: 1.0,
//         ),
//       ],
//     );

//     if (croppedFile != null) {
//       return File(croppedFile.path);
//     }
//     return null;
//   }
// }

// class DottedBorderPainter extends CustomPainter {
//   final Color borderColor;
//   final double strokeWidth;
//   final double dashWidth;

//   DottedBorderPainter({required this.borderColor, this.strokeWidth = 1, this.dashWidth = 5});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint paint = Paint()
//       ..color = borderColor
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = strokeWidth;

//     final Path path = Path()
//       ..addRRect(RRect.fromRectAndRadius(
//           Rect.fromLTWH(0, 0, size.width, size.height), Radius.circular(30)));

//     final dashArray = CircularIntervalList<double>(<double>[dashWidth, dashWidth]);

//     canvas.drawPath(
//       dashPath(path, dashArray: dashArray),
//       paint,
//     );
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }

// class DisplayImageScreen extends StatefulWidget {
//   final String imagePath;
//   DisplayImageScreen(this.imagePath);

//   @override
//   _DisplayImageScreenState createState() => _DisplayImageScreenState();
// }

// class _DisplayImageScreenState extends State<DisplayImageScreen> {
//   String recogText = 'Performing OCR...';
//   List<Map<String, dynamic>> matchedIngredients = [];
//   SpellCheck? spellCheck;

//   @override
//   void initState() {
//     super.initState();
//     performOcr();
//   }

//   Future<void> performOcr() async {
//     final textRecognizer = TextRecognizer();

//     try {
//       String language = 'en';
//       String content = await rootBundle.loadString('assets/en_words.txt');
//       spellCheck = SpellCheck.fromWordsContent(content,
//           letters: LanguageLetters.getLanguageForLanguage(language));
//       final RecognizedText recognizedText = await textRecognizer.processImage(
//           InputImage.fromFilePath(widget.imagePath));
//       String correctedText = spellCheck!.didYouMean(recognizedText.text);

//       // Clean and filter the text
//       print("ORIGINAL TEXT: $correctedText");
//       correctedText = cleanAndFilterText(correctedText);
//       print("PREPROCESSED TEXT: $correctedText");
//       await searchDatabaseForIngredients(correctedText);

//       setState(() {
//         recogText = correctedText;
//       });

//     } catch (e) {
//       setState(() {
//         recogText = 'Error: $e';
//       });
//     }
//   }

//   String cleanAndFilterText(String text) {
//     // Remove brackets, numbers, punctuation, and multiple spaces
//     text = text.replaceAll(RegExp(r'\[.*?\]|\(.*?\)|\{.*?\}|\<.*?\>'), ' '); // Remove brackets
//     text = text.replaceAll(RegExp(r'[0-9]'), ' '); // Remove numbers
//     text = text.replaceAll(RegExp(r'[^\w\s]'), ' '); // Remove punctuation
//     text = text.replaceAll(RegExp(r'\s+'), ' '); // Remove multiple spaces

//     // Remove words with 2 or fewer characters
//     List<String> words = text.split(' ');
//     words = words.where((word) => word.length > 2).toList();

//     return words.join(' ');
//   }

//   Future<void> searchDatabaseForIngredients(String correctedText) async {
//     DatabaseReference ref = FirebaseDatabase.instance.ref();
//     DataSnapshot snapshot = await ref.get();

//     if (snapshot.exists) {
//       var data = snapshot.value;

//       if (data is List) {
//         bool itemFound = false;

//         for (var value in data) {
//           if (value != null && value is Map) {
//             String name = value['Name'];
//             bool isHealthy = value['Is_healthy'] == 'TRUE'; // Adjust based on your data format

//             if (correctedText.toLowerCase().contains(name.toLowerCase())) {
//               itemFound = true;
//               matchedIngredients.add({
//                 'name': name,
//                 'is_healthy': isHealthy,
//               });
//             }
//           }
//         }

//         if (!itemFound) {
//           print('Item does not exist');
//         }
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xFF0ea771),
//         iconTheme: IconThemeData(color: Colors.white),
//         title: Text('Display Ingredients', style: TextStyle(color: Colors.white, fontFamily: 'Lato')),
//       ),
//       body: SingleChildScrollView(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 color: Colors.white,
//                 padding: EdgeInsets.all(16.0),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       // Text(
//                       //   //DISPLAY SCORE HERE
//                       //   style: TextStyle(
//                       //     fontFamily: 'Lato',
//                       //     fontSize: MediaQuery.of(context).size.width * 0.05,
//                       //     color: Colors.black,
//                       //   ),
//                       // ),
//                       SizedBox(height: 20),
//                       ...matchedIngredients.map((ingredient) {
//                         return Text(
//                           '${ingredient['name']} - ${ingredient['is_healthy'] ? 'Healthy' : 'Unhealthy'}',
//                           style: TextStyle(
//                             fontFamily: 'Lato',
//                             fontSize: 18,
//                             color: ingredient['is_healthy'] ? Colors.green : Colors.red,
//                           ),
//                         );
//                       }).toList(),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:spell_check_on_client/spell_check_on_client.dart';
import 'package:flutter/services.dart';
import 'package:path_drawing/path_drawing.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontFamily: 'Gilroy'),
          bodyMedium: TextStyle(fontFamily: 'Lato'),
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
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
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
                  color: Color(0xFF0ea771),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Check the quality of the products you are consuming.',
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                XFile? image = await ImagePicker().pickImage(
                  source: ImageSource.gallery,
                  imageQuality: 100,
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
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(30),
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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                XFile? image = await ImagePicker().pickImage(
                  source: ImageSource.camera,
                  imageQuality: 100,
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
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
  String recogText = 'Performing OCR...';
  List<Map<String, dynamic>> matchedIngredients = [];
  SpellCheck? spellCheck;
  int numWords = 0;
  double score = 50;

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
      String correctedText = spellCheck!.didYouMean(recognizedText.text);

      // Clean and filter the text
      print("ORIGINAL TEXT: $correctedText");
      correctedText = cleanAndFilterText(correctedText);
      print("PREPROCESSED TEXT: $correctedText");

      numWords = correctedText.split(' ').length;
      score = calculateScore(numWords);

      await searchDatabaseForIngredients(correctedText);

      setState(() {
        recogText = correctedText;
      });

    } catch (e) {
      setState(() {
        recogText = 'Error: $e';
      });
    }
  }

  String cleanAndFilterText(String text) {
    // Remove brackets, numbers, punctuation, and multiple spaces
    text = text.replaceAll(RegExp(r'\[.*?\]|\(.*?\)|\{.*?\}|\<.*?\>'), ' '); // Remove brackets
    text = text.replaceAll(RegExp(r'[0-9]'), ' '); // Remove numbers
    text = text.replaceAll(RegExp(r'[^\w\s]'), ' '); // Remove punctuation
    text = text.replaceAll(RegExp(r'\s+'), ' '); // Remove multiple spaces

    // Remove words with 2 or fewer characters
    List<String> words = text.split(' ');
    words = words.where((word) => word.length > 2).toList();

    return words.join(' ');
  }

  double calculateScore(int numWords) {
    double initialScore = 50;
    if (numWords > 25) {
      for (int i = 26; i <= numWords; i++) {
        initialScore -= 0.01 * initialScore;
      }
    }
    return initialScore;
  }

  Future<void> searchDatabaseForIngredients(String correctedText) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    DataSnapshot snapshot = await ref.get();

    if (snapshot.exists) {
      var data = snapshot.value;

      if (data is List) {
        bool itemFound = false;

        for (var value in data) {
          if (value != null && value is Map) {
            String name = value['Name'];
            bool isHealthy = value['Is_healthy'] == 'TRUE'; // Adjust based on your data format

            if (correctedText.toLowerCase().contains(name.toLowerCase())) {
              itemFound = true;
              matchedIngredients.add({
                'name': name,
                'is_healthy': isHealthy,
              });
            }
          }
        }

        if (itemFound) {
          score = adjustScoreBasedOnIngredients(matchedIngredients, score);
        } else {
          print('Item does not exist');
        }
      }
    }
  }

  double adjustScoreBasedOnIngredients(List<Map<String, dynamic>> ingredients, double currentScore) {
    for (int i = 0; i < ingredients.length; i++) {
      bool isHealthy = ingredients[i]['is_healthy'];
      double adjustmentFactor = (i < 5) ? 0.15 : 0.10;
      if (isHealthy) {
        currentScore += adjustmentFactor * (100 - currentScore);
      } else {
        currentScore -= adjustmentFactor * currentScore;
      }
    }
    return currentScore;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0ea771),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Display Ingredients', style: TextStyle(color: Colors.white, fontFamily: 'Lato')),
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
                  child: Column(
                    children: [
                      Text(
                        'Number of Words: $numWords',
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Score: ${score.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 20),
                      ...matchedIngredients.map((ingredient) {
                        return Text(
                          '${ingredient['name']} - ${ingredient['is_healthy'] ? 'Healthy' : 'Unhealthy'}',
                          style: TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 18,
                            color: ingredient['is_healthy'] ? Colors.green : Colors.red,
                          ),
                        );
                      }).toList(),
                    ],
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
