
part of 'page.dart';

class PopMenuButtonSort extends StatelessWidget
{
    const PopMenuButtonSort({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) 
    {
        return PopupMenuButton(
            icon: const Icon(Icons.sort),
            itemBuilder: _items,
        );
    }

    List<PopupMenuEntry> _items(BuildContext context)
    {
        return [
            PopupMenuItem(
                child: const Text("По алфавиту"),
                onTap: () => context.read<WordsBloc>().add(const WordsBlocEventSortAbc()),
            ),
            PopupMenuItem(
                child: const Text("По изучению"),
                onTap: () => context.read<WordsBloc>().add(const WordsBlocEventSortRepeat()),
            ),
        ];
    }
}

class PopMenuButtonMore extends StatelessWidget
{
    const PopMenuButtonMore({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) 
    {
        return PopupMenuButton(
            icon: const Icon(Icons.more_vert_outlined),
            itemBuilder: _items,
        );
    }

    List<PopupMenuEntry> _items(BuildContext context)
    {
        return [
            PopupMenuItem(
                child: const Text("Выучено"),
                onTap: () => context.read<WordsBloc>().add(const WordsBlocEventChangeLearned(learned: true)),
            ),
            PopupMenuItem(
                child: const Text("Повторить"),
                onTap: () => context.read<WordsBloc>().add(const WordsBlocEventChangeLearned(learned: false)),
            ),
            PopupMenuItem(
                child: const Text("Удалить"),
                onTap: () => context.read<WordsBloc>().add(const WordsBlocEventDelete()),
            ),
        ];
    }
}