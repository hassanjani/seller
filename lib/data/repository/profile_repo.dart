import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hundredminute_seller/data/datasource/remote/dio/dio_client.dart';
import 'package:hundredminute_seller/data/datasource/remote/exception/api_error_handler.dart';
import 'package:hundredminute_seller/data/model/body/seller_body.dart';
import 'package:hundredminute_seller/data/model/response/base/api_response.dart';
import 'package:hundredminute_seller/data/model/response/seller_info.dart';
import 'package:hundredminute_seller/utill/app_constants.dart';
import 'package:http/http.dart' as http;

class ProfileRepo{
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;
  ProfileRepo({@required this.dioClient, @required this.sharedPreferences});

  Future<ApiResponse> getSellerInfo() async {
    try {
      final response = await dioClient.get(AppConstants.SELLER_URI);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<http.StreamedResponse> updateProfile(SellerModel userInfoModel, SellerBody seller,  File file, String token) async {
    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse('${AppConstants.BASE_URL}${AppConstants.SELLER_AND_BANK_UPDATE}'));
    request.headers.addAll(<String,String>{'Authorization': 'Bearer $token'});
    Map<String, String> _fields = Map();
    if(file != null) {
      request.files.add(http.MultipartFile('image', file.readAsBytes().asStream(), file.lengthSync(), filename: file.path.split('/').last));
      _fields.addAll(<String, String>{
        '_method': 'put', 'f_name': userInfoModel.fName, 'l_name': userInfoModel.lName, 'phone': userInfoModel.phone,
        'bank_name': seller.bankName, 'branch': seller.branch,
        'holder_name': seller.holderName, 'account_no': seller.accountNo,
      });
    }else {
      _fields.addAll(<String, String>{
        '_method': 'put', 'f_name': userInfoModel.fName, 'l_name': userInfoModel.lName, 'phone': userInfoModel.phone,
        'bank_name': seller.bankName, 'branch': seller.branch,
        'holder_name': seller.holderName, 'account_no': seller.accountNo, 'image': seller.image
      });
    }
    request.fields.addAll(_fields);
    http.StreamedResponse response = await request.send();
    return response;
  }


  Future<ApiResponse> updateBalance(String balance) async {
    try {
      Response response = await dioClient.post( AppConstants.BALANCE_WITHDRAW, data: {'amount' : balance});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}