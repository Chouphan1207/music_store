import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:music_store/data/api/api_client.dart';

import '../../utils/app_constants.dart';

class RecommendedProductRepo extends GetxService{
  final ApiClient apiClient;
  RecommendedProductRepo({required this.apiClient});

  Future<Response> getRecommendedProductList() async{
    return await apiClient.getData(AppConstants.RECOMMENDED_PRODUCT_URI);
  }
}