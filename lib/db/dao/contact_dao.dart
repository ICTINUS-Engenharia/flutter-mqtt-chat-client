import 'package:flutter_mqtt/db/database.dart';
import 'package:flutter_mqtt/db/tables/ContactTable.dart';
import 'package:flutter_mqtt/db/tables/UserTable.dart';
import 'package:moor/moor.dart';
part 'contact_dao.g.dart';

@UseDao(tables: [Contacts])
class ContactDao extends DatabaseAccessor<MyDatabase> with _$ContactDaoMixin {
  final MyDatabase db;

  ContactDao(this.db) : super(db);
  //==========Contacts==========//
  Future<int> addContact(DbContact cts) {
    return into(contacts).insertOnConflictUpdate(cts);
  }

  Stream<List<DbContact>> getAllContactsAsync() {
    return (select(contacts)).watch();
  }

  Future<List<DbContact>> getAllContacts() {
    return (select(contacts)).get();
  }

  Future<void> deleteAllContacts() {
    return delete(contacts).go();
  }
}
