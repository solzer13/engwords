
class SettingsModel
{
    /// Колличество слов для изучения
    late int countWordsLearn;

    /// Колличество вариантов на странице
    late int counVariants;

    /// Колличество повторений для слова
    late int countRepeatWord;

    SettingsModel.fromMap(Map<String, dynamic> settingsMap)
    {
        countWordsLearn = settingsMap["countWordsLearn"] ?? 10;
        counVariants = settingsMap["counVariants"] ??  5;
        countRepeatWord = settingsMap["countRepeatWord"] ??  5;
    }

    Map<String, dynamic> toMap()
    {
        return {
            "countWordsLearn":countWordsLearn,
            "counVariants":counVariants,
            "countRepeatWord":countRepeatWord
        };
    }
}
