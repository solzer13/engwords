
import 'dart:convert';
import 'dart:math';

class Word
{
    String id = '';
    String eng = '';
    String rus = '';
    bool learned = false;
    int repeat = 0;

    Word()
    {
        id = _genUID();
    }

    Word.fromMap(Map map)
    {
        id = map['id'] ?? _genUID();
        eng = map['eng'] ?? 'No eng';
        rus = map['rus'] ?? 'No rus';
        learned = map['learned'] ?? false;
        repeat = map['repeat'] ?? 0;
    }

    static String _genUID() 
    {
        Random random = Random(DateTime.now().millisecond);

        const String hexDigits = "0123456789abcdef";
        final List<String> uuid = List<String>.filled(36, '');

        for (int i = 0; i < 36; i++) 
        {
            final int hexPos = random.nextInt(16);
            uuid[i] = (hexDigits.substring(hexPos, hexPos + 1));
        }

        int pos = (int.parse(uuid[19], radix: 16) & 0x3) | 0x8; // bits 6-7 of the clock_seq_hi_and_reserved to 01

        uuid[14] = "4";  // bits 12-15 of the time_hi_and_version field to 0010
        uuid[19] = hexDigits.substring(pos, pos + 1);

        uuid[8] = uuid[13] = uuid[18] = uuid[23] = "-";

        return uuid.join();
    }

    Map<String, dynamic> toMap()
    {
        return 
        {
            "id":id,
            "eng":eng,
            "rus":rus,
            "learned":false,
            "repeat":repeat
        };
    }

    String toJson()
    {
        return jsonEncode(toMap());
    }

    @override
    String toString()
    {
        return toJson();
    }
}