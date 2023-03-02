import 'package:flutter/cupertino.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import "package:sizer/sizer.dart";

class ManageUser {
  int? id;
  int? roleId;
  int? approvalStatus;
  int? profileBusinessId;
  int phoneNumberCodeManagerId = 1;
  String? phoneNumberManager;
  String? email;
  String? fullName;
  String? name;
  int? nationalityId;
  int isEnable = 0;
  String? avatar;
  int? enableBellSound;
  int? confirmEmail;
  int? confirmPhone;
  int? batchInvoices;
  int? deposits;
  int? paymentLinks;
  int? profile;
  int? isSuperAdmin;
  int? users;
  int? refund;
  int? showAllInvoices;
  int? customers;
  int? invoices;
  int? products;
  int? commissions;
  int? accountStatements;
  int? orders;
  int? suppliers;
  int notificationCreateInvoice = 0;
  int notificationInvoicePaid = 0;
  int notificationNewOrder = 0;
  int notificationCreateBatchInvoice = 0;
  int notificationDeposit = 0;
  int notificationCreateRecurringInvoice = 0;
  int notificationRefundTransfered = 0;
  int notificationNotificationsServiceRequest = 0;
  int notificationNotificationsHourlyDepositRejected = 0;
  int notificationApproveVendorAccount = 0;
  int notificationCreateShippingInvoice = 0;

  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  Nationality? nationality;
  UserRole? userRole;
  ProfileBusiness? profileBusines;

  ManageUser({
    this.approvalStatus,
    this.id,
    this.isSuperAdmin,
    this.roleId,
    this.profileBusinessId,
    this.phoneNumberCodeManagerId = 1,
    this.phoneNumberManager,
    this.email,
    this.fullName,
    this.name,
    this.nationalityId,
    this.isEnable = 0,
    this.avatar,
    this.enableBellSound,
    this.confirmEmail,
    this.confirmPhone,
    this.batchInvoices,
    this.deposits,
    this.paymentLinks,
    this.profile,
    this.users,
    this.refund,
    this.showAllInvoices,
    this.customers,
    this.invoices,
    this.products,
    this.commissions,
    this.accountStatements,
    this.orders,
    this.suppliers,
    this.notificationCreateInvoice = 0,
    this.notificationInvoicePaid = 0,
    this.notificationNewOrder = 0,
    this.notificationCreateBatchInvoice = 0,
    this.notificationDeposit = 0,
    this.notificationCreateRecurringInvoice = 0,
    this.notificationRefundTransfered = 0,
    this.notificationNotificationsServiceRequest = 0,
    this.notificationNotificationsHourlyDepositRejected = 0,
    this.notificationApproveVendorAccount = 0,
    this.notificationCreateShippingInvoice = 0,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.nationality,
    this.userRole,
    this.profileBusines,
  });
  void superMaster() {
    batchInvoices = 1;
    deposits = 1;
    paymentLinks = 1;
    profile = 1;
    users = 1;
    refund = 1;
    showAllInvoices = 1;
    customers = 1;
    invoices = 1;
    products = 1;
    commissions = 1;
    accountStatements = 1;
    orders = 1;
    suppliers = 1;
  }

  List<String> getSelectedRoles() {
    List<String> tmp = [];
    if (batchInvoices == 1) {
      tmp.add("Batch Invoices");
    }
    if (deposits == 1) {
      tmp.add("Deposits");
    }
    if (paymentLinks == 1) {
      tmp.add("Payment Links");
    }
    if (profile == 1) {
      tmp.add("Profile");
    }
    if (users == 1) {
      tmp.add("Users");
    }
    if (refund == 1) {
      tmp.add("Refund");
    }
    if (showAllInvoices == 1) {
      tmp.add("Show All Invoices");
    }
    if (customers == 1) {
      tmp.add("Customers");
    }
    if (invoices == 1) {
      tmp.add("Invoices");
    }
    if (products == 1) {
      tmp.add("Products");
    }
    if (commissions == 1) {
      tmp.add("Commissions");
    }
    if (accountStatements == 1) {
      tmp.add("Account Statements");
    }
    if (orders == 1) {
      tmp.add("Orders");
    }
    if (suppliers == 1) {
      tmp.add("Suppliers");
    }
    return tmp;
  }

  List<String> getSelectedNotifications() {
    List<String> tmp = [];
    if (notificationCreateInvoice == 1) {
      tmp.add("Notification Create Invoice");
    }
    if (notificationApproveVendorAccount == 1) {
      tmp.add("Notification Approve Vendor Account");
    }
    if (notificationCreateBatchInvoice == 1) {
      tmp.add("Notification Create Batch Invoice");
    }
    if (notificationCreateRecurringInvoice == 1) {
      tmp.add("Notification Create Recurring Invoice");
    }
    if (notificationCreateShippingInvoice == 1) {
      tmp.add("Notification Create Shipping Invoice");
    }
    if (notificationDeposit == 1) {
      tmp.add("Notification Deposit");
    }
    if (notificationInvoicePaid == 1) {
      tmp.add("Notification Invoice Paid");
    }
    if (notificationNewOrder == 1) {
      tmp.add("Notification New Order");
    }
    if (notificationNotificationsHourlyDepositRejected == 1) {
      tmp.add("Notification Notifications Hourly Deposit Rejected");
    }
    if (notificationNotificationsServiceRequest == 1) {
      tmp.add("Notification Notifications Service Request");
    }
    if (notificationRefundTransfered == 1) {
      tmp.add("Notification Refund Transfered");
    }
    return tmp;
  }

  void notificationSettingsSet(List<String> s) {
    notificationCreateInvoice = 0;
    notificationCreateBatchInvoice = 0;
    notificationCreateRecurringInvoice = 0;
    notificationCreateShippingInvoice = 0;
    notificationDeposit = 0;
    notificationInvoicePaid = 0;
    notificationNewOrder = 0;
    notificationNotificationsHourlyDepositRejected = 0;
    notificationNotificationsServiceRequest = 0;
    notificationRefundTransfered = 0;
    notificationApproveVendorAccount = 0;
    if (s.contains("Notification Create Invoice")) {
      notificationCreateInvoice = 1;
    }
    if (s.contains("Notification Approve Vendor Account")) {
      notificationApproveVendorAccount = 1;
    }
    if (s.contains("Notification Create Batch Invoice")) {
      notificationCreateBatchInvoice = 1;
    }
    if (s.contains("Notification Create Recurring Invoice")) {
      notificationCreateRecurringInvoice = 1;
    }
    if (s.contains("Notification Create Shipping Invoice")) {
      notificationCreateShippingInvoice = 1;
    }
    if (s.contains("Notification Deposit")) {
      notificationDeposit = 1;
    }
    if (s.contains("Notification Invoice Paid")) {
      notificationInvoicePaid = 1;
    }
    if (s.contains("Notification New Order")) {
      notificationNewOrder = 1;
    }
    if (s.contains("Notification Notifications Hourly Deposit Rejected")) {
      notificationNotificationsHourlyDepositRejected = 1;
    }
    if (s.contains("Notification Notifications Service Request")) {
      notificationNotificationsServiceRequest = 1;
    }
    if (s.contains("Notification Refund Transfered")) {
      notificationRefundTransfered = 1;
    }
  }

  void normalUser(List<String> s) {
    batchInvoices = 0;
    deposits = 0;
    paymentLinks = 0;
    profile = 0;
    users = 0;
    refund = 0;
    showAllInvoices = 0;
    customers = 0;
    invoices = 0;
    products = 0;
    commissions = 0;
    accountStatements = 0;
    orders = 0;
    suppliers = 0;

    if (s.contains("Batch Invoices")) {
      batchInvoices = 1;
    }
    if (s.contains("Deposits")) {
      deposits = 1;
    }
    if (s.contains("Payment Links")) {
      paymentLinks = 1;
    }
    if (s.contains("Profile")) {
      profile = 1;
    }
    if (s.contains("Users")) {
      users = 1;
    }
    if (s.contains("Refund")) {
      refund = 1;
    }
    if (s.contains("Show All Invoices")) {
      showAllInvoices = 1;
    }
    if (s.contains("Customers")) {
      customers = 1;
    }
    if (s.contains("Invoices")) {
      invoices = 1;
    }
    if (s.contains("Products")) {
      products = 1;
    }
    if (s.contains("Commissions")) {
      commissions = 1;
    }
    if (s.contains("Account Statements")) {
      accountStatements = 1;
    }
    if (s.contains("Orders")) {
      orders = 1;
    }
    if (s.contains("Suppliers")) {
      suppliers = 1;
    }
  }

  ManageUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roleId = json['role_id'];
    approvalStatus = json['approval_status'];
    profileBusinessId = json['profile_business_id'];
    phoneNumberCodeManagerId = json['phone_number_code_manager_id'];
    phoneNumberManager = json['phone_number_manager'];
    email = json['email'];
    fullName = json['full_name'];
    name = json['name'];
    nationalityId = json['nationality_id'];
    isEnable = json['is_enable'];
    avatar = json['avatar'];
    enableBellSound = json['enable_bell_sound'];
    confirmEmail = json['confirm_email'];
    confirmPhone = json['confirm_phone'];
    batchInvoices = json['batch_invoices'];
    deposits = json['deposits'];
    paymentLinks = json['payment_links'];
    profile = json['profile'];
    isSuperAdmin = json['is_super_admin'];
    users = json['users'];
    refund = json['refund'];
    showAllInvoices = json['show_all_invoices'];
    customers = json['customers'];
    invoices = json['invoices'];
    products = json['products'];
    commissions = json['commissions'];
    accountStatements = json['account_statements'];
    orders = json['orders'];
    suppliers = json['suppliers'];
    notificationCreateInvoice = json['notification_create_invoice'];
    notificationInvoicePaid = json['notification_invoice_paid'];
    notificationNewOrder = json['notification_new_order'];
    notificationCreateBatchInvoice = json['notification_create_batch_invoice'];
    notificationDeposit = json['notification_deposit'];
    notificationCreateRecurringInvoice =
        json['notification_create_recurring_invoice'];
    notificationRefundTransfered = json['notification_refund_transfered'];
    notificationNotificationsServiceRequest =
        json['notification_notifications_service_request'];
    notificationNotificationsHourlyDepositRejected =
        json['notification_notifications_hourly_deposit_rejected'];
    notificationApproveVendorAccount =
        json['notification_approve_vendor_account'];
    notificationCreateShippingInvoice =
        json['notification_create_shipping_invoice'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    nationality = json['nationality'] != null
        ? new Nationality.fromJson(json['nationality'])
        : null;
    userRole = json['user_role'] != null
        ? new UserRole.fromJson(json['user_role'])
        : null;

    profileBusines = json['profile_business'] != null
        ? new ProfileBusiness.fromJson(json['profile_business'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['role_id'] = roleId;
    data['approval_status'] = approvalStatus;
    data['profile_business_id'] = profileBusinessId;
    data['phone_number_code_manager_id'] = phoneNumberCodeManagerId;
    data['phone_number_manager'] = phoneNumberManager;
    data['email'] = email;
    data['full_name'] = fullName;
    data['name'] = name;
    data['nationality_id'] = nationalityId;
    data['is_enable'] = isEnable;
    data['avatar'] = avatar;
    data['enable_bell_sound'] = enableBellSound;
    data['confirm_email'] = confirmEmail;
    data['confirm_phone'] = confirmPhone;
    data['batch_invoices'] = batchInvoices;
    data['deposits'] = deposits;
    data['payment_links'] = paymentLinks;
    data['profile'] = profile;
    data['is_super_admin'] = isSuperAdmin;
    data['users'] = users;
    data['refund'] = refund;
    data['show_all_invoices'] = showAllInvoices;
    data['customers'] = customers;
    data['invoices'] = invoices;
    data['products'] = products;
    data['commissions'] = commissions;
    data['account_statements'] = accountStatements;
    data['orders'] = orders;
    data['suppliers'] = suppliers;
    data['notification_create_invoice'] = notificationCreateInvoice;
    data['notification_invoice_paid'] = notificationInvoicePaid;
    data['notification_new_order'] = notificationNewOrder;
    data['notification_create_batch_invoice'] = notificationCreateBatchInvoice;
    data['notification_deposit'] = notificationDeposit;
    data['notification_create_recurring_invoice'] =
        notificationCreateRecurringInvoice;
    data['notification_refund_transfered'] = notificationRefundTransfered;
    data['notification_notifications_service_request'] =
        notificationNotificationsServiceRequest;
    data['notification_notifications_hourly_deposit_rejected'] =
        notificationNotificationsHourlyDepositRejected;
    data['notification_approve_vendor_account'] =
        notificationApproveVendorAccount;
    data['notification_create_shipping_invoice'] =
        notificationCreateShippingInvoice;
    data['email_verified_at'] = emailVerifiedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (nationality != null) {
      data['nationality'] = nationality!.toJson();
    }
    if (userRole != null) {
      data['user_role'] = userRole!.toJson();
    }
    if (profileBusines != null) {
      data['profile_business'] = profileBusines!.toJson();
    }
    return data;
  }
}

class Nationality {
  int? id;
  String? nameEn;
  String? nameAr;
  String? code;
  String? nationalityEn;
  String? nationalityAr;
  String? flag;
  String? currency;
  String? shortCurrency;
  int? defaultc;

  Nationality(
      {this.id,
      this.nameEn,
      this.nameAr,
      this.code,
      this.nationalityEn,
      this.nationalityAr,
      this.flag,
      this.currency,
      this.shortCurrency,
      this.defaultc});

  Nationality.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    code = json['code'];
    nationalityEn = json['nationality_en'];
    nationalityAr = json['nationality_ar'];
    flag = json['flag'];
    currency = json['currency'];
    shortCurrency = json['short_currency'];
    defaultc = json['default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_en'] = this.nameEn;
    data['name_ar'] = this.nameAr;
    data['code'] = this.code;
    data['nationality_en'] = this.nationalityEn;
    data['nationality_ar'] = this.nationalityAr;
    data['flag'] = this.flag;
    data['currency'] = this.currency;
    data['short_currency'] = this.shortCurrency;
    data['default'] = this.defaultc;
    return data;
  }
}

class UserRole {
  int? id;
  String? nameEn;
  String? nameAr;

  UserRole({this.id, this.nameEn, this.nameAr});

  UserRole.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_en'] = this.nameEn;
    data['name_ar'] = this.nameAr;
    return data;
  }
}

class ProfileBusiness {
  int? id;
  int? countryId;
  int? phoneNumberCodeId;
  int? businessTypeId;
  int? categoryId;
  int? invoiceExpiryAfterNumber;
  int? invoiceExpiryAfterTypeId;
  int? languageId;
  int? depositTermsId;
  String? companyName;
  String? nameEn;
  String? nameAr;
  String? logo;
  String? websiteUrl;
  String? workEmail;
  String? phoneNumber;
  String? customSmsAr;
  String? customSmsEn;
  String? termsAndConditions;
  int? productsDeliveryFees;
  String? promoCode;
  int? approvalStatus;
  String? bankAccountName;
  String? bankName;
  String? accountNumber;
  String? iban;
  String? bankAccountLetter;
  String? others;
  String? civilId;
  String? civilIdBack;
  String? themeColor;
  int? enableNewDesign;
  int? showAllCurrencies;
  int? enableCardView;

  ProfileBusiness({
    this.id,
    this.countryId,
    this.phoneNumberCodeId,
    this.businessTypeId,
    this.categoryId,
    this.invoiceExpiryAfterNumber,
    this.invoiceExpiryAfterTypeId,
    this.languageId,
    this.depositTermsId,
    this.companyName,
    this.nameEn,
    this.nameAr,
    this.logo,
    this.websiteUrl,
    this.workEmail,
    this.phoneNumber,
    this.customSmsAr,
    this.customSmsEn,
    this.termsAndConditions,
    this.productsDeliveryFees,
    this.promoCode,
    this.approvalStatus,
    this.bankAccountName,
    this.bankName,
    this.accountNumber,
    this.iban,
    this.bankAccountLetter,
    this.others,
    this.civilId,
    this.civilIdBack,
    this.themeColor,
    this.enableNewDesign,
    this.showAllCurrencies,
    this.enableCardView,
  });

  ProfileBusiness.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryId = json['country_id'];
    phoneNumberCodeId = json['phone_number_code_id'];
    businessTypeId = json['business_type_id'];
    categoryId = json['category_id'];
    invoiceExpiryAfterNumber = json['invoice_expiry_after_number'];
    invoiceExpiryAfterTypeId = json['invoice_expiry_after_type_id'];
    languageId = json['language_id'];
    depositTermsId = json['deposit_terms_id'];
    companyName = json['company_name'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    logo = json['logo'];
    websiteUrl = json['website_url'];
    workEmail = json['work_email'];
    phoneNumber = json['phone_number'];
    customSmsAr = json['custom_sms_ar'];
    customSmsEn = json['custom_sms_en'];
    termsAndConditions = json['terms_and_conditions'];
    productsDeliveryFees = json['products_delivery_fees'];
    promoCode = json['promo_code'];
    approvalStatus = json['approval_status'];
    bankAccountName = json['bank_account_name'];
    bankName = json['bank_name'];
    accountNumber = json['account_number'];
    iban = json['iban'];
    bankAccountLetter = json['bank_account_letter'];
    others = json['others'];
    civilId = json['civil_id'];
    civilIdBack = json['civil_id_back'];
    themeColor = json['theme_color'];
    enableNewDesign = json['enable_new_design'];
    showAllCurrencies = json['show_all_currencies'];
    enableCardView = json['enable_card_view'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['country_id'] = this.countryId;
    data['phone_number_code_id'] = this.phoneNumberCodeId;
    data['business_type_id'] = this.businessTypeId;
    data['category_id'] = this.categoryId;
    data['invoice_expiry_after_number'] = this.invoiceExpiryAfterNumber;
    data['invoice_expiry_after_type_id'] = this.invoiceExpiryAfterTypeId;
    data['language_id'] = this.languageId;
    data['deposit_terms_id'] = this.depositTermsId;
    data['company_name'] = this.companyName;
    data['name_en'] = this.nameEn;
    data['name_ar'] = this.nameAr;
    data['logo'] = this.logo;
    data['website_url'] = this.websiteUrl;
    data['work_email'] = this.workEmail;
    data['phone_number'] = this.phoneNumber;
    data['custom_sms_ar'] = this.customSmsAr;
    data['custom_sms_en'] = this.customSmsEn;
    data['terms_and_conditions'] = this.termsAndConditions;
    data['products_delivery_fees'] = this.productsDeliveryFees;
    data['promo_code'] = this.promoCode;
    data['approval_status'] = this.approvalStatus;
    data['bank_account_name'] = this.bankAccountName;
    data['bank_name'] = this.bankName;
    data['account_number'] = this.accountNumber;
    data['iban'] = this.iban;
    data['bank_account_letter'] = this.bankAccountLetter;
    data['others'] = this.others;
    data['civil_id'] = this.civilId;
    data['civil_id_back'] = this.civilIdBack;
    data['theme_color'] = this.themeColor;
    data['enable_new_design'] = this.enableNewDesign;
    data['show_all_currencies'] = this.showAllCurrencies;
    data['enable_card_view'] = this.enableCardView;
    return data;
  }
}

ManageUserToPrint(
    {required ManageUser manageuser, required BuildContext context}) {
  double width = MediaQuery.of(context).size.width;
  return pw.Container(
    width: width,
    padding: pw.EdgeInsets.all(10),
    decoration: pw.BoxDecoration(
      color: PdfColor.fromHex("F8F8F8FF"),
      borderRadius: pw.BorderRadius.circular(10),
    ),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          (manageuser.fullName!),
          style: pw.TextStyle(
            color: PdfColor.fromHex("000000"),
            fontSize: 13.0.sp,
          ),
          textDirection: pw.TextDirection.rtl,
        ),
        pw.SizedBox(height: 10),
        pw.Text(
          (manageuser.email!),
          style: pw.TextStyle(
            color: PdfColor.fromHex("000000"),
            fontSize: 13.0.sp,
          ),
          textDirection: pw.TextDirection.rtl,
        ),
        pw.SizedBox(height: 10),
        pw.Text(
          (manageuser.phoneNumberManager.toString()),
          style: pw.TextStyle(
            color: PdfColor.fromHex("000000"),
            fontSize: 13.0.sp,
          ),
          textDirection: pw.TextDirection.rtl,
        ),
      ],
    ),
  );
}
