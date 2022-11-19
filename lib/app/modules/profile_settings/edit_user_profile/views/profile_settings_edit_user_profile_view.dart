import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_settings_edit_user_profile_controller.dart';

class ProfileSettingsEditUserProfileView
    extends GetView<ProfileSettingsEditUserProfileController> {
  const ProfileSettingsEditUserProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubah Profile'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'ProfileSettingsEditUserProfileView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
