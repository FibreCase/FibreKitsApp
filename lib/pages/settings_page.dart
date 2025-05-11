import 'package:fibre_kits/function/snackbar.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 200.0,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text('Settings'),
              centerTitle: true,
              expandedTitleScale: 2, 
            ),
          ),
          SliverFillRemaining(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ListTile(
                  title: const Text('About'),
                  subtitle: const Text('关于本应用程序'),
                  leading: const Icon(Icons.info),
                  onTap: () {},
                ),
                ListTile(
                  title: Text('Snackbar Test'),
                  subtitle: Text('测试 Snackbar'),
                  leading: Icon(Icons.text_snippet),
                  onTap: () => FloatingSnackbar.show(
                    context,
                    message: 'Snackbar 测试消息',
                    duration: const Duration(seconds: 2),
                    icon: Icons.check_circle,
                    actionLabel: '确定',
                    onAction: () {
                      print('Snackbar action clicked');
                    },
                  ),
                ),
                ListTile(
                  title: Text('Snackbar Warning Test'),
                  subtitle: Text('测试 Snackbar 警告'),
                  leading: Icon(Icons.warning),
                  onTap: () => FloatingSnackbar.show(
                    context,
                    message: 'Snackbar 警告消息',
                    duration: const Duration(seconds: 2),
                    backgroundColor: theme.colorScheme.error,
                    textColor: theme.colorScheme.onError,
                    actionTextColor: theme.colorScheme.onError,
                    icon: Icons.warning,
                    actionLabel: '确定',
                    onAction: () {
                      print('Snackbar action clicked');
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
