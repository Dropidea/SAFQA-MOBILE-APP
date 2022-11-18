import 'package:flutter/material.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/profile/pr_bank_details.dart';
import 'package:safqa/widgets/circular_go_btn.dart';
import 'package:safqa/widgets/custom_drop_down.dart';
import 'package:safqa/widgets/signup_text_field.dart';

class AddAddressPage extends StatelessWidget {
  const AddAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: WhiteAppBar(title: "Create Address"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            blackText("Address Type", 15),
            CustomDropdown(
              width: w,
              items: ["1", "2"],
              onchanged: (s) {},
              hint: "choose",
            ),
            SizedBox(height: 20),
            blackText("City", 15),
            CustomDropdown(
              width: w,
              items: ["1", "2"],
              onchanged: (s) {},
              hint: "choose",
            ),
            SizedBox(height: 20),
            blackText("Area", 15),
            CustomDropdown(
              width: w,
              items: ["1", "2"],
              onchanged: (s) {},
              hint: "choose",
            ),
            SizedBox(height: 20),
            blackText("block", 15),
            SignUpTextField(padding: EdgeInsets.all(0)),
            SizedBox(height: 20),
            blackText("Avenue", 15),
            SignUpTextField(padding: EdgeInsets.all(0)),
            SizedBox(height: 20),
            blackText("Street", 15),
            SignUpTextField(padding: EdgeInsets.all(0)),
            SizedBox(height: 20),
            Row(
              children: [
                blackText("House/Bldg No.", 15),
                SizedBox(width: 10),
                greyText("(Optional)", 13)
              ],
            ),
            SignUpTextField(padding: EdgeInsets.all(0)),
            SizedBox(height: 20),
            Row(
              children: [
                blackText("Appartment", 15),
                SizedBox(width: 10),
                greyText("(Optional)", 13)
              ],
            ),
            SignUpTextField(padding: EdgeInsets.all(0)),
            SizedBox(height: 20),
            Row(
              children: [
                blackText("Floor", 15),
                SizedBox(width: 10),
                greyText("(Optional)", 13)
              ],
            ),
            SignUpTextField(padding: EdgeInsets.all(0)),
            SizedBox(height: 20),
            Row(
              children: [
                blackText("Instructions", 15),
                SizedBox(width: 10),
                greyText("(Optional)", 13)
              ],
            ),
            SignUpTextField(padding: EdgeInsets.all(0)),
            SizedBox(height: 50),
            CircularGoBTN(
              text: "Create",
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}
