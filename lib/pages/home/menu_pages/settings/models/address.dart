import 'package:safqa/pages/home/menu_pages/settings/models/Address_type.dart';
import 'package:safqa/pages/home/menu_pages/settings/models/area.dart';
import 'package:safqa/pages/home/menu_pages/settings/models/city.dart';

class Address {
  int? id;
  String? addressTypeId;
  String? cityId;
  String? areaId;
  String? block;
  String? avenue;
  String? street;
  String? bldgNo;
  String? appartment;
  String? floor;
  String? instructions;
  City? city;
  AddressType? addressType;
  Area? area;

  Address({
    this.addressTypeId,
    this.cityId,
    this.areaId,
    this.block,
    this.avenue,
    this.street,
    this.bldgNo,
    this.appartment,
    this.floor,
    this.instructions,
    this.id,
  });

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    addressTypeId = json['addressType_id'];
    cityId = json['city_id'];
    areaId = json['area_id'];
    block = json['block'];
    avenue = json['avenue'];
    street = json['street'];
    bldgNo = json['bldgNo'];
    appartment = json['appartment'];
    floor = json['floor'];
    instructions = json['instructions'];
    city = json['city'] != null
        ? new City.fromJson(json['city'])
        : City(nameAr: "لا يوجد مدينة", nameEn: "No City");
    addressType = json['address_type'] != null
        ? new AddressType.fromJson(json['address_type'])
        : AddressType(nameAr: "لا يوجد نوع", nameEn: "No Address Type");
    area = json['area'] != null
        ? Area.fromJson(json['area'])
        : Area(nameAr: "لا يوجد منطقة", nameEn: "No Area");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['addressType_id'] = addressTypeId;
    data['id'] = id;
    data['city_id'] = cityId;
    data['area_id'] = areaId;
    data['block'] = block;
    data['avenue'] = avenue;
    data['street'] = street;
    data['bldgNo'] = bldgNo;
    data['appartment'] = appartment;
    data['floor'] = floor;
    data['instructions'] = instructions;
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    if (this.addressType != null) {
      data['address_type'] = this.addressType!.toJson();
    }
    if (this.area != null) {
      data['area'] = this.area!.toJson();
    }
    return data;
  }
}
