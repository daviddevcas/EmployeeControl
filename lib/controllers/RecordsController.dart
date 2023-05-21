import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:control_empleados_app/models/Record.dart';
import 'package:get/get.dart';

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
}
