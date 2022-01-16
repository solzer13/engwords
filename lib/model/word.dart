
class Word
{
    final String eng;
    final String rus;

    const Word(this.eng, this.rus);

    String toJson()
    {
        return '{"eng":"$eng","rus":"$rus"}';
    }
}