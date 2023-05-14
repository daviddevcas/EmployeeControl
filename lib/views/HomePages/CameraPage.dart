import 'package:control_empleados_app/controllers/CameraController.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:control_empleados_app/components/ITitle.dart';
import 'package:control_empleados_app/tools/Pallete.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

class CameraPage extends StatelessWidget {
  CameraPage({Key? key}) : super(key: key);

  final CameraController _cameraController = CameraController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(width: 50),
            const Expanded(child: ITitleText(title: 'Escaner')),
            IconButton(
              padding: const EdgeInsets.all(10),
              icon: const Icon(
                Icons.logout,
                size: 30,
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'auth');
              },
            )
          ],
        ),
        const Divider(color: Colors.grey),
        Expanded(
            child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FittedBox(
                  child: GestureDetector(
                onTap: () {
                  FlutterBarcodeScanner.scanBarcode(
                          '#3D8BEF', 'Cancelar', false, ScanMode.QR)
                      .then((scan) {
                    _cameraController.insert(scan, 0).then((value) {
                      if (value['success']) {
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.success,
                          text: value['message'],
                        );
                      } else {
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.error,
                          title: 'Oops...',
                          text: value['message'],
                        );
                      }
                    });
                  });
                },
                child: Container(
                  width: 130,
                  height: 130,
                  decoration: const BoxDecoration(
                      color: Pallete.gradient1,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.camera_alt_outlined,
                          size: 40,
                          color: Pallete.whiteColor,
                        ),
                        Text(
                          'Entradas',
                          style: TextStyle(
                              color: Pallete.whiteColor, fontSize: 20),
                        )
                      ]),
                ),
              )),
              const SizedBox(
                height: 20,
                width: 20,
              ),
              FittedBox(
                  child: GestureDetector(
                onTap: () {
                  FlutterBarcodeScanner.scanBarcode(
                          '#3D8BEF', 'Cancelar', false, ScanMode.QR)
                      .then((scan) {
                    _cameraController.insert(scan, 1).then((value) {
                      if (value['success']) {
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.success,
                          text: value['message'],
                        );
                      } else {
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.error,
                          title: 'Oops...',
                          text: value['message'],
                        );
                      }
                    });
                  });
                },
                child: Container(
                  width: 130,
                  height: 130,
                  decoration: const BoxDecoration(
                      color: Pallete.gradient1,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.camera_alt_outlined,
                          size: 40,
                          color: Pallete.whiteColor,
                        ),
                        Text(
                          'Salidas',
                          style: TextStyle(
                              color: Pallete.whiteColor, fontSize: 20),
                        )
                      ]),
                ),
              ))
            ],
          ),
        ))
      ],
    );
  }
}
