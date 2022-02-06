
part of 'page.dart';

class PopMenuButtonCheck extends StatelessWidget
{
    const PopMenuButtonCheck({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) 
    {
        return PopupMenuButton(
            icon: const Icon(Icons.checklist_rtl),
            tooltip: "Выделение",
            itemBuilder: _items,
        );
    }

    List<PopupMenuEntry> _items(BuildContext context)
    {
        return [
            PopupMenuItem(
                child: const Text("Выделить все"),
                onTap: () => context.read<WordsBloc>().add(const WordsBlocEventCheckboxChangeAll(checked: true)),
            ),
            PopupMenuItem(
                child: const Text("Снять выделение"),
                onTap: () => context.read<WordsBloc>().add(const WordsBlocEventCheckboxChangeAll(checked: false)),
            ),
        ];
    }
}

class PopMenuButtonSort extends StatelessWidget
{
    const PopMenuButtonSort({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) 
    {
        return PopupMenuButton(
            icon: const Icon(Icons.sort),
            tooltip: "Сортировка",
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
            tooltip: "Действия",
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