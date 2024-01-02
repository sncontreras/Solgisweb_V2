import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:solgis/projects/image/data/service/photo_image_service.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

//class HomePageImage extends StatelessWidget {
class HomePageImage extends StatefulWidget {
  const HomePageImage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<HomePageImage> {
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
      print('1');
      final PhotoVehiclePosition photoVehiclePosition = PhotoVehiclePosition(
        file: pickedFile,
        position: 'SamplePosition',
        dateTime: formattedDate,
      );
      print('2');

      _modifyImage(photoVehiclePosition);
      entryProvider.setPhotoVehiclePosition(photoVehiclePosition);
      setState(() {
        PhotoImageService.uploadImageForm(
            context, pickedFile.path, 1, 7823, 'prueba');
        print('foto tomadaewr');
        // Actualiza el estado si es necesario
      });
    }
  }

  void _modifyImage(PhotoVehiclePosition photoPosition) async {
    File imageFile = File(photoPosition.file.path);
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
    print('texgto');
    // Añadir imagen en la esquina inferior derecha
    final img.Image logo =
        img.decodeImage(File('assets/pngs/SOLMAR.png').readAsBytesSync())!;

    img.drawImage(image, logo,
        dstX: image.width - 200, dstY: image.height - 200);

    // Guardar la imagen modificada
    print('image');
    final Uint8List modifiedImageBytes =
        Uint8List.fromList(img.encodeJpg(image));
    File(photoPosition.file.path).writeAsBytesSync(modifiedImageBytes);
    print('guardado');

    List<int> imageBytes = await imageFile.readAsBytes();
    Uint8List uint8listImageBytes = Uint8List.fromList(imageBytes);

    Uint8List compressedImageBytes =
        await FlutterImageCompress.compressWithList(
      uint8listImageBytes,
      minHeight: 800, // Ejemplo de tamaño máximo
      minWidth: 800, // Ejemplo de tamaño máximo
      quality:
          70, // Ajusta la calidad de compresión según sea necesario (0 - 100)
    );

    // Sobrescribe el archivo con la imagen comprimida
    await imageFile.writeAsBytes(compressedImageBytes);

    print('Imagen comprimida y guardada.');
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final perfil = {'Nombre del Perfil': 'Posición del Perfil'};

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejemplo de Flutter'),
      ),
      body: Center(
        child: PhotoWidget(
            perfil: perfil, entryProvider: entryProvider, size: size),
      ),
    );
  }
}

class PhotoWidget extends StatelessWidget {
  final Map<String, String> perfil;
  final EntryProvider entryProvider;
  final Size size;

  const PhotoWidget({
    Key? key,
    required this.perfil,
    required this.entryProvider,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        // ... Tu código existente para mostrar la foto y el perfil
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

  // Puedes implementar otras lógicas según tus necesidades
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
