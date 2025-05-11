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
              onTap: () {},
            ),
          )
        ],
      ),
    );
  }
}