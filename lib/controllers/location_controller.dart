import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:music_store/data/repository/location_repo.dart';

import '../models/address_model.dart';
import '../models/response_model.dart';

class  LocationController extends GetxController implements GetxService{
  LocationRepo locationRepo;
  LocationController({required this.locationRepo});
  bool _loading = false;
  late Position _position;
  late Position _pickPosition;

  Placemark _placemark = Placemark();
  Placemark _pickPlaceMark = Placemark();
  Placemark get placeMark => _placemark;
  Placemark get pickPlaceMark => _pickPlaceMark;

  List<AddressModel> _addressList=[];
  List<AddressModel> get addressList=>_addressList;

  late List<AddressModel> _allAddressList;
  List<AddressModel> get allAddressList=>_allAddressList;

  final List<String> _addressTypeList=["home","office","others"];
  List<String> get addressTypeList=>_addressTypeList;

  int _addressTypeIndex=0;
  int get addressTypeIndex=>_addressTypeIndex;

  late GoogleMapController _mapController;
  GoogleMapController get mapController=>_mapController;

  bool _updateAddressData=true;
  bool _changeAddress=true;

  bool get loading => _loading;
  Position get position => _position;
  Position get pickPosition => _pickPosition;
  //service zone
  bool _isLoading = false;
  bool get isLoading=>_isLoading;

  bool _inZone = false;
  bool get inZone=>_inZone;

  bool _buttonDisabled=true;
  bool get buttonDisabled=>_buttonDisabled;

  void setMapController(GoogleMapController mapController){
    _mapController=mapController;
  }

  void updatePosition(CameraPosition position, bool fromAddress) async{
    if (_updateAddressData){
      _loading=true;
      update();
      try{
        if(fromAddress){
          _position=Position(
              longitude: position.target.longitude,
              latitude: position.target.latitude,
              timestamp: DateTime.now(),
              accuracy: 1, altitude: 1, heading: 1,
              speed: 1, speedAccuracy: 1);
        }else{
          _pickPosition=Position(
              longitude: position.target.longitude,
              latitude: position.target.latitude,
              timestamp: DateTime.now(),
              accuracy: 1, altitude: 1, heading: 1,
              speed: 1, speedAccuracy: 1);
        }


        ResponseModel _responseModel= await getZone(position.target.latitude.toString(), position.target.longitude.toString(), false);
        _buttonDisabled=!_responseModel.isSuccess;

        if(_changeAddress){
          String _address = await getAddressfromGeocode(
            LatLng(position.target.latitude, position.target.longitude)
          );
          fromAddress?_placemark=Placemark(name:_address):
          _pickPlaceMark=Placemark(name: _address);
        }
      }catch(e){
        print(e);
      }
      _loading = false;
      update();
    }else{
      _updateAddressData=true;
    }
  }
  Future<String> getAddressfromGeocode(LatLng latLng) async {
    String _address ="Unknown Location Found";
    Response response = await locationRepo.getAddressfromGeocode(latLng);
    if(response.body["status"]=='OK'){
      _address = response.body["results"][0]['formatted_address'].toString();
    }else{
      print("Error getting the google api");
    }
    return _address;
  }

  late Map<String, dynamic> _getAddress;
  Map get getAddress=>_getAddress;

  AddressModel getUserAddress(){
    late AddressModel _addressModel;
    //converting to map using jsonDecode
    _getAddress = jsonDecode(locationRepo.getUserAddress());
    try{
      _addressModel = AddressModel.fromJson(jsonDecode(locationRepo.getUserAddress()));
    }catch(e){
      print(e);
    }
    return
        _addressModel;
  }

  void setAddressTypeIndex(int index){
    _addressTypeIndex=index;
    update();
  }

  Future<ResponseModel> addAddress(AddressModel addressModel) async {
    _loading=true;
    update();
    Response response = await locationRepo.addAddress(addressModel);
    ResponseModel responseModel;
    if(response.statusCode==200){
      await getAddressList();
      String message = response.body("message");
      responseModel = ResponseModel(true,message);
      await saveUserAddress(addressModel);
    }else{
      print("couldn't save the address");
      responseModel = ResponseModel(false,response.statusText!);
    }
    update();
    return responseModel;
  }

  Future<void> getAddressList() async {
      Response response = await locationRepo.getAllAddress();
      if(response.statusCode==200 ){
        _addressList=[];
        _allAddressList=[];
        response.body.forEach((address){
          _addressList.add(AddressModel.fromJson(address));
          _allAddressList.add(AddressModel.fromJson(address));
        });
      }else{
        _addressList=[];
        _allAddressList=[];
        print("..................Not Added..................");
      }
      update();
  }
  Future<bool> saveUserAddress(AddressModel addressModel) async {
    String userAddress = jsonEncode(addressModel.toJson());
    return await locationRepo.saveUserAddress(userAddress);
  }
  void clearAddressList(){
    _addressList=[];
    _allAddressList=[];
    update();
  }

  String getUserAddressFromLocalStorage(){
    return locationRepo.getUserAddress();
  }

  void setAddAddressData(){
    _position=_pickPosition;
    _placemark=_pickPlaceMark;
    _updateAddressData=false;
    update();
  }

  Future<ResponseModel> getZone(String lat, String lng,bool markerLoad) async {
    late ResponseModel _responseModel;
    if(markerLoad){
      _loading=true;
    }else{
      _isLoading=true;
    }
    update();
    Response response = await locationRepo.getZone(lat, lng);
    if(response.statusCode==200){
        _inZone = true;
        _responseModel =ResponseModel(true, response.body["zone_id"].toString());
    }else {
      _inZone = false;
      _responseModel = ResponseModel(true, response.statusText!);
    }
      print(response.statusCode);
    update();
    return _responseModel;
  }
}