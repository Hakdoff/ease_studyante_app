import 'package:equatable/equatable.dart';

abstract class QrPracticeScannerEvent extends Equatable {
  const QrPracticeScannerEvent();

  @override
  List<Object> get props => [];
}

class OnQrPracticeScanEvent extends QrPracticeScannerEvent {
  final String id;

  const OnQrPracticeScanEvent({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}
