
import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'interface_data_provider.dart';

class FileDataProvider extends DataProviderInterface
{
    final String _fileName;

    FileDataProvider(this._fileName);

    @override
    Future<Map<String, dynamic>> getAllData() async {
        return Map<String, dynamic>.from(await _getMap());
    }

    @override
    Future<void> writeAllData(Map<String, dynamic> mapData) async {
        await (await _getFile()).writeAsString(jsonEncode(mapData));
    }

    Future<Map> _getMap() async
    {
        return jsonDecode(await _getText());
    }

    Future<String> _getText() async
    {
        return (await _getFile()).readAsStringSync();
    }

    Future<File> _getFile() async
    {
        var file = File(await _getPath());

        if(!file.existsSync())
        {
            file.createSync(recursive: true);
            file.writeAsStringSync("{}");
        }

        return File(await _getPath());
    }
    
    Future<String> _getPath() async
    {
        return (await getApplicationDocumentsDirectory()).path + "/" + _fileName;
    }

}