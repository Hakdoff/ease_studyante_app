import 'dart:io';

import 'package:ease_studyante_app/core/common_widget/common_widget.dart';
import 'package:ease_studyante_app/gen/colors.gen.dart';
import 'package:ease_studyante_app/src/teacher/pages/qr_code/data/data_sources/qr_repository_impl.dart';
import 'package:ease_studyante_app/src/teacher/pages/qr_code/presentation/bloc/qr_code_scanner_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:gap/gap.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class TeacherQRCodeScanner extends StatefulWidget {
  static const String routeName = 'teacher/qr-code-scanner';

  const TeacherQRCodeScanner({super.key});

  @override
  State<TeacherQRCodeScanner> createState() => _TeacherQRCodeScannerState();
}

class _TeacherQRCodeScannerState extends State<TeacherQRCodeScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QrCodeScannerBloc qrCodeScannerBloc;
  Barcode? result;
  QRViewController? controller;
  bool isHideScanner = false;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  void initState() {
    super.initState();
    qrCodeScannerBloc = QrCodeScannerBloc(QRRepositoryImpl());
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => qrCodeScannerBloc,
      child: ProgressHUD(
        child: Builder(builder: (context) {
          final progressHUD = ProgressHUD.of(context);

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocListener<QrCodeScannerBloc, QrCodeScannerState>(
              listener: (context, state) {
                if (state is QrCodeScannerLoading) {
                  progressHUD?.show();
                  return;
                }
                progressHUD?.dismiss();
                if (state is QrCodeScannerLoaded) {
                  setState(() {
                    isHideScanner = true;
                  });
                  final message =
                      '${state.errorMessage != null ? '${state.errorMessage}\n' : 'Successfully time in\n'}${state.attendance.student.user.lastName}, ${state.attendance.student.user.firstName}';
                  handleSuccessMessage(message);
                }
                if (state is QrCodeErrorState) {
                  setState(() {
                    isHideScanner = true;
                  });
                  handleErrorMessage(state.errorMessage);
                }
              },
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: QRView(
                        key: qrKey,
                        overlay: QrScannerOverlayShape(
                          borderColor: ColorName.primary,
                          borderRadius: 10,
                          borderWidth: 10,
                          cutOutSize: MediaQuery.of(context).size.width * 0.75,
                          borderLength:
                              MediaQuery.of(context).size.width * 0.15,
                        ),
                        onQRViewCreated: _onQRViewCreated,
                      ),
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                    child: Column(
                      children: [
                        const Expanded(
                          child: CustomText(
                            text:
                                'QR code info: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam',
                          ),
                        ),
                        if (isHideScanner) ...[
                          CustomBtn(
                              label: 'Scan Again',
                              onTap: () {
                                if (controller != null) {
                                  controller?.resumeCamera();
                                }
                                setState(() {
                                  isHideScanner = false;
                                });
                              }),
                        ],
                        const Gap(60),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (scanData.code != null) {
        controller.stopCamera();
        qrCodeScannerBloc.add(OnQRScanEvent(id: scanData.code!));
      }
    });
  }

  void handleErrorMessage(String errorMessage) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.error(
        message: errorMessage,
      ),
    );
  }

  void handleSuccessMessage(String message) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.success(
        message: message,
      ),
    );
  }
}
