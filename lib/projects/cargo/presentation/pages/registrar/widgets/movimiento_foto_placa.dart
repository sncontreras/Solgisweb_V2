// ignore_for_file: library_private_types_in_public_api

/*import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:solgis/core/domain/providers/global_provider.dart';
import 'package:solgis/projects/cargo/core/helpers/consultar_placa.dart';

class MovimientoFotoPlaca extends StatelessWidget {
  const MovimientoFotoPlaca({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width * 0.95,
      height: size.height * 0.6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: size.height * 0.05),
          const TextRecognitionPage(),
        ],
      ),
    );

    /* return MaterialApp(
      title: 'Text Recognition App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TextRecognitionPage(),
    );*/
  }
}

class TextRecognitionPage extends StatefulWidget {
  const TextRecognitionPage({super.key});

  @override
  _TextRecognitionPageState createState() => _TextRecognitionPageState();
}

class _TextRecognitionPageState extends State<TextRecognitionPage> {
  File _imageFile = File("assets/images/placa_scan.jpg");
  String _recognizedText = '';
  final picker = ImagePicker();
  final textDetector = GoogleMlKit.vision.textRecognizer();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      _recognizeText();
    }
  }

  Future<void> _recognizeText() async {
    final inputImage = InputImage.fromFile(_imageFile);
    final RecognizedText recognisedText =
        await textDetector.processImage(inputImage);

    String recognizedText = recognisedText.text;

    setState(() {
      _recognizedText = recognizedText;
    });
  }

  @override
  void dispose() {
    textDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gProvider = Provider.of<GlobalProvider>(context);

    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // ignore: unnecessary_null_comparison
          //Center(child: Image.asset('assets/images/placa_scan.jpg')),
          const SizedBox(height: 120),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                onPressed: () => _pickImage(ImageSource.camera),
                child: const Text('Tomar Foto'),
              ),
              ElevatedButton(
                onPressed: () => _pickImage(ImageSource.gallery),
                child: const Text('Importar de Galería'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Texto reconocido:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
            child: SingleChildScrollView(
              child: Text(
                _recognizedText,
                style: const TextStyle(color: Colors.white, // Establece el color del texto en blanco
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              consultarPlaca(
                context,
                _recognizedText.split(' ').join(''),
                //extractMiddleLine(_recognizedText).split(' ').join(''),
                gProvider.relationmodel.codigoServicio.toString(),
                gProvider.relationModel.codigoCliente.toString(),
              );
            },
            child: const Text('Registrar'),
          )
        ],
      ),
    );
  }

  String extractMiddleLine(String text) {
    final lines = text.split('\n');
    if (lines.length >= 3) {
      return lines[1]; // Obtener la línea central (índice 1)
    } else {
      return ''; // En caso de que no haya suficientes líneas
    }
  }
}
*/