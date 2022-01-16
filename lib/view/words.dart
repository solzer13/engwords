import 'dart:async';

import 'package:engwords/model/word.dart';
import 'package:flutter/material.dart';
import '../data/word_repository.dart';

class WordsWidget extends StatefulWidget {
  const WordsWidget({Key? key}) : super(key: key);

  @override
  State<WordsWidget> createState() => _WordsWidgetState();
}

class _WordsWidgetState extends State<WordsWidget> {
  WordRepository wordRepository = WordRepository();

  StreamSubscription? subscription;

  List<Word> _listWords = [];

  Future<void> _showMyDialog(BuildContext context) async {
    String eng = '';
    String rus = '';

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Add word'),
          contentPadding: const EdgeInsets.all(10),
          children: [
            Column(
              children: [
                TextField(
                  onChanged: (value) { eng = value; },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'English',
                  ),
                ),
                Container(height: 10),
                TextField(
                  onChanged: (value) { rus = value; },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Russian',
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        wordRepository.addWord(eng, rus);
                        Navigator.pop(context);
                      },
                      child: const Text('Add'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Chancel'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void onUpdateWords(List<Word> words) {
    setState(() {
      _listWords = words;
    });
  }

  @override
  void initState() {
    subscription = wordRepository.wordsStream.listen(onUpdateWords);
    super.initState();
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: wordRepository.words.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(wordRepository.words[index].eng),
              subtitle: Text(wordRepository.words[index].rus),
              visualDensity: VisualDensity.compact,
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                iconSize: 24.0,
                onPressed: () { wordRepository.delWord(wordRepository.words[index]); },
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showMyDialog(context),
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
