import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:safqa/admin/pages/banks/controller/bank_controller.dart';
import 'package:safqa/controllers/global_data_controller.dart';
import 'package:safqa/controllers/locals_controller.dart';
import 'package:safqa/main.dart';
import 'package:safqa/models/bank_model.dart';
import 'package:safqa/pages/log-reg/signup_done.dart';
import 'package:safqa/widgets/my_button.dart';
import 'package:safqa/widgets/my_stepper.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import 'package:safqa/widgets/zero_app_bar.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/signup_controller.dart';

class CompleteSignUpPage extends StatefulWidget {
  CompleteSignUpPage({super.key});

  @override
  State<CompleteSignUpPage> createState() => _CompleteSignUpPageState();
}

class _CompleteSignUpPageState extends State<CompleteSignUpPage> {
  SignUpController _signUpController = Get.find();
  GlobalDataController _globalDataController = Get.find();
  BankController _bankController = Get.put(BankController());

  PageController _pageController = PageController();
  LocalsController _localsController = Get.find();
  TextEditingController pw = TextEditingController();
  TextEditingController cpw = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool _agreeFlag = false;
  String mobileCode = "";
  TextEditingController phoneController = TextEditingController();
  final defaultPinTheme = PinTheme(
    fieldWidth: 18,
    fieldHeight: 18,
    borderWidth: 2,
    fieldOuterPadding: EdgeInsets.symmetric(horizontal: 1),
    activeColor: Color(0xffBBBBBB),
    disabledColor: Color(0xffBBBBBB),
    shape: PinCodeFieldShape.box,
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
    _currentStep < stepList(0, 0, _localsController.currenetLocale).length - 1
        ? setState(() => _currentStep += 1)
        : null;
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }

  @override
  void initState() {
    _bankController.getAllBanks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: ZeroAppBar(),
        body: ListView(
          primary: false,
          // primary: false,
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/welcome_background.png"),
                  fit: BoxFit.cover,
                ),
              ),
              // width: w,
              height: h < 600 ? h + 20 : h - 24,
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
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Theme(
                        data: Theme.of(context),
                        child: Form(
                          autovalidateMode: AutovalidateMode.always,
                          key: formKey,
                          child: MyStepper(
                            type: MyStepperType.horizontal,
                            onStepContinue: continued,
                            elevation: 0,
                            onStepCancel: cancel,
                            onStepTapped: tapped,
                            currentStep: _currentStep,
                            steps: stepList(
                                h, w, _localsController.currenetLocale),
                            physics: NeverScrollableScrollPhysics(),
                            controlsBuilder: (context, details) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  _currentStep == 3
                                      ? GestureDetector(
                                          onTap: () async {
                                            await FirebaseAuth.instance
                                                .verifyPhoneNumber(
                                              phoneNumber: '+963967542311',
                                              verificationCompleted:
                                                  (PhoneAuthCredential
                                                      credential) {},
                                              verificationFailed:
                                                  (FirebaseAuthException e) {},
                                              codeSent: (String verificationId,
                                                  int? resendToken) {
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
                                                        textColor: Colors.white,
                                                        borderRadius: 20,
                                                        text: "re_send".tr,
                                                        textSize: 15.0.sp,
                                                        func: () {},
                                                      )
                                                    ],
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(32.0),
                                                      ),
                                                    ),
                                                    title: _dialogeTitle(),
                                                    content: Container(
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          PinCodeTextField(
                                                              validator: (s) {
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
                                                              onCompleted:
                                                                  (value) async {
                                                                logSuccess(
                                                                    value);
                                                                FocusScope.of(
                                                                        context)
                                                                    .unfocus();

                                                                logSuccess(
                                                                    _signUpController
                                                                        .dataToRegister);
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
                                                                  setState(
                                                                      () {});
                                                                  formKey
                                                                      .currentState!
                                                                      .validate();
                                                                }
                                                              },
                                                              onChanged:
                                                                  (val) {}),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                              codeAutoRetrievalTimeout:
                                                  (String verificationId) {},
                                            );
                                          },
                                          child: Container(
                                            width: 0.7 * w,
                                            height: 42.0.sp,
                                            margin: EdgeInsets.only(top: 2.0.h),
                                            decoration: BoxDecoration(
                                              color: Color(0xff00A7B3),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Center(
                                              child: Text(
                                                _localsController
                                                            .currenetLocale ==
                                                        0
                                                    ? "Send OPT"
                                                    : "أرسل OPT",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18.0.sp,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : GestureDetector(
                                          onTap: continued,
                                          child: Container(
                                            width: 0.7 * w,
                                            height: 40.0.sp,
                                            margin: EdgeInsets.only(top: 5.h),
                                            decoration: BoxDecoration(
                                              color: Color(0xff2F6782),
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/images/btn_wallpaper.png"),
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "next".tr,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18.0.sp,
                                                  fontWeight: FontWeight.w500,
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
                  ))
                ],
              ),
            ),
          ],
        ));
  }

  Widget _dialogeTitle() {
    return Stack(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 35.0, left: 10, right: 25, bottom: 25),
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
                  text: mobileCode + " " + phoneController.text,
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

  List<MyStep> stepList(double h, double w, int lang) => [
        MyStep(
            label: myLabel(
                0, lang == 0 ? 'Company information' : "معلومات الشركة"),
            content: SizedBox(
              height: h < 600 ? 43.0.h : 50.0.h,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 10),
                primary: false,
                children: [
                  SignUpTextField(
                    hintText: lang == 0
                        ? "Legal Company Name"
                        : "اسم الشركة القانوني",
                    onchanged: (s) {
                      _signUpController.dataToRegister['company_name'] = s!;
                      _signUpController.errors = {};
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
                    hintText: lang == 0
                        ? "Company Brand Name (EN)"
                        : "اسم العلامة التجارية للشركة باللغة الإنجليزية",
                    onchanged: (s) {
                      _signUpController.dataToRegister['name_en'] = s!;
                      _signUpController.errors = {};
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
                    hintText: lang == 0
                        ? "Company Brand Name (AR)"
                        : "اسم العلامة التجارية للشركة باللغة العربية",
                    onchanged: (s) {
                      _signUpController.dataToRegister['name_ar'] = s!;
                      _signUpController.errors = {};
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
                  GetBuilder<GlobalDataController>(builder: (c) {
                    List<Country> countries = _globalDataController.countries
                        .where((element) => element.code == "+9")
                        .toList();

                    return SignUpTextField(
                      keyBoardType: TextInputType.number,
                      prefixIcon: SizedBox(
                        width: 60,
                        child: DropdownButtonFormField<String>(
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                          isExpanded: true,
                          items: countries
                              .map((e) => DropdownMenuItem<String>(
                                    child: Center(child: Text(e.code!)),
                                    value: e.code,
                                  ))
                              .toList(),
                          value: countries[0].code,
                          onChanged: (value) {
                            _signUpController
                                    .dataToRegister['phone_number_code_id'] =
                                countries
                                    .where((element) => element.code == value)
                                    .first
                                    .id!;
                            _signUpController.errors = {};
                          },
                        ),
                      ),
                      hintText: lang == 0
                          ? 'Company Phone Number'
                          : "رقم هاتف الشركة",
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
                        _signUpController.errors = {};
                      },
                    );
                  }),
                  SignUpTextField(
                    hintText: lang == 0 ? "Company Email" : "إيميل الشركة",
                    keyBoardType: TextInputType.emailAddress,
                    onchanged: (s) {
                      _signUpController.dataToRegister['work_email'] = s!;
                      _signUpController.errors = {};
                    },
                    validator: (s) {
                      if (s!.isEmpty) {
                        return null;
                      } else if (!EmailValidator.validate(s)) {
                        return "please enter a valid email!";
                      } else if (_signUpController.errors
                          .containsKey('work_email')) {
                        return _signUpController.errors['work_email'][0]
                            .toString();
                      } else {
                        return null;
                      }
                    },
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Padding(
                      padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                      child: Obx(
                        () {
                          logSuccess(_signUpController.globalData['category']);
                          List categories =
                              _signUpController.globalData['category'];
                          List<String> ids = categories
                              .map<String>((e) => e['id'].toString())
                              .toList();
                          List<String> categoryNames = categories
                              .map<String>((e) => lang == 0
                                  ? e['name_en'].toString()
                                  : e['name_ar'].toString())
                              .toList();

                          return DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              fillColor: Color(0xffF8F8F8),
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            items: categoryNames
                                .map((e) => DropdownMenuItem<String>(
                                      child: Text(e),
                                      value: e,
                                    ))
                                .toList(),
                            value: _signUpController.selectedCategoryDrop == ""
                                ? null
                                : _signUpController.selectedCategoryDrop,
                            hint: Text(lang == 0 ? "Categories" : "الفئات"),
                            onChanged: (value) {
                              _signUpController.errors = {};

                              _signUpController.selectCategoryDrop(value!);

                              _signUpController.dataToRegister['category_id'] =
                                  ids[categoryNames.indexOf(value)];
                            },
                          );
                        },
                      ),
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
            label: myLabel(1,
                lang == 0 ? 'Bank Account Details' : "معلومات الحساب المصرفي"),
            content: SizedBox(
              height: h < 600 ? 43.0.h : 50.0.h,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 10),
                primary: false,
                children: [
                  SignUpTextField(
                    hintText:
                        lang == 0 ? "Bank Account Name" : "اسم الحساب المصرفي",
                    onchanged: (s) {
                      _signUpController.dataToRegister['bank_account_name'] =
                          s!;
                      _signUpController.errors = {};
                    },
                    validator: (s) {
                      if (_signUpController.errors == null)
                        return null;
                      else if (_signUpController.errors
                          .containsKey('bank_account_name')) {
                        return _signUpController.errors['bank_account_name'][0]
                            .toString();
                      } else
                        return null;
                    },
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Padding(
                      padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                      child: GetBuilder<BankController>(builder: (c) {
                        List<Bank> banks = c.banks
                            .where((element) =>
                                element.countryId.toString() ==
                                _signUpController.dataToRegister["country_id"])
                            .toList();

                        return DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            fillColor: Color(0xffF8F8F8),
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(10.0),
                                borderSide: BorderSide.none),
                          ),
                          items: banks
                              .map((e) => DropdownMenuItem<String>(
                                    child: Text(e.name!),
                                    value: e.name,
                                  ))
                              .toList(),
                          value: _signUpController.selectedBankDrop == ""
                              ? null
                              : _signUpController.selectedBankDrop,
                          hint: Text(lang == 0 ? "Banks" : "البنوك"),
                          onChanged: (value) {
                            _signUpController.selectBankDrop(value!);
                            _signUpController.errors = {};

                            _signUpController.dataToRegister['bank_name'] =
                                value;
                            _signUpController.dataToRegister['bank_id'] = banks
                                .firstWhere((element) => element.name == value)
                                .id!;
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
                  ),
                  SignUpTextField(
                    hintText: lang == 0 ? "Account Number" : "رقم الحساب",
                    keyBoardType: TextInputType.number,
                    onchanged: (s) {
                      _signUpController.dataToRegister['account_number'] = s!;
                      _signUpController.errors = {};
                    },
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
                    onchanged: (s) {
                      _signUpController.dataToRegister['iban'] = s!;
                      _signUpController.errors = {};
                    },
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
            label: myLabel(
                2,
                lang == 0
                    ? 'Company Manager User Login Information'
                    : "معلومات تسجيل دخول مستخدم مدير الشركة"),
            content: SizedBox(
              height: h < 600 ? 43.0.h : 50.0.h,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 10),
                primary: false,
                children: [
                  SignUpTextField(
                    hintText:
                        lang == 0 ? "Manager Full Name" : "الاسم الكامل للمدير",
                    onchanged: (s) {
                      _signUpController.dataToRegister['full_name'] = s!;
                      _signUpController.errors = {};
                    },
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
                    hintText: lang == 0 ? "Email" : "الإيميل",
                    keyBoardType: TextInputType.emailAddress,
                    onchanged: (s) {
                      _signUpController.dataToRegister['email'] = s!;
                      _signUpController.errors = {};
                    },
                    validator: (s) {
                      if (s!.isEmpty) {
                        return null;
                      }
                      if (!EmailValidator.validate(s)) {
                        return "please_enter_a_valid_email".tr;
                      } else if (_signUpController.errors
                          .containsKey('email')) {
                        return _signUpController.errors['email'][0].toString();
                      } else {
                        return null;
                      }
                    },
                  ),
                  GetBuilder<GlobalDataController>(builder: (c) {
                    List<Country> countries = _globalDataController.countries
                        .where((element) => element.code == "+9")
                        .toList();
                    return SignUpTextField(
                      keyBoardType: TextInputType.number,
                      prefixIcon: SizedBox(
                        width: 60,
                        child: DropdownButtonFormField<String>(
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                          isExpanded: true,
                          items: countries
                              .map((e) => DropdownMenuItem<String>(
                                    child: Center(child: Text(e.code!)),
                                    value: e.code,
                                  ))
                              .toList(),
                          value: countries[0].code,
                          onChanged: (value) {
                            _signUpController.dataToRegister[
                                    'phone_number_code_manager_id'] =
                                countries
                                    .where((element) => element.code == value)
                                    .first
                                    .id!;

                            _signUpController.errors = {};
                          },
                        ),
                      ),
                      onchanged: (s) {
                        _signUpController
                            .dataToRegister['phone_number_manager'] = s!;
                        _signUpController.errors = {};
                      },
                      validator: (s) {
                        if (_signUpController.errors == null) return null;
                        return _signUpController.errors
                                .containsKey("phone_number_manager")
                            ? _signUpController.errors['phone_number_manager']
                                    [0]
                                .toString()
                            : null;
                      },
                      hintText: lang == 0
                          ? 'Manager Mobile Number'
                          : "رقم هاتف المدير",
                    );
                  }),
                  SignUpTextField(
                    hintText: lang == 0 ? "Password" : "كلمة المرور",
                    obsecureText: true,
                    controller: pw,
                    onchanged: (s) {
                      _signUpController.dataToRegister['password'] = s!;
                      _signUpController.errors = {};
                    },
                    validator: (s) {
                      if (s!.isEmpty) {
                        return null;
                      } else if (s.length < 6) {
                        return "password should at least be 6 length";
                      } else {
                        return _signUpController.errors.containsKey("password")
                            ? _signUpController.errors['password'][0]
                            : null;
                      }
                    },
                  ),
                  SignUpTextField(
                      hintText:
                          lang == 0 ? "Confirm Password" : "تأكيد كلمة المرور",
                      controller: cpw,
                      obsecureText: true,
                      validator: (s) {
                        if (s!.isEmpty) {
                          return null;
                        } else if (cpw.text != pw.text) {
                          return "passwords doesn't match";
                        } else {
                          return _signUpController.errors
                                  .containsKey("password_confirmation")
                              ? _signUpController
                                  .errors['password_confirmation'][0]
                              : null;
                        }
                      },
                      onchanged: (s) {
                        _signUpController
                            .dataToRegister['password_confirmation'] = s!;
                        _signUpController.errors = {};
                      }),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Padding(
                      padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                      child: Obx(() {
                        List countries =
                            _signUpController.globalData['country'];
                        List<String> ids = countries
                            .map<String>(
                              (e) => e['id'].toString(),
                            )
                            .toList();
                        List<String> countriesNames = countries
                            .map<String>(
                              (e) => lang == 0
                                  ? e['name_en'].toString()
                                  : e['name_ar'].toString(),
                            )
                            .toSet()
                            .toList();
                        return DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            fillColor: Color(0xffF8F8F8),
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(10.0),
                                borderSide: BorderSide.none),
                          ),
                          items: countriesNames
                              .map((e) => DropdownMenuItem<String>(
                                    child: Text(e),
                                    value: e,
                                  ))
                              .toList(),
                          value: _signUpController.selectedNationalityDrop == ""
                              ? null
                              : _signUpController.selectedNationalityDrop,
                          hint: Text(lang == 0 ? "Nationality" : "الجنسية"),
                          onChanged: (value) {
                            _signUpController.selectNationalityDrop(value!);
                            _signUpController.errors = {};

                            _signUpController.dataToRegister['nationality_id'] =
                                ids[countriesNames.indexOf(value)];
                          },
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
            isActive: _currentStep >= 2,
            state: _currentStep >= 2
                ? MyStepState.complete
                : MyStepState.disabled),
        MyStep(
            label: myLabel(3, lang == 0 ? 'Send OPT' : "أرسل OPT"),
            content: SizedBox(
              height: h < 600 ? 45.0.h : 50.0.h,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 10),
                primary: false,
                children: [
                  Container(
                    margin:
                        EdgeInsets.only(bottom: 5.0.sp, left: 15, right: 15),
                    child: Text(
                      lang == 0 ? "We've almost done!" : "لقد انتهينا تقريبا!",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0.sp),
                    ),
                  ),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: IntlPhoneField(
                        flagsButtonPadding:
                            EdgeInsets.symmetric(horizontal: 20),
                        dropdownIconPosition: IconPosition.trailing,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          fillColor: Color(0xffF8F8F8),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                              borderSide: BorderSide.none),
                        ),
                        initialCountryCode: 'AE',
                        onChanged: (phone) {},
                        onCountryChanged: (value) =>
                            mobileCode = "+${value.dialCode}",
                        controller: phoneController,
                        validator: (p0) {
                          if (p0!.number.isEmpty) {
                            return "can't be empty";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10, left: 15, right: 15),
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
                                  text: lang == 0
                                      ? 'By clicking on send OPT button, you agree that you are not acting as a fundraiser, Your activities are in compliance with the rules and regulations of your country and I agree to receive promotional content and special offers via email .You can unsubscribe anytime.You agree to '
                                      : " بالنقر على زر إرسال OPT ، فإنك توافق على أنك لا تعمل كجمع تبرعات وأن أنشطتك تتوافق مع القواعد واللوائح المعمول بها في بلدك وأوافق على تلقي محتوى ترويجي وعروض خاصة عبر البريد الإلكتروني ، ويمكنك إلغاء الاشتراك في أي وقت. أنت توافق على ",
                                  style: TextStyle(
                                    color: Color(0xff858585),
                                    fontSize: 12.0.sp,
                                  ),
                                ),
                                TextSpan(
                                  text: lang == 0
                                      ? 'Terms of Use'
                                      : "شروط الاستخدام ",
                                  style: TextStyle(
                                    color: Color(0xff00A7B3),
                                    decoration: TextDecoration.underline,
                                    fontSize: 12.0.sp,
                                  ),
                                ),
                                TextSpan(
                                  text: lang == 0 ? ' and ' : 'و',
                                  style: TextStyle(
                                    color: Color(0xff858585),
                                    fontSize: 12.0.sp,
                                  ),
                                ),
                                TextSpan(
                                  text: lang == 0
                                      ? 'Privacy Policy.'
                                      : ".سياسة الخصوصية ",
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
                fontSize: text.split(" ").length >= 3 ? 8.sp : 11.0.sp),
            softWrap: true,
          ),
        )
      : Text('');
}
