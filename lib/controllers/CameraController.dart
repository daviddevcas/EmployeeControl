import 'package:control_empleados_app/models/Record.dart';
import 'package:control_empleados_app/models/User.dart';
import 'package:get/get.dart';

class CameraController {
  Future<Map<String, dynamic>> insert(String scan, int typeRecord) async {
    if (!scan.isNum) {
      return {"success": false, "message": 'Lo siento, ha ocurrido un error.'};
    }

    var user = await User.readById(int.parse(scan));
    if (user == null) {
      return {
        "success": false,
        "message":
            'Lo siento, ha ocurrido un error. No se ha encontrado al usuario.'
      };
    }

    Record record = Record.set(user.id, typeRecord, DateTime.now());
    await Record.insert(record);
    return {"success": true, "message": 'Registro completado.'};
  }
}
