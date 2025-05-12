import 'package:fibre_kits/get/controllers.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:get/get.dart';

class ScanPage extends StatelessWidget {
  const ScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    StringController scanResultStringController = Get.put(
      StringController(),
      tag: 'scanResult',
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Scan Page')),
      body: ListView(
        children: [
          Obx(
            () => ListTile(
              title: const Text('Scan QR Code'),
              subtitle: Text(scanResultStringController.stringValue.value),
              leading: const Icon(Icons.qr_code_scanner),
              onTap: () async {
                scanResultStringController.updateString('');
                final result = await showDialog<String>(
                  context: context,
                  builder: (context) => ScanAlone(),
                );
                if (result != null) {
                  scanResultStringController.updateString(result);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ScanAlone extends StatelessWidget {
  const ScanAlone({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan Alone')),
      body: MobileScanner(
        controller: MobileScannerController(autoStart: true),
        onDetect: (barcode) {
          // for (final barcode in barcode.barcodes) {
          //   if (barcode.rawValue != null) {
          //     final String code = barcode.rawValue!;
          //   }
          // }
          Navigator.of(context).pop(barcode.barcodes.first.rawValue);
        },
      ),
    );
  }
}
