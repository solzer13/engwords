part of 'settings_bloc.dart';


abstract class SettingsState {
    const SettingsState();
}

class SettingsInitial extends SettingsState {
    const SettingsInitial();
}

class SettingsLoading extends SettingsState {
    const SettingsLoading();
}

class SettingsLoaded extends SettingsState {
    final Settings settings;
    const SettingsLoaded({required this.settings});
}

class SettingsError extends SettingsState {
    const SettingsError();
}