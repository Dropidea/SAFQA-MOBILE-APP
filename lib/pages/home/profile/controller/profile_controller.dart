import 'package:get/get.dart';

class ProfileController extends GetxController {
  List<SocialMediaItem> socialMediaItems = [];
  void addSocialMediaItem(SocialMediaItem item) {
    socialMediaItems.add(item);
    update();
  }

  void deleteSocialMediaItem(int index) {
    socialMediaItems.removeAt(index);
    update();
  }
}

class SocialMediaItem {
  final String? name;
  final String? link;

  SocialMediaItem({
    required this.name,
    required this.link,
  });
}
