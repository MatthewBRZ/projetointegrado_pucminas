import 'package:get/get.dart';

import '../Models/Status.dart';

class CartInfoHeaderController extends GetxController {
  String digCommand;
  String localCommand;
  String orderStatus;
  String attendantName;

  CartInfoHeaderController({
    this.digCommand = 'Comanda Digital',
    this.localCommand = 'Comanda Física',
    this.orderStatus = 'Comanda Física',
    this.attendantName = 'Nome do atendente',
  });

  String get getDigCommand => digCommand;
  String get getLocalCommand => localCommand;
  String get getStatus => orderStatus;
  String get getAttendant => attendantName;

  set setDigCommand(String newDigCommand) {
    digCommand = newDigCommand;
  }

  set setLocalCommand(String newLocalCommand) {
    localCommand = newLocalCommand;
  }

  set setOrderStatus(Status newStatus) {
    switch (newStatus) {
      case Status.NA_FILA:
        orderStatus = 'NA FILA';
        break;
      case Status.EM_ATENDIMENTO:
        orderStatus = 'EM ATENDIMENTO';
        break;
      case Status.ATENDIDO:
        orderStatus = 'ATENDIDO';
        break;
      case Status.ENCERRADO:
        orderStatus = 'ENCERRADO';
        break;
    }
  }

  set setAttendant(String newAttendant) {
    attendantName = newAttendant;
  }
}
