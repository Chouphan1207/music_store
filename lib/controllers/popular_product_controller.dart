
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:music_store/models/products_model.dart';
import 'package:music_store/utils/colors.dart';

import '../data/repository/popular_product_repo.dart';
import 'package:get/get.dart';

import '../models/cart_model.dart';
import 'cart_controller.dart';

class PopularProductController extends GetxController{
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});
  List<dynamic> _popularProductList =[];
  List<dynamic> get popularProductList =>_popularProductList;
  late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded=> _isLoaded;

  int _quantity=0;
  int get quantity=>_quantity;
  int _inCartItem=0;
  int get inCartItem=>_inCartItem+_quantity;

  Future<void> getPopularProductList() async{
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode ==200){
      _popularProductList=[];
      print("got popular products");
      _popularProductList.addAll(Product.fromJson(response.body).products);
      // _popularProductList.addAll(Product.fromJson(jsonDecode(response.body.toString())).products);
      //print(_popularProductList);
      _isLoaded=true;
      update();
    }else{

    }
    // String jsonsDataString = response.body.toString(); // toString of Response's body is assigned to jsonDataString
    // _popularProductList = jsonDecode(jsonsDataString);
    // print(_popularProductList.toString());
  }

  void setQuantity(bool isIncrement){
    if(isIncrement){
      print("increment "+_quantity.toString());
      _quantity = checkQuantity(_quantity+1);
    }else{
      print("decrement "+_quantity.toString());
      _quantity = checkQuantity(_quantity-1);
    }
    update();
  }
  int checkQuantity(int quantity){
    if((_inCartItem+quantity)<0){
      Get.snackbar("Item count", "You can't reduce more.",
      backgroundColor: AppColors.mainColor,colorText: Colors.white);
      if(_inCartItem>0){
        _quantity= -_inCartItem;
        return _quantity;
      }
      return 0;
    }else if((_inCartItem+quantity)>10){
      Get.snackbar("Item count", "You have reached the maximum amount to add to cart.",
          backgroundColor: AppColors.mainColor,colorText: Colors.white);
      return 10;
    }else{
      return quantity;
    }
  }

  void initProduct(ProductModel product,CartController cart){
    _quantity=0;
    _inCartItem=0;
    _cart=cart;
    var exist=false;
    exist = _cart.existInCart(product);
  //get from storage _inCartItems=3
  //   print("exist or not: $exist");
    if(exist){
      _inCartItem=_cart.getQuantity(product);
    }
    // print("the quantity in the cart is: $_inCartItem");
  }

   void addItem(ProductModel product){
      _cart.addItem(product, _quantity);

      _quantity=0;
      _inCartItem=_cart.getQuantity(product);

      _cart.items.forEach((key, value) {
        print("The id is ${value.id}. The quantity is ${value.quantity}");
      });
      update();
  }

  int get totalItems{
    return _cart.totalItems;
  }
  List<CartModel> get getItems{
    return _cart.getItems;
  }
}