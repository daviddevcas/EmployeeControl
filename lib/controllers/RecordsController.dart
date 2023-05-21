import 'package:control_empleados_app/services/FileStorage.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:control_empleados_app/models/Record.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class RecordsController extends GetxController {
  var expandedTileControllerInputs =
      ExpandedTileController(isExpanded: false).obs;
  var expandedTileControllerOutputs =
      ExpandedTileController(isExpanded: false).obs;
  var inputs = <Record>[].obs;
  var outputs = <Record>[].obs;
  var active = false.obs;

  Future readAll() async {
    inputs.value = await Record.readAll(0);
    for (var element in inputs.value) {
      element.user = await element.readUser();
    }

    outputs.value = await Record.readAll(1);
    for (var element in outputs.value) {
      element.user = await element.readUser();
    }
  }

  Future createExcelOfGeneralRecords({bool isDiary = true}) async {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];
    final List<Record> records = await Record.readAll(0);
    records.addAll(await Record.readAll(1));
    sheet
        .getRangeByIndex(1, 1)
        .setText('AYUNTAMIENTO CONSTITUCIONAL DE ESPINAL');
    sheet.getRangeByIndex(2, 1).setText(
        'CONTROL ${isDiary ? 'DIARIO' : 'MENSUAL'} DE ENTRADAS Y SALIDAS');
    sheet
        .getRangeByIndex(2, 4)
        .setText('FECHA: ${formatter.format(DateTime.now())}');

    if (isDiary) {
      sheet.getRangeByIndex(4, 1).setText('NOMBRE');
      sheet.getRangeByIndex(4, 2).setText('ÁREA');
      sheet.getRangeByIndex(4, 3).setText('CARGO');
      sheet.getRangeByIndex(4, 4).setText('ACCIÓN');
      sheet.getRangeByIndex(4, 5).setText('HORA');

      for (var i = 0; i < records.length; i++) {
        final item = records[i];
        sheet.getRangeByIndex(i + 5, 1).setText(item.user.name);
        sheet.getRangeByIndex(i + 5, 2).setText(item.user.area);
        sheet.getRangeByIndex(i + 5, 3).setText(item.user.workplace);
        sheet
            .getRangeByIndex(i + 5, 4)
            .setText(item.typeRecord == 0 ? 'ENTRADA' : 'SALIDA');
        sheet.getRangeByIndex(i + 5, 5).setText(item.dateToString());
      }
    } else {}

    final List<int> bytes = workbook.saveAsStream();
    await FileStorage.writeCounter(bytes.toString(), "Reportes generales.xlsx");
    workbook.dispose();
  }
}
