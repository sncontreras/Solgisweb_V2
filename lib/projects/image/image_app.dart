import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:solgis/projects/image/data/service/photo_image_service.dart';
import 'package:solgis/projects/image/presentation/widgets/alerta_widget.dart';

//class HomePageImage extends StatelessWidget {
class ImageAppState extends StatefulWidget {
  const ImageAppState({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<ImageAppState> {
  EntryProvider entryProvider = EntryProvider();

  @override
  void initState() {
    super.initState();
    //_loadImage();
    //saveImageToCacheDirectory('assets/pngs/no-image.png');
    copyAssetToCache('assets/pngs/IMAGE.png', 'IMAGE.png');
    _captureImage();
  }

  Future<void> copyAssetToCache(String assetPath, String cachePath) async {
    ByteData data = await rootBundle.load(assetPath);
    List<int> bytes = data.buffer.asUint8List();

    // Obtener el directorio temporal
    Directory cacheDirectory = await getTemporaryDirectory();
    String destinationPath = '${cacheDirectory.path}/$cachePath';

    // Guardar el contenido en el directorio temporal
    await File(destinationPath).writeAsBytes(bytes);

    print('Archivo copiado a: $destinationPath');
  }

  Future<void> saveImageToCacheDirectory(String imagePath) async {
    Directory cacheDirectory = await getTemporaryDirectory();
    String cachePath = cacheDirectory.path;
    String destinationPath = '$cachePath/$imagePath';

    // Copia o guarda la imagen en la ruta de caché
    File(imagePath).copySync(destinationPath);

    print('Imagen guardada en: $destinationPath');
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
        Future.delayed(const Duration(seconds: 0), () {
          mensajeImage(context, 'Se guardo correctamente en el servidor');
        });
        Navigator.pop(context);
        // Actualiza el estado si es necesario
      });
    } else {
      setState(() {
        Navigator.pop(context);
      });
    }
  }

  void _modifyImage(PhotoVehiclePosition photoPosition) async {
    File imageFile = File(photoPosition.file.path);
    final img.Image image =
        img.decodeImage(File(photoPosition.file.path).readAsBytesSync())!;
    img.drawString(
      image,
      img.arial_24,
      10, // Posición X
      image.height - 30, // Posición Y
      photoPosition.dateTime,
      color: img.getColor(255, 255, 255),
    );
    final img.Image logo = img.decodeImage(
        File('/data/user/0/com.jccsgruposolmar.appsol/cache/IMAGE.png')
            .readAsBytesSync())!;
    img.drawImage(image, logo,
        dstX: image.width - 220, dstY: image.height - 220);
    final Uint8List modifiedImageBytes =
        Uint8List.fromList(img.encodeJpg(image));
    File(photoPosition.file.path).writeAsBytesSync(modifiedImageBytes);

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
    imageFile = await imageFile.writeAsBytes(compressedImageBytes);

    print('Imagen comprimida y guardada.');
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final perfil = {'Nombre del Perfil': 'Posición del Perfil'};

    return Scaffold(
      appBar: AppBar(
        title: const Text('Image'),
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
