import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/controllers/global_data_controller.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/menu_pages/settings/controllers/addresses_controller.dart';
import 'package:safqa/pages/home/menu_pages/settings/models/address.dart';
import 'package:safqa/pages/home/profile/pr_bank_details.dart';
import 'package:safqa/widgets/circular_go_btn.dart';
import 'package:safqa/widgets/custom_drop_down.dart';
import 'package:safqa/widgets/signup_text_field.dart';

class AddAddressPage extends StatefulWidget {
  AddAddressPage({super.key, this.addressToEdit});
  final Address? addressToEdit;
  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  Address addressToCreate = Address();
  ScrollController _scrollController = new ScrollController();

  GlobalDataController globalDataController = Get.find();
  AddressesController addressesController = Get.find();

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.addressToEdit != null) {
      globalDataController.getCityAreas(widget.addressToEdit!.city!.id!);
      widget.addressToEdit!.cityId = widget.addressToEdit!.city!.id!.toString();
      widget.addressToEdit!.addressTypeId =
          widget.addressToEdit!.addressType!.id!.toString();
      widget.addressToEdit!.areaId = widget.addressToEdit!.area!.id!.toString();
    } else {
      globalDataController.getCityAreas(-1);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: MyAppBar(
          title:
              widget.addressToEdit != null ? "Edit address" : "Create Address"),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          controller: _scrollController,
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              blackText("Address Type", 15),
              CustomDropdownV2(
                width: w,
                items: globalDataController.addressTypes
                    .map((e) => e.nameEn!)
                    .toList(),
                selectedItem: widget.addressToEdit != null
                    ? widget.addressToEdit!.addressType!.nameEn
                    : null,
                onchanged: (s) {
                  if (widget.addressToEdit != null) {
                    widget.addressToEdit!.addressTypeId = globalDataController
                        .addressTypes[globalDataController.addressTypes
                            .indexWhere((element) => element.nameEn == s)]
                        .id!
                        .toString();
                    widget.addressToEdit!.addressType =
                        globalDataController.addressTypes[globalDataController
                            .addressTypes
                            .indexWhere((element) => element.nameEn == s)];
                  } else {
                    addressToCreate.addressTypeId = globalDataController
                        .addressTypes[globalDataController.addressTypes
                            .indexWhere((element) => element.nameEn == s)]
                        .id!
                        .toString();
                  }
                },
                hint: "choose",
                validator: (p0) {
                  if (p0 == null || p0.isEmpty) {
                    return "required";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              blackText("City", 15),
              CustomDropdownV2(
                width: w,
                items: globalDataController.cities
                    .where((element) =>
                        element.countryId ==
                        globalDataController.me.profileBusines!.countryId)
                    .map((e) => e.nameEn!)
                    .toList(),
                selectedItem: widget.addressToEdit != null
                    ? widget.addressToEdit!.city!.nameEn
                    : null,
                validator: (p0) {
                  if (p0 == null || p0.isEmpty) {
                    return "required";
                  }
                  return null;
                },
                onchanged: (s) {
                  int id = globalDataController
                      .cities[globalDataController.cities
                          .indexWhere((element) => element.nameEn == s)]
                      .id!;
                  globalDataController.getCityAreas(id);

                  if (widget.addressToEdit != null) {
                    widget.addressToEdit!.city = globalDataController.cities[
                        globalDataController.cities
                            .indexWhere((element) => element.nameEn == s)];
                    widget.addressToEdit!.cityId = id.toString();
                    widget.addressToEdit!.area =
                        globalDataController.areastoshow[0];
                    widget.addressToEdit!.areaId =
                        globalDataController.areastoshow[0].id.toString();
                  } else {
                    addressToCreate.cityId = id.toString();
                    addressToCreate.areaId =
                        globalDataController.areastoshow.isEmpty
                            ? null
                            : globalDataController.areastoshow[0].id.toString();
                  }
                },
                hint: "choose",
              ),
              SizedBox(height: 20),
              blackText("Area", 15),
              GetBuilder<GlobalDataController>(builder: (c) {
                return CustomDropdownV2(
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return "required";
                    }
                    return null;
                  },
                  width: w,
                  items: c.areastoshow.map((e) => e.nameEn!).toList(),
                  onchanged: (s) {
                    if (widget.addressToEdit != null) {
                      widget.addressToEdit!.area =
                          globalDataController.areastoshow[globalDataController
                              .areastoshow
                              .indexWhere((element) => element.nameEn == s)];
                      widget.addressToEdit!.areaId = globalDataController
                          .areastoshow[globalDataController.areastoshow
                              .indexWhere((element) => element.nameEn == s)]
                          .id
                          .toString();
                    } else {
                      addressToCreate.areaId = globalDataController
                          .areastoshow[globalDataController.areastoshow
                              .indexWhere((element) => element.nameEn == s)]
                          .id
                          .toString();
                    }
                  },
                  selectedItem: widget.addressToEdit != null
                      ? widget.addressToEdit!.area!.nameEn
                      : c.areastoshow.isEmpty
                          ? null
                          : c.areastoshow[0].nameEn,
                  hint: "choose",
                );
              }),
              SizedBox(height: 20),
              blackText("block", 15),
              SignUpTextField(
                padding: EdgeInsets.all(0),
                onchanged: (s) {
                  if (widget.addressToEdit != null) {
                    widget.addressToEdit!.block = s;
                  } else {
                    addressToCreate.block = s;
                  }
                },
                initialValue: widget.addressToEdit != null
                    ? widget.addressToEdit!.block
                    : null,
                validator: (p0) {
                  if (p0!.isEmpty) {
                    return "required";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              blackText("Avenue", 15),
              SignUpTextField(
                padding: EdgeInsets.all(0),
                onchanged: (s) {
                  if (widget.addressToEdit != null) {
                    widget.addressToEdit!.avenue = s;
                  } else {
                    addressToCreate.avenue = s;
                  }
                },
                initialValue: widget.addressToEdit != null
                    ? widget.addressToEdit!.avenue
                    : null,
                validator: (p0) {
                  if (p0!.isEmpty) {
                    return "required";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              blackText("Street", 15),
              SignUpTextField(
                padding: EdgeInsets.all(0),
                onchanged: (s) {
                  if (widget.addressToEdit != null) {
                    widget.addressToEdit!.street = s;
                  } else {
                    addressToCreate.street = s;
                  }
                },
                initialValue: widget.addressToEdit != null
                    ? widget.addressToEdit!.street
                    : null,
                validator: (p0) {
                  if (p0!.isEmpty) {
                    return "required";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  blackText("House/Bldg No.", 15),
                  SizedBox(width: 10),
                  greyText("(Optional)", 13)
                ],
              ),
              SignUpTextField(
                padding: EdgeInsets.all(0),
                onchanged: (s) {
                  if (widget.addressToEdit != null) {
                    widget.addressToEdit!.bldgNo = s;
                  } else {
                    addressToCreate.bldgNo = s;
                  }
                },
                initialValue: widget.addressToEdit != null
                    ? widget.addressToEdit!.bldgNo
                    : null,
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  blackText("Appartment", 15),
                  SizedBox(width: 10),
                  greyText("(Optional)", 13)
                ],
              ),
              SignUpTextField(
                padding: EdgeInsets.all(0),
                onchanged: (s) {
                  if (widget.addressToEdit != null) {
                    widget.addressToEdit!.appartment = s;
                  } else {
                    addressToCreate.appartment = s;
                  }
                },
                initialValue: widget.addressToEdit != null
                    ? widget.addressToEdit!.appartment
                    : null,
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  blackText("Floor", 15),
                  SizedBox(width: 10),
                  greyText("(Optional)", 13)
                ],
              ),
              SignUpTextField(
                padding: EdgeInsets.all(0),
                onchanged: (s) {
                  if (widget.addressToEdit != null) {
                    widget.addressToEdit!.floor = s;
                  } else {
                    addressToCreate.floor = s;
                  }
                },
                initialValue: widget.addressToEdit != null
                    ? widget.addressToEdit!.floor
                    : null,
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  blackText("Instructions", 15),
                  SizedBox(width: 10),
                  greyText("(Optional)", 13)
                ],
              ),
              SignUpTextField(
                padding: EdgeInsets.all(0),
                onchanged: (s) {
                  if (widget.addressToEdit != null) {
                    widget.addressToEdit!.instructions = s;
                  } else {
                    addressToCreate.instructions = s;
                  }
                },
                initialValue: widget.addressToEdit != null
                    ? widget.addressToEdit!.instructions
                    : null,
              ),
              SizedBox(height: 50),
              CircularGoBTN(
                text: widget.addressToEdit != null ? "Edit" : "Create",
                onTap: () async {
                  FocusScope.of(context).unfocus();
                  if (formKey.currentState!.validate()) {
                    if (widget.addressToEdit != null) {
                      await addressesController
                          .editAddress(widget.addressToEdit!);
                    } else {
                      await addressesController.createAddress(addressToCreate);
                    }
                  } else {
                    _scrollController.jumpTo(0);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
