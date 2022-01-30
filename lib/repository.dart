import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

class Repository {

    static const _fileName = "/words.txt";
    static const _newFileTemplate = '{"settings": {},"words":[]}';

    Repository()
    {
        _init();
    }

    void _init() async
    {
        var file = await _getFile();

        if(!file.existsSync())
        {
            file.createSync(recursive: true);
            file.writeAsStringSync(_newFileTemplate);
        }
    }

    Future<void> setSettings(Map settingsMap) async
    {
        var map = await _getJson();

        map['settings'] = settingsMap;
            
        await (await _getFile()).writeAsString(jsonEncode(map));
    }

    void setWords(List<Map> wordsMap) async
    {
        var map = await _getJson();

        map['words'] = wordsMap;
            
        await (await _getFile()).writeAsString(jsonEncode(map));
    }

    Future<Map> getSettings() async
    {
        return (await _getJson())['settings'];
    }

    Future<List<dynamic>> getWords() async
    {
        return (await _getJson())['words'];
    }

    Future<Map> _getJson() async
    {
        return jsonDecode(await _getText());
    }

    Future<String> _getText() async
    {
        return (await _getFile()).readAsStringSync();
    }

    Future<File> _getFile() async
    {
        return File(await _getPath());
    }

    Future<String> _getPath() async
    {
        return (await getApplicationDocumentsDirectory()).path + _fileName;
    }

}