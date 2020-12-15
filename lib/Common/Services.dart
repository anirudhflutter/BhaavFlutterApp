import 'dart:convert';

import 'package:dio/dio.dart';
import '../Common/constants.dart' as cnst;
import 'ClassList.dart';

Dio dio = new Dio();

class Services {
  static Future<RegisterDataClass> RegisterUser(body) async {
    print(body.toString());
    String url = cnst.API_URL + 'api/customer/register';
    print("RegisterUser url : " + url);
    try {
      final response = await dio.post(url, data: body);
      if (response.statusCode == 200) {
        RegisterDataClass saveData =
            new RegisterDataClass(Message: 'No Data', IsSuccess: false);
        print("RegisterUser Response: " + response.data.toString());
        var memberDataClass = response.data;
        saveData.Message = memberDataClass["Message"];
        saveData.IsSuccess = memberDataClass["IsSuccess"];
        saveData.Data = memberDataClass["Data"];

        return saveData;
      } else {
        throw Exception(response.data.toString());
      }
    } catch (e) {
      print("RegisterUser Error ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  static Future<List> LoginUser(body) async {
    print(body.toString());
    String url = cnst.API_URL + 'api/customer/login';
    print("LoginUser url : " + url);
    try {
      final response = await dio.post(url, data: body);
      List list = [];
      if (response.statusCode == 200) {
        print("LoginUser Response: " + response.data.toString());
        var memberDataClass = response.data;
        if (memberDataClass["Data"] != 0) {
          print(memberDataClass["Data"]);
          list = memberDataClass["Data"];
        } else {
          list = [];
        }
        return list;
      } else {
        throw Exception(response.data.toString());
      }
    } catch (e) {
      print("LoginUser Error ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  static Future<GetAllProductsDataClass> GetAllProducts() async {
    String url = cnst.API_URL + 'api/product/getProducts';
    print("GetAllProducts url : " + url);
    try {
      final response = await dio.post(url);
      List list = [];
      if (response.statusCode == 200) {
        GetAllProductsDataClass saveData =
            new GetAllProductsDataClass(Message: 'No Data', IsSuccess: false);
        print("GetAllProducts Response: " + response.data.toString());
        var memberDataClass = response.data;
        saveData.Message = memberDataClass["Message"];
        saveData.IsSuccess = memberDataClass["IsSuccess"];
        saveData.Data = memberDataClass["Data"];

        return saveData;
      } else {
        throw Exception(response.data.toString());
      }
    } catch (e) {
      print("GetAllProducts Error ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  static Future<GetAllProductsDataClass> getProductDetails(body) async {
    String url = cnst.API_URL + 'api/product/getProductDetails';
    print("getProductDetails url : " + url);
    try {
      final response = await dio.post(url, data: body);
      List list = [];
      if (response.statusCode == 200) {
        GetAllProductsDataClass saveData =
            new GetAllProductsDataClass(Message: 'No Data', IsSuccess: false);
        print("getProductDetails Response: " + response.data.toString());
        var memberDataClass = response.data;
        saveData.Message = memberDataClass["Message"];
        saveData.IsSuccess = memberDataClass["IsSuccess"];
        saveData.Data = memberDataClass["Data"];

        return saveData;
      } else {
        throw Exception(response.data.toString());
      }
    } catch (e) {
      print("getProductDetails Error ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  static Future<List> GetStates() async {
    String url = cnst.API_URL + 'api/admin/getState';
    print("GetStates url : " + url);
    try {
      final response = await dio.post(url);
      List list = [];
      if (response.statusCode == 200) {
        var memberDataClass = response.data;
        if (memberDataClass["Data"] != 0) {
          print(memberDataClass["Data"]);
          list = memberDataClass["Data"];
        } else {
          list = [];
        }
        return list;
      } else {
        throw Exception(response.data.toString());
      }
    } catch (e) {
      print("GetStates Error ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  static Future<List> GetCities() async {
    String url = cnst.API_URL + 'api/admin/getCity';
    print("GetCities url : " + url);
    try {
      final response = await dio.post(url);
      List list = [];
      if (response.statusCode == 200) {
        var memberDataClass = response.data;
        if (memberDataClass["Data"] != 0) {
          print(memberDataClass["Data"]);
          list = memberDataClass["Data"];
        } else {
          list = [];
        }
        return list;
      } else {
        throw Exception(response.data.toString());
      }
    } catch (e) {
      print("GetCities Error ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  static Future<List> GetAllUsers() async {
    String url = cnst.API_URL + 'api/customer/getUsers';
    print("GetAllUsers url : " + url);
    try {
      final response = await dio.post(url);
      List list = [];
      if (response.statusCode == 200) {
        print("GetAllUsers Response: " + response.data.toString());
        var memberDataClass = response.data;
        if (memberDataClass["Data"] != 0) {
          print(memberDataClass["Data"]);
          list = memberDataClass["Data"];
        } else {
          list = [];
        }
        return list;
      } else {
        throw Exception(response.data.toString());
      }
    } catch (e) {
      print("LoginUser Error ${e.toString()}");
      throw Exception(e.toString());
    }
  }
}
