import 'package:discord_manager/discord_manager.dart';
import 'package:get/get.dart';

class DiscordController extends GetxController {
  Rx<DiscordManager> _discordManager = DiscordManager(
      clientId: "806289572237279262",
      clientSecret: "GmogB0RKuscJl9sz5XOzx4kK3x-c7s6n",
      redirectUrl: "appname://auth",
      scopes: [DiscordScope.Identify, DiscordScope.Guilds]).obs;

  Rx<DiscordUser> _discordUser = Rx<DiscordUser>();

  get discordManager => _discordManager.value;

  DiscordUser get discordUser => _discordUser.value;
  set discordUser(newValue) => _discordUser.value = newValue;
}
