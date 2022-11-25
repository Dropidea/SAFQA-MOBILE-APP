import 'package:flutter/material.dart';
import 'package:getwidget/components/radio/gf_radio.dart';
import 'package:getwidget/getwidget.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/widgets/custom_drop_down.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import 'package:safqa/widgets/wallpapered_BTN.dart';

class WebhookTab extends StatefulWidget {
  const WebhookTab({super.key});

  @override
  State<WebhookTab> createState() => _WebhookTabState();
}

class _WebhookTabState extends State<WebhookTab> {
  int enableWebhook = 0;

  int enableSecretKey = 0;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(height: 20),
        blackText("Enable Webhook", 15),
        SizedBox(height: 10),
        Row(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 7),
                  child: GFRadio(
                      activeBorderColor: Colors.transparent,
                      inactiveBorderColor: Colors.transparent,
                      radioColor: Color(0xff66B4D2),
                      inactiveIcon: Icon(
                        Icons.circle_outlined,
                        color: Colors.grey.shade300,
                      ),
                      size: GFSize.SMALL,
                      value: 0,
                      groupValue: enableWebhook,
                      onChanged: (value) {
                        setState(
                          () {
                            enableWebhook = value;
                          },
                        );
                      }),
                ),
                greyText("Yes", 16),
              ],
            ),
            SizedBox(width: 30),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 7),
                  child: GFRadio(
                      activeBorderColor: Colors.transparent,
                      radioColor: Color(0xff66B4D2),
                      inactiveIcon: Icon(
                        Icons.circle_outlined,
                        color: Colors.grey.shade300,
                      ),
                      size: GFSize.SMALL,
                      inactiveBorderColor: Colors.transparent,
                      value: 1,
                      groupValue: enableWebhook,
                      onChanged: (value) {
                        setState(
                          () {
                            enableWebhook = value;
                          },
                        );
                      }),
                ),
                greyText("No", 16),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        blackText("Endpoint", 15),
        SignUpTextField(
          padding: EdgeInsets.all(0),
        ),
        const SizedBox(height: 20),
        blackText("Enable Secret Key", 15),
        SizedBox(height: 10),
        Row(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 7),
                  child: GFRadio(
                      activeBorderColor: Colors.transparent,
                      inactiveBorderColor: Colors.transparent,
                      radioColor: Color(0xff66B4D2),
                      inactiveIcon: Icon(
                        Icons.circle_outlined,
                        color: Colors.grey.shade300,
                      ),
                      size: GFSize.SMALL,
                      value: 0,
                      groupValue: enableSecretKey,
                      onChanged: (value) {
                        setState(
                          () {
                            enableSecretKey = value;
                          },
                        );
                      }),
                ),
                greyText("Yes", 16),
              ],
            ),
            SizedBox(width: 30),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 7),
                  child: GFRadio(
                      activeBorderColor: Colors.transparent,
                      radioColor: Color(0xff66B4D2),
                      inactiveIcon: Icon(
                        Icons.circle_outlined,
                        color: Colors.grey.shade300,
                      ),
                      size: GFSize.SMALL,
                      inactiveBorderColor: Colors.transparent,
                      value: 1,
                      groupValue: enableSecretKey,
                      onChanged: (value) {
                        setState(
                          () {
                            enableSecretKey = value;
                          },
                        );
                      }),
                ),
                greyText("No", 16),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        blackText("Webhook Events", 15),
        CustomDropdown(
          width: w,
          items: ["item1", "item2"],
          onchanged: (s) {},
          hint: "Choose",
        ),
        const SizedBox(height: 50),
        WallpepredBTN(
          text: "Save",
          width: 0.7 * w,
        ),
      ]),
    );
  }
}
