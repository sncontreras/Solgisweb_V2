import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:solgis/core/domain/entities/photo_vehicle_position.dart';
import 'package:solgis/core/domain/entities/reason.dart';
import 'package:solgis/core/domain/models/authority.dart';
import 'package:solgis/projects/cargo/data/models/parking_model.dart';
import 'package:solgis/projects/cargo/domain/entities/access_area.dart';
import 'package:solgis/projects/cargo/domain/entities/carga_type.dart';
import 'package:solgis/projects/cargo/domain/entities/epps.dart';
import 'package:solgis/projects/cargo/domain/entities/guia.dart';
import 'package:solgis/projects/cargo/domain/entities/operator.dart';
import 'package:solgis/projects/cargo/domain/entities/option_radio.dart';
import 'package:solgis/projects/cargo/domain/entities/origin.dart';
import 'package:solgis/projects/cargo/domain/entities/precinto.dart';
import 'package:solgis/projects/cargo/domain/entities/vehicle_type.dart';

class IngresoAutorizadoProvider extends ChangeNotifier {
  //controla si hay conductor.
  bool _hasDriver = false;

  //controla si hay conductor.
  ParkingModel _parkingModelSelected = ParkingModel();
  int _parking = 0;

  //controla el step
  int _indexStep = 0;

  //controla el documento
  TextEditingController _documentController = TextEditingController();

  //CAMPOS PARA EL CONTAINER
  TextEditingController _containerController = TextEditingController();

  XFile? _containerPhoto;

  //CAMPOS PARA LA GUIA DE TRANSPORTISTA
  TextEditingController _gtransportistaController = TextEditingController();

  XFile? _gTranportistaPhoto;

  //CAMPOS PARA EL BOOKING
  TextEditingController _bookingController = TextEditingController();

  XFile? _bookingPhoto;

  //CAMPOS PARA EL CONTRATO
  TextEditingController _contratoController = TextEditingController();

  XFile? _contratoPhoto;

  //controla el alcoholimetro
  bool _alcoholimetroSelected = false;

  XFile? _alcoholimetroPhoto;

  //controla el origen
  Origin _selectedOrigin = const Origin();

  //controla el operador logistico
  Operator _selectedOpLog = const Operator();

  //controla la carga
  bool _cargaSelected = true;

  //Controla los epps seleccionados
  List<Epps> _selectedEpps = [];

  //Controla el autorizante seleccionado.
  Authority _selectedAutorizante = Authority();

  //Controla la razon seleccionado.
  Reason _selectedReason = const Reason();

  //Controla el area seleccionado.
  AccessArea _selectedAccessArea = const AccessArea();

  //Controla la opcion seleccionada en el tamaño del contenedor.
  OptionRadio _selectedTContainer = const OptionRadio();

  //Controla las guias creadas.
  final List<Guia> _selectedGuias = [];

  //Controla las fotos de las posiciones del vehiculo .
  final List<PhotoVehiclePosition> _photosTakedVehiclePosition = [];

  //controla el tipo de carga seleccionado
  late CargaType _cargaTypeSelected = const CargaType();

  //controla el material seleccionado
  late CargaType _materialSelected = const CargaType();

  //controla el tipo de vehiculo seleccionado
  late VehicleType _vechicleTypeSelected = VehicleType();

  //carreta
  TextEditingController _carretaController = TextEditingController();

  //kilometraje
  TextEditingController _kilometrajeController = TextEditingController();

  //destino
  TextEditingController _destinoController = TextEditingController();

  //guia
  String _guiaTemp = '';

  //foto temporal
  XFile? _photoTemp;

  bool _isLoading = false;

  //Controla las Precintos creadas.
  final List<Precinto> _selectedPrecintos = [];
  //precinto
  String _precintoTemp = '';

  //foto precinto temporal
  XFile? _precintophotoTemp;

  //TIENE CONDUCTOR SELECCIONADO
  bool get hasDriver => _hasDriver;
  set hasDriver(bool value) {
    _hasDriver = value;
    notifyListeners();
  }

  // MODELO DEL PARQUEO
  ParkingModel get parkingModel => _parkingModelSelected;
  set parkingModel(ParkingModel value) {
    _parkingModelSelected = value;
    notifyListeners();
  }

  set parkingModelSinRefresh(ParkingModel value) {
    _parkingModelSelected = value;
  }

  int get parking => _parking;
  set parking(int value) {
    _parking = value;
    notifyListeners();
  }

  set parkingsinRefresh(int value) {
    _parking = value;
  }

  //CONTENEDOR
  TextEditingController get containerController => _containerController;
  set containerController(TextEditingController value) {
    _containerController = value;
    notifyListeners();
  }

  XFile? get containerPhoto => _containerPhoto;
  set containerPhoto(XFile? value) {
    _containerPhoto = value;
    notifyListeners();
  }

  //G TRANSPORTISTAS
  TextEditingController get gTranportistaController =>
      _gtransportistaController;
  set gTranportistaController(TextEditingController value) {
    _gtransportistaController = value;
    notifyListeners();
  }

  XFile? get gTranportistaPhoto => _gTranportistaPhoto;
  set gTranportistaPhoto(XFile? value) {
    _gTranportistaPhoto = value;
    notifyListeners();
  }

  //BOOKING
  TextEditingController get bookingController => _bookingController;
  set bookingController(TextEditingController value) {
    _bookingController = value;
    notifyListeners();
  }

  XFile? get bookingPhoto => _bookingPhoto;
  set bookingPhoto(XFile? value) {
    _bookingPhoto = value;
    notifyListeners();
  }

  //CONTRATO
  TextEditingController get contratoController => _contratoController;
  set contratoController(TextEditingController value) {
    _contratoController = value;
    notifyListeners();
  }

  XFile? get contratoPhoto => _contratoPhoto;
  set contratoPhoto(XFile? value) {
    _contratoPhoto = value;
    notifyListeners();
  }

  //ALCOHOLIMETRO
  bool get alcoholimetro => _alcoholimetroSelected;
  set alcoholimetro(bool value) {
    _alcoholimetroSelected = value;
    notifyListeners();
  }

  XFile? get alcoholimetroPhoto => _alcoholimetroPhoto;
  set alcoholimetroPhoto(XFile? value) {
    _alcoholimetroPhoto = value;
    notifyListeners();
  }

  //METODO EL ORIGEN SELECCIONADO
  Origin get selectedOrigin => _selectedOrigin;
  set selectedOrigin(Origin valor) {
    _selectedOrigin = valor;
    notifyListeners();
  }

  //METODO EL ORIGEN SELECCIONADO
  Operator get selectedOperator => _selectedOpLog;
  set selectedOperator(Operator valor) {
    _selectedOpLog = valor;
    notifyListeners();
  }

  //METODO PARA LA LISTA DE EPPS SELECCIONADOS
  List<Epps>? get selectedEpps => _selectedEpps;
  set selectedEpps(List<Epps>? valor) {
    _selectedEpps = valor!;
    notifyListeners();
  }

  //METODO PARA LA LISTA DE TIPO DE CARGA.
  CargaType get cargaTypeSelected => _cargaTypeSelected;
  set cargaTypeSelected(CargaType valor) {
    _cargaTypeSelected = valor;
    notifyListeners();
  }

  //METODO PARA LA LISTA DE TIPO DE MATERIAL.
  CargaType get materialSelected => _materialSelected;
  set materialSelected(CargaType valor) {
    _materialSelected = valor;
    notifyListeners();
  }

  //METODO PARA LA LISTA DE TIPO DE VEHICULO.
  VehicleType get vehicleTypeSelected => _vechicleTypeSelected;
  set vechicleTypeSelected(VehicleType valor) {
    _vechicleTypeSelected = valor;
    notifyListeners();
  }

  //METODOS PARA VER SI ESTA CARGANDO O NO
  bool get isLoading => _isLoading;
  set isLoading(bool valor) {
    _isLoading = valor;
    notifyListeners();
  }

  //METODOS DEL DOCUMENTO
  TextEditingController get documentController => _documentController;

  set documentController(TextEditingController controller) {
    _documentController = controller;
    notifyListeners();
  }

  //METODOS DE CARRETA
  TextEditingController get carretaController => _carretaController;
  set carretaController(TextEditingController value) {
    _carretaController = value;
    notifyListeners();
  }

  //METODOS DE KILOMETRAJE
  TextEditingController get kilometrajeController => _kilometrajeController;
  set kilometrajeController(TextEditingController value) {
    _kilometrajeController = value;
    notifyListeners();
  }

  //METODOS DE DESTINO
  TextEditingController get destinoController => _destinoController;
  set destinoController(TextEditingController value) {
    _destinoController = value;
    notifyListeners();
  }

  //STEP
  int get indexStep => _indexStep;
  set indexStep(int valor) {
    _indexStep = valor;
    notifyListeners();
  }

  //CARGA
  bool get selectedCarga => _cargaSelected;
  set selectedCarga(bool valor) {
    _cargaSelected = valor;
    notifyListeners();
  }

  //METODOS PARA EL AUTORIZANTE
  Authority get selectedAutorizante => _selectedAutorizante;
  set selectedAutorizante(Authority valor) {
    _selectedAutorizante = valor;
    notifyListeners();
  }

  set selectedAutorizanteSinRefresh(Authority valor) {
    _selectedAutorizante = valor;
  }

  //METODOS PARA EL MOTIVO
  Reason get selectedReason => _selectedReason;
  set selectedReason(Reason valor) {
    _selectedReason = valor;
    notifyListeners();
  }

  set selectedReasonSinRefresh(Reason valor) {
    _selectedReason = valor;
  }

  //METODOS PARA EL AREA DE ACCESO
  AccessArea get selectedAccessArea => _selectedAccessArea;
  set selectedAccessArea(AccessArea valor) {
    _selectedAccessArea = valor;
    notifyListeners();
  }

  set selectedAccessAreaSinRefresh(AccessArea valor) {
    _selectedAccessArea = valor;
  }

  //METODOS PARA LA OPCION DE LOS RADIOS DEL TAMAÑO DEL CONTENEDOR.
  OptionRadio get selectedOptionRadio => _selectedTContainer;
  set selectedOptionRadio(OptionRadio valor) {
    _selectedTContainer = valor;
    notifyListeners();
  }

  //METODOS PARA LAS GUIAS.
  List<Guia> get selectedGuias => _selectedGuias;

  setGuia(Guia guia) {
    _selectedGuias.add(guia);
    notifyListeners();
  }

  deleteGuia(int index) {
    _selectedGuias.removeAt(index);
    notifyListeners();
  }

  deleteAllGuias() {
    _selectedGuias.clear();
    notifyListeners();
  }

  getGuia(int index) {
    return _selectedGuias[index];
  }

  //METODOS PARA LAS FOTOS TOMADAS DE LA POSICION DE VEHICULO.
  List<PhotoVehiclePosition> get selectedPhotosVPosition =>
      _photosTakedVehiclePosition;

  setPhotoVehiclePosition(PhotoVehiclePosition photo) {
    _photosTakedVehiclePosition.add(photo);
    notifyListeners();
  }

  deletePhotoVehiclePosition(int index) {
    if (_photosTakedVehiclePosition.isNotEmpty) {
      _photosTakedVehiclePosition
          .removeWhere((photo) => photo.position == index);
      notifyListeners();
    }
  }

  deleteAllPhotosVehiclePosition() {
    _photosTakedVehiclePosition.clear();
    notifyListeners();
  }

  getPhotoVehiclePosition(int index) {
    if (_photosTakedVehiclePosition.isNotEmpty) {
      for (var photo in _photosTakedVehiclePosition) {
        if (photo.position == index) {
          return photo;
        }
      }
    }
    return null;
  }

  //Metodos de guia temporal
  String get guiaTemp => _guiaTemp;
  set guiaTemp(String value) {
    _guiaTemp = value;
    notifyListeners();
  }

  //Metodos de foto temporal
  XFile? get photoTemp => _photoTemp;
  set photoTemp(XFile? value) {
    _photoTemp = value;
    notifyListeners();
  }

  //METODOS PARA LOS PRECINTOS
  List<Precinto> get selectedPrecintos => _selectedPrecintos;

  setPrecinto(Precinto precinto) {
    _selectedPrecintos.add(precinto);
    notifyListeners();
  }

  deletePrecinto(int index) {
    _selectedPrecintos.removeAt(index);
    notifyListeners();
  }

  deleteAllPrecintos() {
    _selectedPrecintos.clear();
    notifyListeners();
  }

  getPrecinto(int index) {
    return _selectedPrecintos[index];
  }

  //Metodos de precinto temporal
  String get precintoTemp => _precintoTemp;
  set precintoTemp(String value) {
    _precintoTemp = value;
    notifyListeners();
  }

  //Metodos de foto del precinto temporal
  XFile? get precintoPhotoTemp => _precintophotoTemp;
  set precintoPhotoTemp(XFile? value) {
    _precintophotoTemp = value;
    notifyListeners();
  }

  cleanDriverInformation() {
    _selectedAutorizante = Authority();
    _selectedReason = const Reason();
    _selectedAccessArea = const AccessArea();
    _alcoholimetroPhoto = null;
    _alcoholimetroSelected = false;
    _selectedEpps = [];
    _parkingModelSelected = ParkingModel();
    _parking = 0;
    notifyListeners();
  }

  cleanEntryData() {
    _hasDriver = false;
    _indexStep = 0;
    _carretaController = TextEditingController();
    _cargaSelected = true;
    _selectedOrigin = const Origin();
    _selectedGuias.clear();
    _guiaTemp = '';
    _photoTemp = null;
    _containerController = TextEditingController();
    _containerPhoto = null;
    _selectedTContainer = const OptionRadio();
    _gtransportistaController = TextEditingController();
    _gTranportistaPhoto = null;
    _selectedPrecintos.clear();
    _precintoTemp = '';
    _precintophotoTemp = null;
    _bookingController = TextEditingController();
    _bookingPhoto = null;
    _contratoController = TextEditingController();
    _destinoController = TextEditingController();
    _kilometrajeController = TextEditingController();
    _contratoPhoto = null;
    _selectedOpLog = const Operator();
    _cargaTypeSelected = const CargaType();
    _materialSelected = const CargaType();
    _documentController.clear();
    notifyListeners();
  }

  cleanPhotosVehicle() {
    _photosTakedVehiclePosition.clear();
    notifyListeners();
  }
}
