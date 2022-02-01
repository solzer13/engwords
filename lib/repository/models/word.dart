
import 'dart:convert';

class Word
{
    String id = '';
    String eng = '';
    String rus = '';
    bool learned = false;
    int repeat = 0;

    Word.fromJson(String json)
    {
        try
        {
            var wordMap = jsonDecode(json);

            id = wordMap['id'] ?? id;
            eng = wordMap['eng'] ?? eng;
            rus = wordMap['rus'] ?? rus; 
            learned = wordMap['learned'] ?? learned;
            repeat = wordMap['repeat'] ?? repeat; 
        }
        catch(e)
        {
            throw(Exception("Word init error!!!"));
        }
    }

    String toJson()
    {
        return jsonEncode({
            "id":id,
            "eng":eng,
            "rus":rus,
            "learned":false,
            "repeat":repeat
        });
    }
}