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

  class dropdownMandiClass {
  String Message;
  bool IsSuccess;
  int Count=0;
  List<dropdownclass> Data;

  dropdownMandiClass({this.IsSuccess,this.Message,this.Data,this.Count});

  factory dropdownMandiClass.fromJson(Map<String, dynamic > json) {
  return dropdownMandiClass(
  Message: json['Message'] as String,
  IsSuccess: json['IsSuccess'] as bool,
  Count: json["Count"] as int,
  Data: json['Data']
      .map<dropdownclass>((json) => dropdownclass.fromJson(json))
      .toList());
  }
  }

  class dropdownclass {
  String MandiName;

  dropdownclass({ this.MandiName});

  factory dropdownclass.fromJson(Map<String, dynamic> json) {
  return dropdownclass(
    MandiName: json["mandiData"]['MandiName'] as String,
  );
  }
  }
