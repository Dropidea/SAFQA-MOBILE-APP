import 'package:flutter/material.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/menu_pages/settings/tabs/subtabs/api.dart';
import 'package:safqa/pages/home/menu_pages/settings/tabs/subtabs/webhook.dart';

class IntegrationTab extends StatefulWidget {
  IntegrationTab({super.key});

  @override
  State<IntegrationTab> createState() => _IntegrationTabState();
}

class _IntegrationTabState extends State<IntegrationTab>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 80),
        Stack(
          fit: StackFit.passthrough,
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade300, width: 2.0),
                ),
              ),
            ),
            TabBar(
              controller: tabController,
              // indicatorColor: Color(0xff2F6782),

              tabs: [
                Tab(
                  child: tabController.index == 0
                      ? blueText("API Key", 14, fontWeight: FontWeight.bold)
                      : greyText("API Key", 13),
                ),
                Tab(
                  child: tabController.index == 1
                      ? blueText("Webhook Setting", 14,
                          fontWeight: FontWeight.bold)
                      : greyText("Webhook Setting", 13),
                ),
              ],
              onTap: (value) => setState(() {}),
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: [
              APITab(),
              WebhookTab(),
            ],
          ),
        ),
      ],
    );
  }
}
