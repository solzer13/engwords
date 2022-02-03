
import 'dart:convert';

class Settings
{
    /// Колличество слов для изучения
    double countWordsLern = 10;

    /// Колличество вариантов на странице
    double counVarians = 5;

    /// Колличество повторений для слова
    double countRepeatWord = 5;

    Settings.fromMap(Map settingsMap)
    {
        if(settingsMap['countWordsLern'] != null && 
            settingsMap['counVarians'] != null &&
            settingsMap['countRepeatWord'] != null)
        {
            countWordsLern = settingsMap['countWordsLern'];
            counVarians = settingsMap['counVarians'];
            countRepeatWord = settingsMap['countRepeatWord']; 
        }
    }

    Map toMap()
    {
        return 
        {
            "countWordsLern":countWordsLern,
            "counVarians":counVarians,
            "countRepeatWord":countRepeatWord
        };
    }

    String toJson()
    {
        return jsonEncode(toMap());
    }
}
