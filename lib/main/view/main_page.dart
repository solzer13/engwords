
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:engwords/main/main.dart';

part 'app_bar.dart';
part 'body.dart';
part 'bottom_navigation.dart';

class MainWidget extends StatelessWidget
{
    final MainBloc blocMain = MainBloc()..add(const MainStarted());

    MainWidget({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) 
    {
        return  BlocBuilder<MainBloc, MainState>(
            builder: (context, state) {
                if (state is MainLoading) 
                {
                    return const Center(child: CircularProgressIndicator());
                }
                if (state is MainLoaded) 
                {
                    return const Scaffold(
                        appBar: MainAppBarWidget(),
                        body: MainBodyWidget(),
                        bottomNavigationBar: MainBottomNawigationWidget(),
                    );
                }
                return const Center(child: Text('Something went wrong!'));
            },
        );

    }
}