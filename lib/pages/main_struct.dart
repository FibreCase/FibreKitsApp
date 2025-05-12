import 'package:fibre_kits/pages/home_page.dart';
import 'package:fibre_kits/pages/messager_page.dart';
import 'package:fibre_kits/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainStruct extends StatelessWidget {
  const MainStruct({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('FibreKits', style: theme.textTheme.headlineMedium),
        centerTitle: true,
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'FibreKits',
                    style: theme.textTheme.headlineLarge?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                  Text(
                    "FibreCase的工具箱\nAlpha v0.1.0",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text('Messager'),
              subtitle: const Text('消息推送'),
              leading: const Icon(Icons.message),
              onTap: () {
                Get.back();
                Future.delayed(const Duration(milliseconds: 100), () {
                  Get.to(
                  () => const MessagerPage(),
                  transition: Transition.rightToLeft,
                  duration: const Duration(milliseconds: 300),
                  );
                });
              },
            ),
            const Divider(),
            ListTile(
              title: const Text('Settings'),
              subtitle: const Text('设置'),
              leading: const Icon(Icons.settings),
              onTap: () {
                Get.back();
                Future.delayed(const Duration(milliseconds: 100), () {
                  Get.to(
                  () => const SettingsPage(),
                  transition: Transition.rightToLeft,
                  duration: const Duration(milliseconds: 300),
                  );
                });
              },
            ),
          ],
        ),
      ),

      body: const HomePage(),
    );
  }
}
