import 'dart:collection';

class RegisterDataClass {
  bool IsSuccess;
  LinkedHashMap<String, dynamic> Data;
  String Message;

  RegisterDataClass({this.IsSuccess, this.Data, this.Message});

  factory RegisterDataClass.fromJson(Map<String, String> json) {
    return RegisterDataClass(
      IsSuccess: json['IsSuccess'] as bool,
      Data: json['Data'] as LinkedHashMap,
      Message: json['Message'] as String,
    );
  }
}

class GetAllProductsDataClass {
  String Message;
  bool IsSuccess;
  List<dynamic> Data;

  GetAllProductsDataClass({
    this.Message,
    this.IsSuccess,
    this.Data,
  });

  factory GetAllProductsDataClass.fromJson(Map<String, dynamic> json) {
    return GetAllProductsDataClass(
        Message: json['Message'] as String,
        IsSuccess: json['IsSuccess'] as bool,
        Data: json['Data']
            .map<GetAllProductsClass>(
                (json) => GetAllProductsClass.fromJson(json))
            .toList());
  }
}

class GetAllProductsClass {
  String productName, productImage, id;
  int yesterDayPrice, toDayPrice, priceChangeIndicator;

  GetAllProductsClass({
    this.productName,
    this.productImage,
    this.yesterDayPrice,
    this.toDayPrice,
    this.priceChangeIndicator,
    this.id,
  });

  factory GetAllProductsClass.fromJson(Map<String, dynamic> json) {
    return GetAllProductsClass(
      productName: json['productName'] as String,
      productImage: json['productImage'] as String,
      yesterDayPrice: json['yesterDayPrice'] as int,
      toDayPrice: json['toDayPrice'] as int,
      priceChangeIndicator: json['priceChangeIndicator'] as int,
      id: json['_id'] as String,
    );
  }
}
