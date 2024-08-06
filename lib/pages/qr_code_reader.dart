
import 'dart:async';

import 'package:chatty/blocs/contact_bloc.dart';
import 'package:chatty/data/model/authentication_model.dart';
import 'package:chatty/pages/contact_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_mobile_vision/qr_camera.dart';

import '../data/model/authentication_model_impl.dart';
import '../data/model/social_model.dart';
import '../data/model/social_model_impl.dart';
import '../data/vos/user_vo.dart';


class QrCodeReader extends StatefulWidget {
  const QrCodeReader({super.key});

  @override
  State<QrCodeReader> createState() => _QrCodeReaderState();
}

class _QrCodeReaderState extends State<QrCodeReader> {

  String? qr;
  bool camState = false;
  bool dirState = false;  //
  String addedUserId = "";
  UserVO? addedUserVO;


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=> ContactBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Scan to add Contact'),
          actions: <Widget>[
            IconButton(icon: const Icon(Icons.light), onPressed: _swapBackLightState),
          ],
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  child: camState
                      ? Center(
                    child: Consumer<ContactBloc>(
                      builder: (context, bloc, child) => SizedBox(
                        width: 300.0,
                        height: 400.0,
                        child: QrCamera(
                          onError: (context, error) => Text(
                            error.toString(),
                            style: const TextStyle(color: Colors.red),
                          ),
                          cameraDirection:  CameraDirection.BACK ,
                          qrCodeCallback: (code) {
                            setState(() {
                              qr = code;
                              bloc.onAddContact(qr ?? "");
                              bloc.onAddContactToOtherUser(qr ?? "");
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                color: Colors.orange,
                                width: 10.0,
                                style: BorderStyle.solid,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                      : const Center(child: Text("Camera inactive"))),
              Text("QRCODE: $qr"),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Text(
              "on/off",
              textAlign: TextAlign.center,
            ),
            onPressed: () {
              setState(() {
                camState = !camState;
              });
            }),
      ),
    );
  }

  // void _onQRViewCreated(QRViewController controller) {
  //   StreamSubscription? subscription;
  //   UserVO? addedUserVO;
  //
  //   String addedUserId = "";
  //   setState(() {
  //     _controller = controller;
  //   });
    //
    // subscription = _controller?.scannedDataStream.listen((scanData) {
    //   print('Scanned data: ${scanData.code}');
    //   setState(() {
    //     addedUserId = scanData.code ?? "";
    //   });
    //   // Handle the scanned data as desired
    // });
    // subscription?.cancel();
    // ScaffoldMessenger.of(context)
    //     .showSnackBar(
    //     SnackBar(content: Text(" Scanned Successfully : ${addedUserId}")));
    //
    // String currUserId = _mAuthenticationModel
    //     .getLoggedInUser()
    //     .id!;
    //
    // _mSocialModel.getUserById(addedUserId)?.listen((userVO) {
    //   addedUserVO = userVO;
    // });
    //
    // if(addedUserId.isNotEmpty) {
    //   _mSocialModel.addNewContact(currUserId, addedUserVO!);
    // }
    // Navigator.pop(context);
  // }



  // Widget _buildQrView(BuildContext context) {
  //   // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
  //   var scanArea = (MediaQuery.of(context).size.width < 400 ||
  //       MediaQuery.of(context).size.height < 400)
  //       ? 150.0
  //       : 300.0;
  //   // To ensure the Scanner view is properly sizes after rotation
  //   // we need to listen for Flutter SizeChanged notification and update controller
  //   return QRView(
  //     key: _qrKey,
  //     onQRViewCreated: _onQRViewCreated,
  //     overlay: QrScannerOverlayShape(
  //         borderColor: Colors.red,
  //         borderRadius: 10,
  //         borderLength: 30,
  //         borderWidth: 10,
  //         cutOutSize: scanArea),
  //     onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
  //   );
  // }

  _swapBackLightState() async {
    QrCamera.toggleFlash();
  }

}
