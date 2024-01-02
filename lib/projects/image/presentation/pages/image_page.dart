/*import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:solgis/projects/image/data/service/photo_image_service.dart';


class HomePageImage extends StatefulWidget {
  const HomePageImage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePageImage> {
  EntryProvider entryProvider = EntryProvider();

  @override
  void initState() {
    super.initState();
    _captureImage();
  }

  Future<void> _captureImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      final DateTime now = DateTime.now();
      final String formattedDate =
          DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

      final PhotoVehiclePosition photoVehiclePosition = PhotoVehiclePosition(
        file: pickedFile,
        position: 'SamplePosition',
        dateTime: formattedDate,
      );

      _modifyImage(photoVehiclePosition);

      entryProvider.setPhotoVehiclePosition(photoVehiclePosition);
      setState(() {
        PhotoImageService.uploadImageForm(
            context, pickedFile.path, 1, 7823, 'prueba');
        // Actualiza el estado si es necesario
        print('foto tomada');
        // Actualiza el estado si es necesario
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                NewPhotoScreen(photoVehiclePosition: photoVehiclePosition),
          ),
        );
      });

      // Después de tomar y modificar la imagen, mostrar la pantalla con la nueva foto
    }
  }

  void _modifyImage(PhotoVehiclePosition photoPosition) {
    final img.Image image =
        img.decodeImage(File(photoPosition.file.path).readAsBytesSync())!;

    // Añadir fecha y hora en la esquina inferior izquierda
    img.drawString(
      image,
      img.arial_48,
      10, // Posición X
      image.height - 20, // Posición Y
      'Fecha y Hora: ${photoPosition.dateTime}',
      color: img.getColor(255, 255, 255),
    );

    // Añadir imagen en la esquina inferior derecha
    final img.Image logo =
        img.decodeImage(File(photoPosition.file.path).readAsBytesSync())!;

    img.drawImage(image, logo,
        dstX: image.width - 200, dstY: image.height - 200);

    // Guardar la imagen modificada
    final Uint8List modifiedImageBytes =
        Uint8List.fromList(img.encodeJpg(image));
    File(photoPosition.file.path).writeAsBytesSync(modifiedImageBytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejemplo de Flutter'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _captureImage();
          },
          child: const Text('Tomar Foto'),
        ),
      ),
    );
  }
}

class NewPhotoScreen extends StatelessWidget {
  final PhotoVehiclePosition photoVehiclePosition;

  const NewPhotoScreen({Key? key, required this.photoVehiclePosition})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva Foto'),
      ),
      body: Center(
        child: PhotoWidget(
            entryProvider: EntryProvider()
              ..setPhotoVehiclePosition(photoVehiclePosition)),
      ),
    );
  }
}

class PhotoWidget extends StatelessWidget {
  final EntryProvider entryProvider;

  const PhotoWidget({Key? key, required this.entryProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PhotoVehiclePosition? photoPosition =
        entryProvider.getPhotoVehiclePosition();

    return Stack(
      children: [
        if (photoPosition != null)
          Image.memory(
            File(photoPosition.file.path).readAsBytesSync(),
            fit: BoxFit.cover,
          ),
      ],
    );
  }
}

class EntryProvider {
  PhotoVehiclePosition? _photoVehiclePosition;

  PhotoVehiclePosition? getPhotoVehiclePosition() {
    return _photoVehiclePosition;
  }

  void setPhotoVehiclePosition(PhotoVehiclePosition photoVehiclePosition) {
    _photoVehiclePosition = photoVehiclePosition;
  }
}

class PhotoVehiclePosition {
  final XFile file;
  final String position;
  final String dateTime;

  PhotoVehiclePosition({
    required this.file,
    required this.position,
    required this.dateTime,
  });
}
*/