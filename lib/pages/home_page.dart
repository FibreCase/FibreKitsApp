import 'package:fibre_kits/function/snackbar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: [
          Card(
            
            child: ListTile(
              title: const Text('FibreKits'),
              subtitle: const Text('FibreCase的工具箱\nAlpha v0.1.0'),
              leading: const Icon(Icons.home),
              onTap: () {
                FloatingSnackbar.show(
                  context,
                  message: '收到了！',
                  duration: const Duration(seconds: 2),
                  icon: Icons.check_circle,
                  actionLabel: '好的',
                  onAction: () {
                    FloatingSnackbar.show(
                      context,
                      message: '别点了！收到了！',
                      duration: const Duration(seconds: 2),
                      icon: Icons.check_circle,
                      actionLabel: '确定',
                      onAction: () {},
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}