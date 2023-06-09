import 'package:control_empleados_app/services/DBProvider.dart';
import 'package:control_empleados_app/models/User.dart';
import 'package:intl/intl.dart';

class Record extends DBProvider {
  int id = 0;
  int userId = 0;
  //type = {0:inputs,1:outputs}
  int typeRecord = 0;
  DateTime createdAt = DateTime.now();
  User user = User();

  Record();

  Record.set(int userId, int typeRecord, DateTime createdAt);

  Record.fromMap(Map<String, dynamic> record) {
    id = record['id'];
    userId = record['userId'];
    typeRecord = record['typeRecord'];
    createdAt = DateTime.parse(record['createdAt']);
  }

  String dateToString() {
    final DateFormat formatter = DateFormat('dd-MM-yyyy HH:mm');
    return formatter.format(createdAt);
  }

  Map<String, dynamic> toMap({bool newrecord = false}) {
    return {
      if (!newrecord) 'id': id,
      'userId': userId,
      'typeRecord': typeRecord,
      'createdAt': createdAt.toString(),
    };
  }

  Future<User> readUser() async {
    final db = await DBProvider.openDB();

    final request = await db.query('users', where: 'id=?', whereArgs: [userId]);
    if (request.isNotEmpty) {
      return request.map((user) => User.fromMap(user)).toList()[0];
    } else {
      return User();
    }
  }

  static Future<List<Record>> readAll(int typeRecord,
      {bool isDiary = true}) async {
    final db = await DBProvider.openDB();
    final DateFormat formatter =
        isDiary ? DateFormat('yyyy-MM-dd') : DateFormat('yyyy-MM');
    List<Map<String, Object?>> request;
    if (typeRecord == -1) {
      request = await db.query(
        'records',
        where: 'createdAt LIKE ?',
        whereArgs: ['%${formatter.format(DateTime.now())}%'],
        orderBy: 'createdAt',
      );
    } else {
      request = await db.query(
        'records',
        where: 'typeRecord=? AND createdAt LIKE ?',
        whereArgs: [typeRecord, '%${formatter.format(DateTime.now())}%'],
        orderBy: 'createdAt',
      );
    }

    if (request.isNotEmpty) {
      return request.map((record) => Record.fromMap(record)).toList();
    } else {
      return [];
    }
  }

  static Future<List<Record>> readNonCompliance({bool isDiary = true}) async {
    final db = await DBProvider.openDB();
    final DateFormat formatter =
        isDiary ? DateFormat('yyyy-MM-dd') : DateFormat('yyyy-MM');

    final request = await db.query(
      'records',
      where:
          "((strftime('%H:%m',createdAt) > '09:00' AND typeRecord = 0) OR (strftime('%H:%m',createdAt) < '15:30' AND typeRecord = 1)) AND createdAt LIKE ?",
      whereArgs: ['%${formatter.format(DateTime.now())}%'],
      orderBy: 'createdAt',
    );

    if (request.isNotEmpty) {
      return request.map((record) => Record.fromMap(record)).toList();
    } else {
      return [];
    }
  }

  static Future<int> insert(Record record) async {
    final db = await DBProvider.openDB();
    return await db.insert('records', record.toMap(newrecord: true));
  }
}
