import 'package:discord_flutter/manager.dart';
import 'package:discord_manager/discord_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'home_binding.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ExampleApp());
}

class ExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      smartManagement: SmartManagement.keepFactory,
      locale: Locale("en", "US"),
      getPages: [
        GetPage(
          name: '/home',
          page: () => HomePage(title: "Discord Auth Flutter"),
          binding: HomeBinding(),
        ),
      ],
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final String title;

  const HomePage({Key key, this.title}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;
  String guildId = "795445844618248233";
  static DiscordController discordController = Get.find();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            widget.title,
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MaterialButton(
                color: Colors.black,
                child: Text(
                  "Auth Grant",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  setState(() {
                    _isLoading = true;
                  });
                  await discordController.discordManager
                      .getAuthorizationGrant();
                  await discordController.discordManager.smartGetToken();
                  List<DiscordPartialGuild> guildIds =
                      await discordController.discordManager.getUsersMeGuilds();
                  if (guildIds.contains(guildId)) {
                    //TODO
                  } else {
                    Alert(
                        context: context,
                        title: 'Unauthorized!',
                        type: AlertType.error,
                        buttons: [
                          DialogButton(
                            child: Text(
                              "Go Back",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () => Navigator.pop(context),
                            color: Color.fromRGBO(0, 179, 134, 1.0),
                          ),
                        ]).show();
                    setState(() {
                      _isLoading = false;
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
