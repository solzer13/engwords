
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:engwords/model/word.dart';
import 'package:path_provider/path_provider.dart';

const _fileName = "/words.txt";

void init() async
{
    var file = await _getFile();
    
    file.deleteSync(); 
    
    file.createSync(recursive: true);
            
    file.writeAsStringSync('{"words":[]}');
}

void setWords(List<Word> words) async
{
    int index = 0;

    if(words.isNotEmpty)
    {
        String json = '{"words":[';

        for(var word in words)
        {
            if(index > 0) json +=',';

            json += word.toJson();

            index++;
        }

        json += ']}';
        
        await (await _getFile()).writeAsString(json);
    }
}

Future<List<Word>> getWords() async
{
    String json = await _getText();

    List<Word> listWords = [];

    var words = jsonDecode(json)['words'];

    for(var word in words)
    {
        listWords.add(Word(word['eng'], word['rus']));
    }

    return listWords;
}

void _createFile() async
{
    var file = await _getFile();

    file.createSync(recursive: true);
            
    file.writeAsStringSync('{"words":[]}');
}

Future<String> _getText() async
{
    return await (await _getFile()).readAsString();
}

Future<File> _getFile() async
{
    return File(await _getPath());
}

Future<String> _getPath() async
{
    return (await getApplicationDocumentsDirectory()).path + _fileName;
}

