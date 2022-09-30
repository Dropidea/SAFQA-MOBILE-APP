import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/controllers/login_controller.dart';
import 'package:safqa/main.dart';
import 'package:safqa/pages/signup.dart';
import 'package:safqa/widgets/zero_app_bar.dart';
import 'package:sizer/sizer.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obsecureflag = true;
  bool _rememberMeFlag = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  LoginController _loginController = Get.find();
  final formKey = GlobalKey<FormState>();

  void toggleObsecure() {
    _obsecureflag = !_obsecureflag;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: ZeroAppBar(),
      body: ListView(
        primary: false,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/welcome_background.png"),
                fit: BoxFit.cover,
              ),
            ),
            width: w,
            // height: h,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20, top: 5),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 22.0.sp,
                        ),
                        onPressed: () => Get.back(),
                      ),
                    )
                  ],
                ),
                Align(
                  child: Container(
                    width: 100.0.sp,
                    height: 120.0.sp,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          "assets/images/logo-white.png",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0.sp,
                ),
                Container(
                  width: w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "login".tr,
                              style: TextStyle(
                                  color: Color(0xff2F6782),
                                  fontSize: 20.0.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Form(
                        key: formKey,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 40),
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _emailController,
                                cursorHeight: 3.0.sp,
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(fontSize: 15.0.sp),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.email_outlined),
                                  hintText: "email".tr,
                                  hintStyle: TextStyle(fontSize: 15.0.sp),
                                ),
                                validator: (String? value) =>
                                    EmailValidator.validate(value!)
                                        ? null
                                        : "please_enter_a_valid_email".tr,
                              ),
                              SizedBox(
                                height: 5.0.sp,
                              ),
                              TextFormField(
                                controller: _passwordController,
                                cursorHeight: 3.0.sp,
                                style: TextStyle(fontSize: 15.0.sp),
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: _obsecureflag,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.lock_outline),
                                  suffixIcon: IconButton(
                                    icon: Icon(Icons.remove_red_eye),
                                    onPressed: toggleObsecure,
                                  ),
                                  hintText: "password".tr,
                                  hintStyle: TextStyle(fontSize: 15.0.sp),
                                ),
                                validator: (String? value) {
                                  if ((!(value!.length > 5) &&
                                      value.isNotEmpty)) {
                                    return "password_should_contain_more_than_5_characters"
                                        .tr;
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 10.0.sp,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      //TODO:Forgot Your Password Function
                                      logSuccess("Forgot Your Password?");
                                    },
                                    child: Text(
                                      "forget_pass".tr,
                                      style: TextStyle(
                                        color: Color(0xff00A7B3),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 5.0.sp,
                              ),
                              SizedBox(
                                height: 30,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
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
                                          _rememberMeFlag = value!;
                                          setState(() {});
                                        },
                                        value: _rememberMeFlag,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "remember".tr,
                                      style: TextStyle(fontSize: 17.0.sp),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10.0.sp,
                              ),
                              Container(
                                width: 0.7 * w,
                                height: 40.0.sp,
                                decoration: BoxDecoration(
                                  color: Color(0xff2F6782),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: InkWell(
                                  onTap: () async {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();

                                    final isValid =
                                        formKey.currentState!.validate();
                                    if (!isValid) return;

                                    await _loginController.login(
                                        _emailController.text,
                                        _passwordController.text,
                                        _rememberMeFlag);
                                  },
                                  child: Center(
                                    child: Text(
                                      "login".tr,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5.0.sp,
                              ),
                              Text(
                                "or_using_fast_login_by_fingerprint".tr,
                                style: TextStyle(
                                    color: Color(0xff2F6782),
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.w500,
                                    decorationThickness: 15,
                                    fontSize: 12.0.sp),
                              ),
                              SizedBox(
                                height: 10.0.sp,
                              ),
                              Align(
                                child: Container(
                                  width: 80.0.sp,
                                  height: 80.0.sp,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                        "assets/images/finger-print.png",
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.0.sp,
                              ),
                              Text(
                                "dont_have_an_account".tr,
                                style: TextStyle(fontSize: 13.0.sp),
                              ),
                              GestureDetector(
                                onTap: () => Get.to(() => SignUpPage()),
                                child: Text(
                                  "create_an_account".tr,
                                  style: TextStyle(
                                    color: Color(0xff00A7B3),
                                    decoration: TextDecoration.underline,
                                    decorationThickness: 10,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.0.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
