
import 'dart:convert';

import 'package:music_store/models/products_model.dart';

import 'package:get/get.dart';

import '../data/repository/recommended_product_repo.dart';

class RecommendedProductController extends GetxController{
  final RecommendedProductRepo recommendedProductRepo;
  RecommendedProductController({required this.recommendedProductRepo});
  List<dynamic> _recommendedProductList =[];
  List<dynamic> get recommendedProductList =>_recommendedProductList;

  bool _isLoaded = false;
  bool get isLoaded=> _isLoaded;

  Future<void> getRecommendedProductList() async{
    Response response = await recommendedProductRepo.getRecommendedProductList();
    if (response.statusCode ==200){
      _recommendedProductList=[];
      print("got Recommended products");
      _recommendedProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded=true;
      update();
    }else{

    }
  }
}