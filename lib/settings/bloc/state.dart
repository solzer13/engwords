part of 'bloc.dart';


abstract class SettingsBlocState {
    const SettingsBlocState();
}

class SettingsInitial extends SettingsBlocState {
    const SettingsInitial();
}

class SettingsLoading extends SettingsBlocState {
    const SettingsLoading();
}

class SettingsLoaded extends SettingsBlocState {
    final SettingsModel settings;
    const SettingsLoaded({required this.settings});
}

class SettingsError extends SettingsBlocState {
    const SettingsError();
}