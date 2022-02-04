
class Settings
{
    //late Map<String, dynamic> _settingsMap;

    // /// Колличество слов для изучения
    // set countWordsLearn(int value) => add(RepositorySettingsUpdate(key: "countWordsLearn", value: value));
    // int get countWordsLearn {
    //     return _data["countWordsLearn"] ?? 10;
    // } 

    // /// Колличество вариантов на странице
    // set counVariants(int value) => add(RepositorySettingsUpdate(key: "counVariants", value: value));
    // int get counVariants { 
    //     return _data["counVariants"] ??  5;
    // }

    // /// Колличество повторений для слова
    // set countRepeatWord(int value) => add(RepositorySettingsUpdate(key: "countRepeatWord", value: value));
    // int get countRepeatWord {
    //     return _data["countRepeatWord"] ??  5;
    // }

    /// Колличество слов для изучения
    late double countWordsLearn;

    /// Колличество вариантов на странице
    late double counVariants;

    /// Колличество повторений для слова
    late double countRepeatWord;

    Settings(Map<String, dynamic> settingsMap)
    {
        countWordsLearn = settingsMap["countWordsLearn"] ?? 10;
        counVariants = settingsMap["counVariants"] ??  5;
        countRepeatWord = settingsMap["countRepeatWord"] ??  5;
    }
}
