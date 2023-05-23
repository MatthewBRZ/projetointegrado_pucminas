import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'ProductCatalog.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final isWeb = kIsWeb;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Padaria Bakery'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 125,
                backgroundImage: AssetImage('assets/images/bakery.png'),
                backgroundColor: Colors.transparent,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProductCatalog()));
                },
                child: const Text('Cardápio Digital'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                
                onPressed: () {
                  isWeb ? null : _onQRViewCreated(controller!);
                },
                child: (!isWeb) ? const Text('Ler QR Code') : const Text('Leitura de QR code apenas com smartphones'),
              ),
              const SizedBox(height: 16),
              Text(
                result != null ? 'Resultado: ${result!.code}' : 'Aguardando QR code...',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
