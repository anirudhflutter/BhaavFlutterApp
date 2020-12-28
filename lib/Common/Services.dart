import 'dart:convert';

import 'package:dio/dio.dart';
import '../Common/constants.dart' as cnst;
import 'ClassList.dart';
import 'package:http/http.dart' as http;

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

  static Future<List> getMlData(String mandiname) async {
    String url = cnst.python_url + 'getuserselectedmandi?MandiName=$mandiname';
    print("getMlData url : " + url);
    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        List list =[];
        var memberDataClass = response.data;
        if (memberDataClass["data"] != 0) {
          print(memberDataClass["data"]);
          list = memberDataClass["data"];
        } else {
          list = [];
        }
        return list;
      } else {
        throw Exception(response.data.toString());
      }
    } catch (e) {
      print("getMlData Error ${e.toString()}");
      throw Exception(e.toString());
    }
  }


  static Future<List> getAllMandi({String language}) async {
    String url = cnst.API_URL + "api/mandi/getAllMandi";
    // String url = "http://192.168.29.54:5000/getAllMandis?language=$language";
    print("getAllMandis url : " + url);
    try {
      final response = await dio.post(url);
      print("response");
      print(response.statusCode);
      if (response.statusCode == 200) {
        List list =[];
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
      print("getAllMandis Error ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  static Future<List> getComapnyList({String language}) async {
    String url = cnst.API_URL + "api/company/getComapnyList";
    // String url = "http://192.168.29.54:5000/getAllMandis?language=$language";
    print("getAllMandis url : " + url);
    try {
      final response = await dio.post(url);
      print("response");
      print(response.statusCode);
      if (response.statusCode == 200) {
        List list =[];
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
      print("getAllMandis Error ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  static Future<List> getMandiProducts(body) async {
    String url = cnst.API_URL + "api/mandi/getMandiProductPrice";
    print("getMandiProducts url : " + url);
    try {
      final response = await dio.post(url,data: body);
      List list = [];
      // if (response.statusCode == 200) {
        print("response.data");
        print(response.data);
        var memberDataClass = response.data;
        if (memberDataClass["Data"] != 0) {
          print(memberDataClass["Data"]);
          list = memberDataClass["Data"];
        } else {
          list = [];
        }
        return list;
      // } else {
      //   throw Exception(response.data.toString());
      // }
    } catch (e) {
      print("getMandiProducts Error ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  static Future<List> getFarmerProduct(body) async {
    // http://15.206.79.244/getuserselectedmandi?MandiName=Aatpadi
    String url = cnst.API_URL + "api/farmer/getFarmerProduct";
    print("getFarmerProduct url : " + url);
    try {
      final response = await dio.post(url,data: body);
      List list = [];
      if (response.statusCode == 200) {
      print("response.data");
      print(response.data);
      var memberDataClass = response.data;
      if (memberDataClass["IsSuccess"] ==true) {
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
      print("getFarmerProduct Error ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  static Future<List> addProductForSale(body) async {
    // http://15.206.79.244/getuserselectedmandi?MandiName=Aatpadi
    String url = cnst.API_URL + "api/farmer/addProductForSale";
    print("addProductForSale url : " + url);
    try {
      final response = await dio.post(url,data: body);
      List list = [];
      // if (response.statusCode == 200) {
      var memberDataClass = response.data;
      if (memberDataClass["Data"] != 0) {
        print("member data");
        print(memberDataClass["Data"]);
        list = memberDataClass["Data"];
      } else {
        list = [];
      }
      return list;
      // } else {
      //   throw Exception(response.data.toString());
      // }
    } catch (e) {
      print("addProductForSale Error ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  static Future<Map> getMandiDistance(body) async {
    String url = cnst.API_URL + "api/mandi/getDistanceFromMandi";
    print("getMandiDistance url : " + url);
    try {
      final response = await dio.post(url,data: body);
      // if (response.statusCode == 200) {
      print("response.data");
      print(response.data);
      var memberDataClass = response.data;
      if (memberDataClass["Data"] != 0) {
        print(memberDataClass["Data"]);
      } else {
        return {};
      }
      return response.data;
      // } else {
      //   throw Exception(response.data.toString());
      // }
    } catch (e) {
      print("getMandiDistance Error ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  static Future<List> getMandiProductsFromPythonApi(String mandiname) async {
    // http://15.206.79.244/getuserselectedmandi?MandiName=Aatpadi
    String url = cnst.python_url + "getuserselectedmandi?MandiName=$mandiname";
    print("getMandiProducts url : " + url);
    try {
      final response = await dio.get(url);
      List list = [];
      // if (response.statusCode == 200) {
      print("response.data");
      print(response.data);
      var memberDataClass = response.data;
      if (memberDataClass["data"] != 0) {
        print(memberDataClass["data"]);
        list = memberDataClass["data"];
      } else {
        list = [];
      }
      return list;
      // } else {
      //   throw Exception(response.data.toString());
      // }
    } catch (e) {
      print("getMandiProducts Error ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  static Future<GetAllProductsDataClass> getProductDetails(body) async {
    String url = cnst.API_URL + 'api/admin/getCropPriceInAllMandi';
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

  static Future<List> getMandiWiseCrop(body) async {
    String url = cnst.API_URL + 'api/admin/getMandiWiseCrop';
    print("getMandiWiseCrop url : " + url);
    try {
      final response = await dio.post(url,data: body);
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
      print("getMandiWiseCrop Error ${e.toString()}");
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
