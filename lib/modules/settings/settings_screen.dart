import 'package:flutter/material.dart';

import '../../shared/components/component.dart';
import '../../shared/network/local/cache_helper.dart';
import '../login/shop_login_screen.dart';
import '../update_profile/update_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              navigateTo(context, UpDateScreen());
            },
            child: Row(
              children: const [
                Icon(
                  Icons.person,
                ),
                SizedBox(
                  width: 20.0,
                ),
                Text(
                  'UpData Profile',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          TextButton(
            onPressed: () {
              CacheHelper.removeData(
                key: 'token',
              ).then((value) {
                if (value) {
                  navigateAndFinish(context, ShopLoginScreen());
                }
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Logout',
                ),
                SizedBox(
                  width: 5.0,
                ),
                Icon(
                  Icons.logout,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
