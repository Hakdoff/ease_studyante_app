part of 'qr_code_scanner_bloc.dart';

abstract class QrCodeScannerEvent extends Equatable {
  const QrCodeScannerEvent();

  @override
  List<Object> get props => [];
}

class OnQRScanEvent extends QrCodeScannerEvent {
  final String id;

  const OnQRScanEvent({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}
