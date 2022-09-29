import 'package:get/get.dart';

class LocaleString extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'login': 'Login',
          'signup': 'Sign Up',
          'start': 'let\'s Start',
          'skip': 'skip',
          'welcome': 'Welcome',
          'password': 'Password',
          'email': 'Email',
          'remember': "Remember me",
          'forget_pass': 'Forgot your password?',
          'or_using_fast_login_by_fingerprint':
              'Or using fast login by fingerprint',
          'dont_have_an_account': 'Don\'t have an account?',
          'create_an_account': 'Create an account',
          'please_enter_a_valid_email': 'Please enter a valid email',
          'password_should_contain_more_than_5_characters':
              'Password should contain more than 5 characters'
        },
        'ar_SYR': {
          'login': 'الدخول',
          'signup': 'التسجيل',
          'start': 'دعنا نبدأ',
          'skip': 'تخطي',
          'welcome': 'مرحباً بك',
          'password': 'كلمة السر',
          'email': 'البريد الإلكتروني',
          'remember': "تذكر كلمة السر",
          'forget_pass': 'هل نسيت كلمة السر؟',
          'or_using_fast_login_by_fingerprint': 'أو سجل دخول باستخدام البصمة',
          'dont_have_an_account': 'ليس لديك حساب؟',
          'create_an_account': 'أنشئ حساباً',
          'please_enter_a_valid_email': 'أدخل بريداً إلكترونياً صالحاً',
          'password_should_contain_more_than_5_characters':
              'يجب أن تحتوي كلمة السر 5 محارف على الأقل'
        }
      };
}
