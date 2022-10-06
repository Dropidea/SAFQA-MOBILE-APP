import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:pinput/pinput.dart';
import 'package:safqa/widgets/my_button.dart';
import 'package:safqa/widgets/my_stepper.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import 'package:safqa/widgets/zero_app_bar.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/signup_controller.dart';
import '../../main.dart';
import 'signup_done.dart';

class CompleteSignUpPage extends StatefulWidget {
  CompleteSignUpPage({super.key});

  @override
  State<CompleteSignUpPage> createState() => _CompleteSignUpPageState();
}

class _CompleteSignUpPageState extends State<CompleteSignUpPage> {
  SignUpController _signUpController = Get.find();
  PageController _pageController = PageController();
  final formKey = GlobalKey<FormState>();

  bool _agreeFlag = false;
  final defaultPinTheme = PinTheme(
    fieldWidth: 18,
    fieldHeight: 18,
    borderWidth: 2,
    fieldOuterPadding: EdgeInsets.symmetric(horizontal: 1),
    activeColor: Color(0xffBBBBBB),
    disabledColor: Color(0xffBBBBBB),
    errorBorderColor: Colors.red,
    inactiveColor: Color(0xffBBBBBB),
    selectedColor: Color(0xffBBBBBB),
  );

  void toggleAgree() {
    _agreeFlag = !_agreeFlag;
    setState(() {});
  }

  int _currentStep = 0;
  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() {
    _currentStep < stepList().length - 1
        ? setState(() => _currentStep += 1)
        : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: ZeroAppBar(),
        body: ListView(primary: false, children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/welcome_background.png"),
                fit: BoxFit.cover,
              ),
            ),
            width: w,
            height: h < 600 ? 650 : h,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20, top: 5, bottom: 20),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 22.0.sp,
                        ),
                        onPressed: () {
                          if (_currentStep == 0)
                            Get.back();
                          else
                            cancel();
                        },
                      ),
                    )
                  ],
                ),
                Expanded(
                    child: Container(
                  width: w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: Text(
                              "SignUp",
                              style: TextStyle(
                                  color: Color(0xff2F6782),
                                  fontSize: 20.0.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Theme(
                            data: Theme.of(context),
                            child: Form(
                              key: formKey,
                              child: MyStepper(
                                type: MyStepperType.horizontal,
                                onStepContinue: continued,
                                elevation: 0,
                                onStepCancel: cancel,
                                onStepTapped: tapped,
                                currentStep: _currentStep,
                                steps: stepList(),
                                physics: NeverScrollableScrollPhysics(),
                                controlsBuilder: (context, details) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      _currentStep == 3
                                          ? GestureDetector(
                                              onTap: () {
                                                Get.dialog(
                                                  AlertDialog(
                                                    titlePadding:
                                                        EdgeInsets.all(0),
                                                    actionsAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    actions: [
                                                      MyButton(
                                                          width: 0.5 * w,
                                                          heigt: 35.0.sp,
                                                          color:
                                                              Color(0xff2D5571),
                                                          borderRadius: 20,
                                                          text: "Send",
                                                          func: () async {
                                                            formKey
                                                                .currentState!
                                                                .validate();
                                                            var res = await _signUpController
                                                                .register(
                                                                    _signUpController
                                                                        .dataToRegister);

                                                            if (res == null)
                                                              Get.to(() =>
                                                                  SignUpDonePage());
                                                            else {
                                                              if (res.containsKey("email") ||
                                                                  res.containsKey(
                                                                      "phone_number_manager") ||
                                                                  res.containsKey(
                                                                      "full_name") ||
                                                                  res.containsKey(
                                                                      "password") ||
                                                                  res.containsKey(
                                                                      "password_confirmation"))
                                                                _currentStep =
                                                                    2;
                                                              else if (res
                                                                      .containsKey(
                                                                          "phone_number") ||
                                                                  res.containsKey(
                                                                      "company_name") ||
                                                                  res.containsKey(
                                                                      "name_en") ||
                                                                  res.containsKey(
                                                                      "name_ar") ||
                                                                  res.containsKey(
                                                                      "category_id") ||
                                                                  res.containsKey(
                                                                      "work_email"))
                                                                _currentStep =
                                                                    0;
                                                              else
                                                                _currentStep =
                                                                    1;
                                                              setState(() {});
                                                              formKey
                                                                  .currentState!
                                                                  .validate();
                                                            }
                                                          },
                                                          textSize: 15.0.sp)
                                                    ],
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(32.0),
                                                      ),
                                                    ),
                                                    title: _dialogeTitle(),
                                                    content: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          padding:
                                                              EdgeInsets.all(5),
                                                          decoration:
                                                              BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .all(
                                                                    Radius
                                                                        .circular(
                                                                            15),
                                                                  ),
                                                                  border: Border
                                                                      .all(
                                                                    color: Color(
                                                                        0xffBBBBBB),
                                                                  )),
                                                          height: 50,
                                                          width: 0.35 * w,
                                                          child:
                                                              PinCodeTextField(
                                                                  validator:
                                                                      (s) {
                                                                    if (s!.length <
                                                                        6)
                                                                      return null;
                                                                    return s ==
                                                                            '222222'
                                                                        ? null
                                                                        : 'Pin is incorrect';
                                                                  },
                                                                  pinTheme:
                                                                      defaultPinTheme,
                                                                  appContext:
                                                                      context,
                                                                  length: 6,
                                                                  onChanged:
                                                                      (val) {}),
                                                        ),
                                                        MyButton(
                                                          width: 0.30 * w,
                                                          heigt: 35.0.sp,
                                                          color:
                                                              Color(0xff2D5571),
                                                          borderRadius: 15,
                                                          text: "resend (40)",
                                                          textSize: 13.0.sp,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                margin:
                                                    EdgeInsets.only(top: 20),
                                                width: 0.7 * w,
                                                height: 42.0.sp,
                                                decoration: BoxDecoration(
                                                  color: Color(0xff00A7B3),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "Send OTP",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18.0.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          : GestureDetector(
                                              onTap: continued,
                                              child: Container(
                                                margin:
                                                    EdgeInsets.only(top: 20),
                                                width: 0.7 * w,
                                                height: 40.0.sp,
                                                decoration: BoxDecoration(
                                                  color: Color(0xff2F6782),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "Next",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18.0.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                    ],
                                  );
                                },
                              ),
                            )
                            //  MyStepper(
                            //   elevation: 0,
                            //   controlsBuilder: (context, details) {
                            //     return Row(
                            //       children: <Widget>[
                            //         TextButton(
                            //           onPressed: () {},
                            //           child: const Text('NEXT'),
                            //         ),
                            //       ],
                            //     );
                            //   },
                            //   type: MyStepperType.horizontal,
                            //   physics: const ScrollPhysics(),
                            //   currentStep: _currentStep,
                            //   onStepTapped: (step) => tapped(step),
                            //   onStepContinue: continued,
                            //   onStepCancel: cancel,
                            //   steps: [
                            //     MyStep(
                            //       title: new Text(''),
                            //       label: _currentStep == 0
                            //           ? new Text('Account')
                            //           : Text(""),
                            //       content: Column(
                            //         children: <Widget>[
                            //           TextFormField(
                            //             decoration: InputDecoration(
                            //                 labelText: 'Email Address'),
                            //           ),
                            //           TextFormField(
                            //             decoration: InputDecoration(
                            //                 labelText: 'Password'),
                            //           ),
                            //         ],
                            //       ),
                            //       isActive: _currentStep >= 0,
                            //       state: _currentStep >= 0
                            //           ? MyStepState.complete
                            //           : MyStepState.disabled,
                            //     ),
                            //     MyStep(
                            //       title: new Text(''),
                            //       label: _currentStep == 1
                            //           ? new Text('Address')
                            //           : Text(""),
                            //       content: Column(
                            //         children: <Widget>[
                            //           TextFormField(
                            //             decoration: InputDecoration(
                            //                 labelText: 'Home Address'),
                            //           ),
                            //           TextFormField(
                            //             decoration: InputDecoration(
                            //                 labelText: 'Postcode'),
                            //           ),
                            //         ],
                            //       ),
                            //       isActive: _currentStep >= 1,
                            //       state: _currentStep >= 1
                            //           ? MyStepState.complete
                            //           : MyStepState.disabled,
                            //     ),
                            //     MyStep(
                            //       title: new Text(''),
                            //       label: _currentStep == 2
                            //           ? new Text('Mobile Number')
                            //           : Text(""),
                            //       content: Column(
                            //         children: <Widget>[
                            //           TextFormField(
                            //             decoration: InputDecoration(
                            //                 labelText: 'Mobile Number'),
                            //           ),
                            //         ],
                            //       ),
                            //       isActive: _currentStep >= 2,
                            //       state: _currentStep >= 2
                            //           ? MyStepState.complete
                            //           : MyStepState.disabled,
                            //     ),
                            //     MyStep(
                            //       title: new Text(''),
                            //       label: _currentStep == 3
                            //           ? new Text('test')
                            //           : Text(""),
                            //       content: Column(
                            //         children: <Widget>[
                            //           TextFormField(
                            //             decoration: InputDecoration(
                            //                 labelText: 'Mobile Number'),
                            //           ),
                            //         ],
                            //       ),
                            //       isActive: _currentStep >= 3,
                            //       state: _currentStep >= 3
                            //           ? MyStepState.complete
                            //           : MyStepState.disabled,
                            //     ),
                            //   ],
                            // ),

                            ),
                      )
                    ],
                  ),
                ))
              ],
            ),
          ),
        ]));
  }

  Widget _dialogeTitle() {
    return Stack(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 25.0, left: 10, right: 25, bottom: 25),
          child: RichText(
            softWrap: true,
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: 'Enter the verification code sent to your phone ( ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0.sp,
                  ),
                ),
                TextSpan(
                  text: '+20108443369 ',
                  style: TextStyle(
                    color: Color(0xff76ABC2),
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0.sp,
                  ),
                ),
                TextSpan(
                  text: ')',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 10,
          top: 10,
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.close,
              color: Color.fromARGB(255, 0, 0, 0),
              size: 20,
            ),
          ),
        )
      ],
    );
  }

  List<MyStep> stepList() => [
        MyStep(
            label: myLabel(0, 'Company information'),
            content: SizedBox(
              height: 50.0.h,
              child: ListView(
                primary: false,
                children: [
                  SignUpTextField(
                    hintText: "Legal Company Name",
                    onchanged: (s) {
                      _signUpController.dataToRegister['company_name'] = s!;
                    },
                    validator: (s) {
                      if (_signUpController.errors == null)
                        return null;
                      else if (_signUpController.errors
                          .containsKey('company_name')) {
                        return _signUpController.errors['company_name'][0]
                            .toString();
                      } else
                        return null;
                    },
                  ),
                  SignUpTextField(
                    hintText: "Company Brand Name (EN)",
                    onchanged: (s) {
                      _signUpController.dataToRegister['name_en'] = s!;
                    },
                    validator: (s) {
                      if (_signUpController.errors == null)
                        return null;
                      else if (_signUpController.errors
                          .containsKey('name_en')) {
                        return _signUpController.errors['name_en'][0]
                            .toString();
                      } else
                        return null;
                    },
                  ),
                  SignUpTextField(
                    hintText: "Company Brand Name (AR)",
                    onchanged: (s) {
                      _signUpController.dataToRegister['name_ar'] = s!;
                    },
                    validator: (s) {
                      if (_signUpController.errors == null)
                        return null;
                      else if (_signUpController.errors
                          .containsKey('name_ar')) {
                        return _signUpController.errors['name_ar'][0]
                            .toString();
                      } else
                        return null;
                    },
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                    child: Obx(() {
                      List countries = _signUpController.globalData['country'];
                      List<String> ids = countries
                          .map<String>(
                            (e) => e['id'].toString(),
                          )
                          .toList();
                      List<String> countriesCodes = countries
                          .map<String>(
                            (e) => e['code'].toString(),
                          )
                          .toList();
                      _signUpController
                          .selectPhoneNumberCodeDrop(countriesCodes[4]);
                      return SignUpTextField(
                        keyBoardType: TextInputType.number,
                        prefixIcon: SizedBox(
                          width: 60,
                          child: DropdownButtonFormField<String>(
                            isExpanded: true,
                            items: countriesCodes
                                .map((e) => DropdownMenuItem<String>(
                                      child: Text(e),
                                      value: e,
                                    ))
                                .toList(),
                            value:
                                _signUpController.selectedPhoneNumberCodeDrop,
                            onChanged: (value) {
                              _signUpController
                                  .selectPhoneNumberCodeDrop(value!);
                              logError(_signUpController
                                  .selectedPhoneNumberCodeDrop);
                              _signUpController
                                      .dataToRegister['phone_number_code_id'] =
                                  ids[countriesCodes.indexOf(_signUpController
                                      .selectedPhoneNumberCodeDrop)];
                            },
                          ),
                        ),
                        hintText: 'Company Phone Number',
                        validator: (s) {
                          if (_signUpController.errors == null)
                            return null;
                          else if (_signUpController.errors
                              .containsKey('phone_number')) {
                            return _signUpController.errors['phone_number'][0]
                                .toString();
                          } else
                            return null;
                        },
                        onchanged: (s) {
                          _signUpController.dataToRegister['phone_number'] = s!;
                        },
                      );
                    }),
                  ),
                  SignUpTextField(
                    hintText: "Company Email",
                    keyBoardType: TextInputType.emailAddress,
                    onchanged: (s) {
                      _signUpController.dataToRegister['work_email'] = s!;
                    },
                    validator: (s) {
                      if (_signUpController.errors == null)
                        return null;
                      else if (_signUpController.errors
                          .containsKey('work_email')) {
                        return _signUpController.errors['work_email'][0]
                            .toString();
                      } else
                        return null;
                    },
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                    child: Obx(
                      () {
                        List categories =
                            _signUpController.globalData['category'];
                        List<String> ids = categories
                            .map<String>((e) => e['id'].toString())
                            .toList();
                        List<String> categoryNames = categories
                            .map<String>((e) => e['name'].toString())
                            .toList();

                        return DropdownButtonFormField<String>(
                          decoration: InputDecoration(border: InputBorder.none),
                          items: categoryNames
                              .map((e) => DropdownMenuItem<String>(
                                    child: Text(e),
                                    value: e,
                                  ))
                              .toList(),
                          value: _signUpController.selectedCategoryDrop == ""
                              ? null
                              : _signUpController.selectedCategoryDrop,
                          hint: Text("Categories"),
                          onChanged: (value) {
                            _signUpController.selectCategoryDrop(value!);

                            _signUpController.dataToRegister['category_id'] =
                                ids[categoryNames.indexOf(value)];
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            isActive: _currentStep >= 0,
            state: _currentStep >= 0
                ? MyStepState.complete
                : MyStepState.disabled),
        MyStep(
            label: myLabel(1, 'Bank Account Details'),
            content: SizedBox(
              height: 50.0.h,
              child: ListView(
                primary: false,
                children: [
                  SignUpTextField(
                    hintText: "Bank Account Name",
                    onchanged: (s) => _signUpController
                        .dataToRegister['bank_account_ame'] = s!,
                    validator: (s) {
                      if (_signUpController.errors == null)
                        return null;
                      else if (_signUpController.errors
                          .containsKey('bank_account_ame')) {
                        return _signUpController.errors['bank_account_ame'][0]
                            .toString();
                      } else
                        return null;
                    },
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                    child: Obx(() {
                      List banks = _signUpController.globalData['banks'];
                      List<String> ids = banks
                          .map<String>(
                            (e) => e['id'].toString(),
                          )
                          .toList();
                      List<String> banksNames = banks
                          .map<String>(
                            (e) => e['name'].toString(),
                          )
                          .toList();
                      return DropdownButtonFormField<String>(
                        decoration: InputDecoration(border: InputBorder.none),
                        items: banksNames
                            .map((e) => DropdownMenuItem<String>(
                                  child: Text(e),
                                  value: e,
                                ))
                            .toList(),
                        value: _signUpController.selectedBankDrop == ""
                            ? null
                            : _signUpController.selectedBankDrop,
                        hint: Text("Banks"),
                        onChanged: (value) {
                          _signUpController.selectBankDrop(value!);

                          _signUpController.dataToRegister['bank_name'] = value;
                        },
                        validator: (s) {
                          if (_signUpController.errors == null)
                            return null;
                          else if (_signUpController.errors
                              .containsKey('bank_name')) {
                            return _signUpController.errors['bank_name'][0]
                                .toString();
                          } else
                            return null;
                        },
                      );
                    }),
                  ),
                  SignUpTextField(
                    hintText: "Account Number",
                    keyBoardType: TextInputType.number,
                    onchanged: (s) =>
                        _signUpController.dataToRegister['account_number'] = s!,
                    validator: (s) {
                      if (_signUpController.errors == null)
                        return null;
                      else if (_signUpController.errors
                          .containsKey('account_number')) {
                        return _signUpController.errors['account_number'][0]
                            .toString();
                      } else
                        return null;
                    },
                  ),
                  SignUpTextField(
                    hintText: "IBAN",
                    keyBoardType: TextInputType.number,
                    onchanged: (s) =>
                        _signUpController.dataToRegister['iban'] = s!,
                    validator: (s) {
                      if (_signUpController.errors == null)
                        return null;
                      else if (_signUpController.errors.containsKey('iban')) {
                        return _signUpController.errors['iban'][0].toString();
                      } else
                        return null;
                    },
                  ),
                ],
              ),
            ),
            isActive: _currentStep >= 1,
            state: _currentStep >= 1
                ? MyStepState.complete
                : MyStepState.disabled),
        MyStep(
            label: myLabel(2, 'Company Manager User Login Information'),
            content: SizedBox(
              height: 50.0.h,
              child: ListView(
                primary: false,
                children: [
                  SignUpTextField(
                    hintText: "Manager Full Name",
                    onchanged: (s) =>
                        _signUpController.dataToRegister['full_name'] = s!,
                    validator: (s) {
                      if (_signUpController.errors == null)
                        return null;
                      else if (_signUpController.errors
                          .containsKey('full_name')) {
                        return _signUpController.errors['full_name'][0]
                            .toString();
                      } else
                        return null;
                    },
                  ),
                  SignUpTextField(
                    hintText: "Email",
                    keyBoardType: TextInputType.emailAddress,
                    onchanged: (s) =>
                        _signUpController.dataToRegister['email'] = s!,
                    validator: (s) {
                      if (!EmailValidator.validate(s!))
                        return "please_enter_a_valid_email".tr;
                      else if (_signUpController.errors == null)
                        return null;
                      else if (_signUpController.errors.containsKey('email')) {
                        return _signUpController.errors['email'][0].toString();
                      } else
                        return null;
                    },
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                      child: Obx(() {
                        List countries =
                            _signUpController.globalData['country'];
                        List<String> ids = countries
                            .map<String>(
                              (e) => e['id'].toString(),
                            )
                            .toList();
                        List<String> countriesCodes = countries
                            .map<String>(
                              (e) => e['code'].toString(),
                            )
                            .toList();
                        _signUpController.selectPhoneNumberManagerCodeDrop(
                            countriesCodes[4]);
                        return SignUpTextField(
                          keyBoardType: TextInputType.number,
                          prefixIcon: SizedBox(
                            width: 60,
                            child: DropdownButtonFormField<String>(
                              isExpanded: true,
                              items: countriesCodes
                                  .map((e) => DropdownMenuItem<String>(
                                        child: Text(e),
                                        value: e,
                                      ))
                                  .toList(),
                              value: _signUpController
                                  .selectedPhoneNumberManagerCodeDrop,
                              onChanged: (value) {
                                _signUpController
                                    .selectPhoneNumberManagerCodeDrop(value!);
                                logError(_signUpController
                                    .selectedPhoneNumberManagerCodeDrop);
                                _signUpController.dataToRegister[
                                        'phone_number_code_manager_id'] =
                                    ids[countriesCodes.indexOf(_signUpController
                                        .selectedPhoneNumberManagerCodeDrop)];
                              },
                            ),
                          ),
                          onchanged: (s) {
                            _signUpController
                                .dataToRegister['phone_number_manager'] = s!;
                          },
                          validator: (s) {
                            if (_signUpController.errors == null) return null;
                            return _signUpController.errors
                                    .containsKey("phone_number_manager")
                                ? _signUpController
                                    .errors['phone_number_manager'][0]
                                    .toString()
                                : null;
                          },
                          hintText: 'Manager Mobile Number',
                        );
                      }),
                    ),
                  ),
                  SignUpTextField(
                    hintText: "Password",
                    obsecureText: true,
                    onchanged: (s) =>
                        _signUpController.dataToRegister['password'] = s!,
                    validator: (s) {
                      return _signUpController.errors.containsKey("password")
                          ? _signUpController.errors['password'][0]
                          : null;
                    },
                  ),
                  SignUpTextField(
                    hintText: "Confirm Password",
                    obsecureText: true,
                    validator: (s) {
                      return _signUpController.errors
                              .containsKey("password_confirmation")
                          ? _signUpController.errors['password_confirmation'][0]
                          : null;
                    },
                    onchanged: (s) => _signUpController
                        .dataToRegister['password_confirmation'] = s!,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                    child: Obx(() {
                      List countries = _signUpController.globalData['country'];
                      List<String> ids = countries
                          .map<String>(
                            (e) => e['id'].toString(),
                          )
                          .toList();
                      List<String> countriesNames = countries
                          .map<String>(
                            (e) => e['name_en'].toString(),
                          )
                          .toList();
                      return DropdownButtonFormField<String>(
                        decoration: InputDecoration(border: InputBorder.none),
                        items: countriesNames
                            .map((e) => DropdownMenuItem<String>(
                                  child: Text(e),
                                  value: e,
                                ))
                            .toList(),
                        value: _signUpController.selectedNationalityDrop == ""
                            ? null
                            : _signUpController.selectedNationalityDrop,
                        hint: Text("Nationality"),
                        onChanged: (value) {
                          _signUpController.selectNationalityDrop(value!);

                          _signUpController.dataToRegister['nationality_id'] =
                              ids[countriesNames.indexOf(value)];
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
            isActive: _currentStep >= 2,
            state: _currentStep >= 2
                ? MyStepState.complete
                : MyStepState.disabled),
        MyStep(
            label: myLabel(3, 'Send OPT'),
            content: SizedBox(
              height: 50.0.h,
              child: ListView(
                primary: false,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 15.0.sp),
                    child: Text(
                      "We've almost done!",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0.sp),
                    ),
                  ),
                  SignUpTextField(
                    hintText: "00201084433369",
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 25,
                          height: 30,
                          child: Checkbox(
                            activeColor: Color(0xff00A7B3),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                            ), // Rounded Checkbox
                            onChanged: (value) {
                              _agreeFlag = value!;
                              setState(() {});
                            },
                            value: _agreeFlag,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: RichText(
                            softWrap: true,
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text:
                                      'By clicking on send OPT button, you agree that you are not acting as a fundraiser, Your activities are in compliance with the rules and regulations of your country and I agree to receive promotional content and special offers via email .You can unsubscribe anytime.You agree to ',
                                  style: TextStyle(
                                    color: Color(0xff858585),
                                    fontSize: 12.0.sp,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Terms of Use',
                                  style: TextStyle(
                                    color: Color(0xff00A7B3),
                                    decoration: TextDecoration.underline,
                                    fontSize: 12.0.sp,
                                  ),
                                ),
                                TextSpan(
                                  text: ' and ',
                                  style: TextStyle(
                                    color: Color(0xff858585),
                                    fontSize: 12.0.sp,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Privacy Policy.',
                                  style: TextStyle(
                                    color: Color(0xff00A7B3),
                                    decoration: TextDecoration.underline,
                                    fontSize: 12.0.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            isActive: _currentStep >= 3,
            state: _currentStep >= 3
                ? MyStepState.complete
                : MyStepState.disabled),
      ];

  Widget myLabel(int currenetStep, String text) => currenetStep == _currentStep
      ? SizedBox(
          width: 100,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: text.split(" ").length >= 3 ? 10.sp : 12.0.sp),
            softWrap: true,
          ),
        )
      : Text('');
}
