import 'package:crowdilm/models/aya.dart';
import 'package:crowdilm/models/quran_line.dart';
import 'package:flutter/services.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:path_provider/path_provider.dart';
import '../models/line.dart';
import '../models/quran.dart';
import '../models/sura.dart';

class CrowdilmDatabase {
  String directory = '';
  Database? database;

  Future open() async {
    directory = (await getApplicationDocumentsDirectory()).path;
    database = sqlite3.open('$directory/crowdilm.db');
    await buildTables('assets/db/line.sql');
    await buildTables('assets/db/quran.sql');
    await buildTables('assets/db/quran_line.sql');
    await buildTables('assets/db/sura.sql');
    await buildTables('assets/db/setting.sql');
  }

  buildTables(String path) async {
    var script = await rootBundle.loadString(path);
    database!.execute(script);
  }

  addQurans(List<Quran> qurans) {
    var query = database!.prepare('insert or ignore into quran(id, language, name, name_english, quran_type) values (?,?,?,?,?);');
    for (var quran in qurans) {
      query.execute([quran.id, quran.language, quran.name, quran.nameEnglish, quran.quranType]);
    }
  }

  List<Quran> getQurans() {
    var resultSet = database!.select('select * from quran order by quran_type, language, name;');
    List<Quran> qurans = [];
    for (var result in resultSet) {
      qurans.add(Quran(result['id'], result['language'], result['name'], result['name_english'], result['quran_type']));
    }
    return qurans;
  }

  addLines(List<Line> lines) {
    const queryString = 'insert or ignore into line(id, surah, aya, manzil, juz, hizb, ruku, page) values ';
    var query = StringBuffer(queryString);

    for (var i = 0; i < lines.length; i++) {
      var line = lines[i];
      query.write('(${line.id},${line.surah},${line.aya},${line.manzil},${line.juz},${line.hizb},${line.ruku},${line.page})');
      if (i % 100 == 0 || i == lines.length - 1) {
        database!.execute('${query.toString()};');
        query = StringBuffer(queryString);
      } else if (i % 100 != 0) {
        query.write(',');
      }
    }
  }

  List<Line> getLines() {
    var resultSet = database!.select('select * from line;');
    List<Line> lines = [];
    for (var result in resultSet) {
      lines.add(Line(result['id'], result['surah'], result['aya'], result['manzil'], result['juz'], result['hizb'], result['ruku'], result['page']));
    }
    return lines;
  }

  addQuranLines(List<QuranLine> quranlines) {
    const queryString = 'insert or ignore into quran_line(quran_id, line_id, text) values ';
    var query = StringBuffer(queryString);

    for (var i = 0; i < quranlines.length; i++) {
      var line = quranlines[i];
      query.write("('${line.quranId}','${line.lineId}','${line.text}')");
      if (i % 100 == 0 || i == quranlines.length - 1) {
        database!.execute('${query.toString()};');
        query = StringBuffer(queryString);
      } else if (i % 100 != 0) {
        query.write(',');
      }
    }
  }

  List<QuranLine> getQuranLines(String quranId) {
    var resultSet = database!.select('select * from quran_line where quran_id=?', [quranId]);
    List<QuranLine> quranlines = [];
    for (var result in resultSet) {
      quranlines.add(QuranLine(result['quran_id'], result['line_id'], result['text']));
    }
    return quranlines;
  }

  List<Aya> getAya(String paging, int pageId) {
    var resultSet = database!.select('''
select
  quran_line.quran_id
, quran_line.line_id
, line.surah
, line.aya
, quran_line.text
from quran_line
	inner join line on quran_line.line_id = line.id
where line.$paging = ?
order by quran_line.line_id
''', [pageId]);
    List<Aya> ayas = [];
    for (var result in resultSet) {
      ayas.add(Aya(result['quran_id'], result['line_id'], result['surah'], result['aya'], result['text']));
    }
    return ayas;
  }

  addSuras(List<Sura> suras) {
    var query =
        database!.prepare('insert or ignore into sura(id, ayas, name_arabic, name_english, revelation_city, revelation_order) values (?,?,?,?,?,?);');
    for (var sura in suras) {
      query.execute([sura.id, sura.ayas, sura.nameArabic, sura.nameEnglish, sura.revelationCity, sura.revelationOrder]);
    }
  }

  List<Sura> getSuras() {
    var resultSet = database!.select('select * from sura');
    List<Sura> suras = [];
    for (var result in resultSet) {
      suras.add(
          Sura(result['id'], result['ayas'], result['name_arabic'], result['name_english'], result['revelation_city'], result['revelation_order']));
    }
    return suras;
  }

  Map<String, String> getSettings() {
    var resultSet = database!.select('select * from setting');
    Map<String, String> settings = {};
    for (var result in resultSet) {
      settings[result['key']] = result['value'];
    }
    return settings;
  }

  void saveSettings(Map<String, String> settings) {
    var query = database!.prepare('insert or replace into setting(key, value) values (?,?);');
    settings.forEach((key, value) {
      query.execute([key, value]);
    });
  }
}
