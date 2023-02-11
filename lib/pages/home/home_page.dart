import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:safqa/admin/controller/admin_controller.dart';
import 'package:safqa/admin/pages/about/abouts_page.dart';
import 'package:safqa/admin/pages/addresses/addresses_main_page.dart';
import 'package:safqa/admin/pages/banks/banks_main_page.dart';
import 'package:safqa/admin/pages/business%20Categories/business_categories_page.dart';
import 'package:safqa/admin/pages/business%20types/business_types_page.dart';
import 'package:safqa/admin/pages/contact/contact_main_page.dart';
import 'package:safqa/admin/pages/languages/languages_page.dart';
import 'package:safqa/admin/pages/payment%20methods/payment_methods_page.dart';
import 'package:safqa/admin/pages/profiles/profiles_page.dart';
import 'package:safqa/admin/pages/recurring%20interval/recurring_intervals_page.dart';
import 'package:safqa/admin/pages/social%20media/social_media_page.dart';
import 'package:safqa/pages/home/menu_pages/account_statment/ac_main_page.dart';
import 'package:safqa/pages/home/menu_pages/commisions/commisions_main_page.dart';
import 'package:safqa/pages/home/menu_pages/contact/contact_page.dart';
import 'package:safqa/pages/home/menu_pages/customers/customers_main_page.dart';
import 'package:safqa/pages/home/menu_pages/deposits/deposits_main_page.dart';
import 'package:safqa/pages/home/menu_pages/invoices/Invoices_page.dart';
import 'package:safqa/pages/home/menu_pages/mf_auth/mf_auth_main_page.dart';
import 'package:safqa/pages/home/menu_pages/products/products_main_page.dart';
import 'package:safqa/pages/home/menu_pages/refunds/refunds_main_page.dart';
import 'package:safqa/pages/home/menu_pages/settings/settings_main_page.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/locals_controller.dart';
import '../../controllers/login_controller.dart';
import '../../controllers/zoom_drawer_controller.dart';
import '../../models/menu_item.dart' as mi;
import 'main_page.dart';
import 'menu_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LoginController loginController = Get.find();
  LocalsController localsController = Get.find();
  AdminController _adminController = Get.find();
  MyZoomDrawerController zoomDrawerController =
      Get.put(MyZoomDrawerController());
  mi.MenuItem _currnetMenuItem = MyMenuItems.invoices;
  mi.MenuItem _currnetAdminMenuItem = MyAdminMenuItems.banks;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff285B74),
      body: GetBuilder<MyZoomDrawerController>(
        builder: (c) {
          return ZoomDrawer(
            angle: 0,
            borderRadius: 30,
            controller: c.zoomDrawerController,
            menuScreenWidth: 60.0.w,
            isRtl: localsController.currenetLocale == 1,
            slideWidth: 60.0.w,
            menuScreen: MenuPage(
              currentItem: _adminController.isAdmin
                  ? _currnetAdminMenuItem
                  : _currnetMenuItem,
              onSelectedItem: (value) {
                setState(() {
                  if (_adminController.isAdmin) {
                    _currnetAdminMenuItem = value;
                  } else {
                    _currnetMenuItem = value;
                  }
                });
                // zoomDrawerController.zoomDrawerController.close!();
                Get.to(() =>
                    _adminController.isAdmin ? getAdminScreen() : getScreen());
              },
            ),
            mainScreen: MainPage(),
          );
        },
      ),
    );
  }

  Widget getScreen() {
    switch (_currnetMenuItem) {
      case MyMenuItems.invoices:
        return const InvoicesPage();
      case MyMenuItems.products:
        return ProductsMainPage();
      case MyMenuItems.customers:
        return CustomersMainPage();
      case MyMenuItems.commissions:
        return CommisionsMainPage();
      case MyMenuItems.accountStatement:
        return AccountStateMainPage();
      case MyMenuItems.deposits:
        return DepositsMainPage();
      case MyMenuItems.multiFactorAuthentication:
        return MultiFactorAuthMainPage();
      case MyMenuItems.contact:
        return ContactPage();
      case MyMenuItems.settings:
        return SettingsPage();
      case MyMenuItems.refunds:
        return RefundsMainPage();

      default:
        return MainPage();
    }
  }

  Widget getAdminScreen() {
    switch (_currnetAdminMenuItem) {
      case MyAdminMenuItems.banks:
        return BanksMainPage();
      case MyAdminMenuItems.profiles:
        return ProfilesMainPage();
      case MyAdminMenuItems.languages:
        return LanguagesMainPage();
      case MyAdminMenuItems.businessCategories:
        return BusinessCategoriesMainPage();
      case MyAdminMenuItems.businessTypes:
        return BusinessTypesMainPage();
      case MyAdminMenuItems.paymentMethods:
        return PaymentMethodsMainPage();
      case MyAdminMenuItems.recurringInterval:
        return RecurringIntervalsMainPage();
      case MyAdminMenuItems.socialMedia:
        return SocialMediaMainPage();
      case MyAdminMenuItems.about:
        return AboutsMainPage();
      case MyAdminMenuItems.contact:
        return ContactMainPage();
      case MyAdminMenuItems.multiFactorAuthentication:
        return MultiFactorAuthMainPage();
      case MyAdminMenuItems.addresses:
        return AddressesMainPage();

      default:
        return MainPage();
    }
  }
}
