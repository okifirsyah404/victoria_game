import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:victoria_game/app/modules/global/themes/colors_theme.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const FaIcon(FontAwesomeIcons.arrowLeft),
        ),
        title: const Text(
          'HomeView',
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const FaIcon(FontAwesomeIcons.plus),
          ),
          IconButton(
            onPressed: () {},
            icon: const FaIcon(FontAwesomeIcons.bars),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'HomeView is working',
                  style: TextStyle(fontSize: 20),
                ),
                const Text(
                  'HomeView is working',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                const Text(
                  'abcdefghijklmnopqrstuvwxyz',
                  style: TextStyle(fontSize: 20),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const FaIcon(FontAwesomeIcons.key),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Elevated Button"),
                ),
                SizedBox(height: 20),
                OutlinedButton(
                  onPressed: () {},
                  child: Text("Outlined Button"),
                ),
                SizedBox(height: 20),
                OutlinedButton(
                  onPressed: () {},
                  child: Text("Outlined Button"),
                  style: OutlinedButton.styleFrom(
                      side: BorderSide(
                    color: ColorsTheme.primaryColor,
                  )),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {},
                  child: Text("Text Button"),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {},
                  child: Text("Text Button"),
                  style: TextButton.styleFrom(
                    foregroundColor: ColorsTheme.errorColor,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {},
                  label: Text("Elevated Button Icon"),
                  icon: const FaIcon(FontAwesomeIcons.plus),
                ),
                SizedBox(height: 20),
                OutlinedButton.icon(
                  onPressed: () {},
                  label: Text("Outlined Button Icon"),
                  icon: const FaIcon(FontAwesomeIcons.plus),
                  style: OutlinedButton.styleFrom(
                      side: BorderSide(
                    color: ColorsTheme.primaryColor,
                  )),
                ),
                SizedBox(height: 20),
                TextButton.icon(
                  onPressed: () {},
                  label: Text("Text Button Icon"),
                  icon: const FaIcon(FontAwesomeIcons.plus),
                ),
                SizedBox(height: 20),
                Card(
                  elevation: 1,
                  child: Container(
                    height: 40,
                    width: 100,
                    child: Center(
                      child: Text(
                        "Card",
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 40,
                  width: 100,
                  child: Center(
                    child: Text("Container"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      label: Text("234"),
                      prefixIcon: FaIcon(FontAwesomeIcons.mailchimp),
                      enabledBorder: OutlineInputBorder(),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
