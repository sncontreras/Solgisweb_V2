import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:solgis/core/domain/entities/document_type.dart';
import 'package:solgis/core/domain/entities/gender.dart';
import 'package:solgis/core/domain/entities/job.dart';
import 'package:solgis/core/domain/entities/person_type.dart';
import 'package:solgis/core/domain/models/enterprise_model.dart';
import 'package:solgis/core/global/constants.dart';

class CreateDriverProvider extends ChangeNotifier{

  bool _isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  File? foto;
  DocumentType _selectedDocumentType = typesDocument.first;  
  TextEditingController _documentControlller = TextEditingController();
  Gender _selectedGender = genders.first;  
  PersonType _selectedPersonType  =  PersonType() ;  
  TextEditingController _fNameControlller = TextEditingController();
  TextEditingController _sNameControlller = TextEditingController();
  TextEditingController _fLastNameController = TextEditingController();
  TextEditingController _sLastNameControlller = TextEditingController();
  TextEditingController _licenseControlller = TextEditingController();
  XFile? _photoLicense;
  EnterpriseModel _selectedEnterprise = EnterpriseModel();
  Job _selectedJob  =  Job() ;  

  Job get selectedJob => _selectedJob;
  set selectedJob( Job job ){
    _selectedJob = job;
    notifyListeners();
  } 


  EnterpriseModel get selectedEnterprise=> _selectedEnterprise;
  set selectedEnterprise( EnterpriseModel vehicletype ){
    _selectedEnterprise = vehicletype;
    notifyListeners();
  }

  bool get isLoading => _isLoading;
  set isLoading( bool value ){
    _isLoading = value;
    notifyListeners();
  }

  XFile? get photoLicense=> _photoLicense;
  set photoLicense( XFile? photo ){
    _photoLicense = photo;
    notifyListeners();
  }

  TextEditingController get licenseController=> _licenseControlller;
  set licenseController( TextEditingController license ){
    _licenseControlller = license;
    notifyListeners();
  }

  TextEditingController get sLastNameController=> _sLastNameControlller;
  set sLastNameController( TextEditingController fname ){
    _sLastNameControlller = fname;
    notifyListeners();
  }

  TextEditingController get fLastNameController=> _fLastNameController;
  set fLastNameController( TextEditingController sname ){
    _fLastNameController = sname;
    notifyListeners();
  }

  TextEditingController get sNameController=> _sNameControlller;
  set sNameController( TextEditingController fsurname ){
    _sNameControlller = fsurname;
    notifyListeners();
  }

  TextEditingController get fNameController=> _fNameControlller;
  set fNameController( TextEditingController ssurname ){
    _fNameControlller = ssurname;
    notifyListeners();
  }

  PersonType get selectedPersonType => _selectedPersonType;
  set selectedPersonType( PersonType personType ){
    _selectedPersonType = personType;
    notifyListeners();
  } 

  Gender get selectedGender => _selectedGender;
  set selectedGender( Gender gender ){
    _selectedGender = gender;
    notifyListeners();
  } 

  TextEditingController get documentController=> _documentControlller;
  set documentController( TextEditingController document ){
    _documentControlller = document;
    notifyListeners();
  }

  DocumentType get selectedDocumentType=> _selectedDocumentType;
  set selectedDocumentType( DocumentType documentType ){
    _selectedDocumentType = documentType;
    notifyListeners();
  }


  void updateImage( String path ){
    foto = File.fromUri(Uri(path: path));
    notifyListeners();
  }

}