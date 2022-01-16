import 'package:engwords/model/word.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

const String dbName = "engwords.db";
const int version = 1;

void addWord(String eng, String rus) async
{
    await openDatabase(await _getPath(),
        version: version,
        onOpen:(db) async {
            await db.rawInsert('INSERT INTO Words(eng, rus) VALUES("$eng", "$rus")');
            await db.close();
        },
    );
}

Future<List<Word>> getWords() async
{
    List<Word> words = [];

    var db = await openDatabase(await _getPath(), version: version);

    var ws = await db.rawQuery('SELECT * FROM Words');

    for (Map<String, dynamic> w in ws) 
    {
        words.add(Word(w['eng'], w['rus']));
    }
    
    await db.close();

    return words;
}

Future<String> _getPath() async
{
    return p.join(await getDatabasesPath(), dbName);
}

void initDB() async
{
    await deleteDatabase(await _getPath());

    await openDatabase(await _getPath(),
        version: version,
        onCreate: (Database db, int version) async 
        {
            await db.execute('CREATE TABLE Words (id INTEGER PRIMARY KEY, eng TEXT, rus text)');
            await db.rawInsert('INSERT INTO Words(eng, rus) VALUES("as", "как")');
            await db.rawInsert('INSERT INTO Words(eng, rus) VALUES("help", "помощь")');
            await db.rawInsert('INSERT INTO Words(eng, rus) VALUES("what", "что")');

            await db.close();
        }
    );
}
