import 'package:discord_flutter/manager.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DiscordController>(() => DiscordController());
  }
}
