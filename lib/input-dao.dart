import 'dart:async';

import 'package:sqflite/sqflite.dart';

import 'db-helper.dart';

// Data Access Object
class BaseDAO {

  Future<Database> get db => DatabaseHelper.getInstance().db;

  Future<int> insert(Field field) async {
    var dbClient = await db;
    var id = await dbClient.insert("field", field.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  Future<List<Field>> findAll() async {
    final dbClient = await db;

    final list = await dbClient.rawQuery('select * from field');

    final sevico = list.map<Field>((json) => Field.fromMap(json)).toList();


    return sevico;
  }

  Future<Field> findById(int id) async {
    var dbClient = await db;
    final list =
        await dbClient.rawQuery('select * from field where id = ?', [id]);

    if (list.length > 0) {
      return new Field.fromMap(list.first);
    }

    return null;
  }

  Future<Field> findByField(int field,String input) async {
    var dbClient = await db;
    final list =
    await dbClient.rawQuery('select * from field where field$field = ?', [input]);

    if (list.length > 0) {
      return new Field.fromMap(list.first);
    }

    return null;
  }

  Future<bool> exists(Field field) async {
    Field c = await findById(field.id);
    var exists = c != null;
    return exists;
  }

  Future<int> count() async {
    final dbClient = await db;
    final list = await dbClient.rawQuery('select count(*) from field');
    return Sqflite.firstIntValue(list);
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.rawDelete('delete from field where id = ?', [id]);
  }

  Future<int> deleteAll() async {
    var dbClient = await db;
    return await dbClient.rawDelete('delete from field');
  }


  Future<int> update(Field field) async {
    var dbClient = await db;

    var update = await dbClient.update("field",field.toMap(),where: "id = ${field.id.toString()}");

    return update;

  }
}

class Field {

  int id;
  String field1;
  String field2;
  String field3;
  String field4;
  String field5;
  String field6;
  String field7;
  String field8;

  Field(this.field1, this.field2, this.field3, this.field4,
      this.field5, this.field6, this.field7, this.field8);

  
  Field.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    field1 = map["field1"];
    field2 = map['field2'];
    field3 = map['field3'];
    field4 = map['field4'];
    field5 = map['field5'];
    field6 = map['field6'];
    field7 = map['field7'];
    field8 = map['field8'];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      "id": id,
      "field1": field1,
      "field2": field2,
      "field3": field3,
      "field4": field4,
      "field5": field5,
      "field6": field6,
      "field7": field7,
      "field8": field8
    };
    return map;
  }



}

