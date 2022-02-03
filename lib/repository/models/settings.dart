

// class Settings
// {
//     /// Колличество слов для изучения
//     double countWordsLern = 10;

//     /// Колличество вариантов на странице
//     double counVarians = 5;

//     /// Колличество повторений для слова
//     double countRepeatWord = 5;

//     static const _fileName = "words.txt";

//     Settings()
//     {

//     }

//     Settings.fromJson(String json)
//     {
//         try
//         {
//             var settingsMap = jsonDecode(json);

//             countWordsLern = settingsMap['countWordsLern'] ?? countWordsLern;
//             counVarians = settingsMap['counVarians'] ?? counVarians;
//             countRepeatWord = settingsMap['countRepeatWord'] ?? countRepeatWord; 
//         }
//         catch(e)
//         {
//             throw(Exception("Settings init error!!!"));
//         }
//     }

//     Future<String> _getPath() async
//     {
//         return (await getApplicationDocumentsDirectory()).path + "/" + _fileName;
//     }
    
//     String toJson()
//     {
//         return jsonEncode({
//             "countWordsLern":countWordsLern,
//             "counVarians":counVarians,
//             "countRepeatWord":countRepeatWord
//         });
//     }
// }