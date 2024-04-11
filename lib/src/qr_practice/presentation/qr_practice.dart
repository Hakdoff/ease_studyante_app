import 'dart:io';
import 'package:ease_studyante_app/core/common_widget/common_widget.dart';
import 'package:ease_studyante_app/gen/colors.gen.dart';

import 'package:ease_studyante_app/src/qr_practice/data/data_sources/qr_practice_repository_impl.dart';
import 'package:ease_studyante_app/src/qr_practice/presentation/bloc/qr_practice_scanner_bloc.dart';
import 'package:ease_studyante_app/src/qr_practice/presentation/bloc/qr_practice_scanner_event.dart';
import 'package:ease_studyante_app/src/qr_practice/presentation/bloc/qr_practice_scanner_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:gap/gap.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/error_custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class QrPractice extends StatefulWidget {
  static const String routeName = 'teacher/qr-code-scanner';

  const QrPractice({super.key});

  @override
  State<QrPractice> createState() => _QrPracticeState();
}

class _QrPracticeState extends State<QrPractice> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRPracticeBloc qrPracticeBloc;
  Barcode? result;
  QRViewController? controller;
  bool isHideScanner = false;

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
    qrPracticeBloc = QRPracticeBloc(QRPracticeRepositoryImpl());
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => qrPracticeBloc,
      child: ProgressHUD(child: Builder(
        builder: (context) {
          final progressHUD = ProgressHUD.of(context);

          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocListener<QRPracticeBloc, QrPracticceScannerState>(
                listener: (context, state) {
                  if (state is QrPracticeScannerLoading) {
                    progressHUD?.show();
                    return;
                  }
                  progressHUD?.dismiss();
                  // if (state is QrPracticeScannerLoaded) {
                  //   setState(() {
                  //     isHideScanner = true;
                  //   });
                  //   final message =
                  //       '${state.errorMessage != null ? '${state.errorMessage}\n' : 'Successfully time in\n'}${state.attendance.student.user.lastName},${state.attendance.student.user.firstName}';
                  //   handleSuccessMessage(message);
                  // }
                  if (state is QrPracticeScannerLoaded &&
                      state.errorMessage != null) {
                    setState(() {
                      isHideScanner = true;
                    });
                    final message =
                        '${state.errorMessage}\n${state.attendance.student.user.lastName},${state.attendance.student.user.firstName}';
                    handleTimeMessage(message);
                  }

                  if (state is QrPracticeScannerLoaded &&
                      state.errorMessage == null) {
                    setState(() {
                      isHideScanner = true;
                    });
                    final message =
                        'Successfully time in\n${state.attendance.student.user.lastName},${state.attendance.student.user.firstName}';
                    handleSuccessMessage(message);
                  }
                  if (state is QrPracticeErrorState) {
                    setState(() {
                      isHideScanner = true;
                    });
                    handleErrorMessage(state.errorMessage);
                  }
                },
                child: Column(children: <Widget>[
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
                  const Expanded(
                      child: Column(
                    children: [
                      Expanded(
                        child: CustomText(text: 'QR Code Scanner'),
                      ),
                    ],
                  )),
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
                      },
                    ),
                  ],
                  const Gap(60)
                ]),
              ));
        },
      )),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (scanData.code != null) {
        controller.stopCamera();
        qrPracticeBloc.add(OnQrPracticeScanEvent(id: scanData.code!));
      }
    });
  }

  void handleTimeMessage(String message) {
    showTopSnackBar(
        Overlay.of(context), ErrorCustomSnackBar.success(message: message));
  }

  void handleSuccessMessage(String message) {
    showTopSnackBar(
        Overlay.of(context), CustomSnackBar.success(message: message));
  }

  void handleErrorMessage(String errorMessage) {
    showTopSnackBar(
        Overlay.of(context), CustomSnackBar.error(message: errorMessage));
  }
}
