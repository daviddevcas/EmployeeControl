class User {
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
}
