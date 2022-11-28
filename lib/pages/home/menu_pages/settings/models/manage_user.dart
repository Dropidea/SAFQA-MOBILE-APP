class ManageUser {
  int? id;
  int? roleId;
  int? profileBusinessId;
  int? phoneNumberCodeManagerId;
  String? phoneNumberManager;
  String? email;
  String? fullName;
  int? nationalityId;
  int? isEnable;
  String? avatar;
  int? enableBellSound;
  int? confirmEmail;
  int? confirmPhone;
  int? batchInvoices;
  int? deposits;
  int? paymentLinks;
  int? profile;
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
  int? notificationCreateInvoice;
  int? notificationInvoicePaid;
  int? notificationNewOrder;
  int? notificationCreateBatchInvoice;
  int? notificationDeposit;
  int? notificationCreateRecurringInvoice;
  int? notificationRefundTransfered;
  int? notificationNotificationsServiceRequest;
  int? notificationNotificationsHourlyDepositRejected;
  int? notificationApproveVendorAccount;
  int? notificationCreateShippingInvoice;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  Nationality? nationality;
  UserRole? userRole;

  ManageUser(
      {this.id,
      this.roleId,
      this.profileBusinessId,
      this.phoneNumberCodeManagerId,
      this.phoneNumberManager,
      this.email,
      this.fullName,
      this.nationalityId,
      this.isEnable,
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
      this.notificationCreateInvoice,
      this.notificationInvoicePaid,
      this.notificationNewOrder,
      this.notificationCreateBatchInvoice,
      this.notificationDeposit,
      this.notificationCreateRecurringInvoice,
      this.notificationRefundTransfered,
      this.notificationNotificationsServiceRequest,
      this.notificationNotificationsHourlyDepositRejected,
      this.notificationApproveVendorAccount,
      this.notificationCreateShippingInvoice,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt,
      this.nationality,
      this.userRole});

  ManageUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roleId = json['role_id'];
    profileBusinessId = json['profile_business_id'];
    phoneNumberCodeManagerId = json['phone_number_code_manager_id'];
    phoneNumberManager = json['phone_number_manager'];
    email = json['email'];
    fullName = json['full_name'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['role_id'] = this.roleId;
    data['profile_business_id'] = this.profileBusinessId;
    data['phone_number_code_manager_id'] = this.phoneNumberCodeManagerId;
    data['phone_number_manager'] = this.phoneNumberManager;
    data['email'] = this.email;
    data['full_name'] = this.fullName;
    data['nationality_id'] = this.nationalityId;
    data['is_enable'] = this.isEnable;
    data['avatar'] = this.avatar;
    data['enable_bell_sound'] = this.enableBellSound;
    data['confirm_email'] = this.confirmEmail;
    data['confirm_phone'] = this.confirmPhone;
    data['batch_invoices'] = this.batchInvoices;
    data['deposits'] = this.deposits;
    data['payment_links'] = this.paymentLinks;
    data['profile'] = this.profile;
    data['users'] = this.users;
    data['refund'] = this.refund;
    data['show_all_invoices'] = this.showAllInvoices;
    data['customers'] = this.customers;
    data['invoices'] = this.invoices;
    data['products'] = this.products;
    data['commissions'] = this.commissions;
    data['account_statements'] = this.accountStatements;
    data['orders'] = this.orders;
    data['suppliers'] = this.suppliers;
    data['notification_create_invoice'] = this.notificationCreateInvoice;
    data['notification_invoice_paid'] = this.notificationInvoicePaid;
    data['notification_new_order'] = this.notificationNewOrder;
    data['notification_create_batch_invoice'] =
        this.notificationCreateBatchInvoice;
    data['notification_deposit'] = this.notificationDeposit;
    data['notification_create_recurring_invoice'] =
        this.notificationCreateRecurringInvoice;
    data['notification_refund_transfered'] = this.notificationRefundTransfered;
    data['notification_notifications_service_request'] =
        this.notificationNotificationsServiceRequest;
    data['notification_notifications_hourly_deposit_rejected'] =
        this.notificationNotificationsHourlyDepositRejected;
    data['notification_approve_vendor_account'] =
        this.notificationApproveVendorAccount;
    data['notification_create_shipping_invoice'] =
        this.notificationCreateShippingInvoice;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.nationality != null) {
      data['nationality'] = this.nationality!.toJson();
    }
    if (this.userRole != null) {
      data['user_role'] = this.userRole!.toJson();
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
