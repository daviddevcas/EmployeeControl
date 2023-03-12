import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:get/get.dart';

class RecordsController extends GetxController {
  var expandedTileControllerInputs =
      ExpandedTileController(isExpanded: true).obs;
  var expandedTileControllerOutputs =
      ExpandedTileController(isExpanded: true).obs;
}
