import 'package:control_empleados_app/services/DBProvider.dart';

class User extends DBProvider {
  int id = 0;
  String name = "";
  String lastname = "";
  String phone = "";
  String address = "";
  String area = "";
  String workplace = "";
  String? photopath;
  int age = 0;

  void reload() {
    id = 0;
    name = "";
    lastname = "";
    phone = "";
    address = "";
    area = "";
    workplace = "";
    photopath = null;
    age = 0;
  }

  User();

  User.fromMap(Map<String, dynamic> user) {
    id = user['id'];
    name = user['name'];
    lastname = user['lastname'];
    phone = user['phone'];
    address = user['address'];
    area = user['area'];
    workplace = user['workplace'];
    photopath = user['photopath'];
    age = user['age'];
  }

  Map<String, dynamic> toMap({bool newuser = false}) {
    return {
      if (!newuser) 'id': id,
      'name': name,
      'lastname': lastname,
      'phone': phone,
      'address': address,
      'area': area,
      'workplace': workplace,
      'photopath': photopath,
      'age': age
    };
  }

  Future<int> update() async {
    final db = await DBProvider.openDB();
    return await db.update('users', toMap(), where: 'id=?', whereArgs: [id]);
  }

  Future<int> delete() async {
    final db = await DBProvider.openDB();
    return await db.delete('users', where: 'id=?', whereArgs: [id]);
  }

  static Future<List<User>> readAll() async {
    final db = await DBProvider.openDB();

    final request = await db.query('users');

    if (request.isNotEmpty) {
      return request.map((user) => User.fromMap(user)).toList();
    } else {
      return [];
    }
  }

  static Future<int> insert(User user) async {
    final db = await DBProvider.openDB();
    return await db.insert('users', user.toMap(newuser: true));
  }
}
