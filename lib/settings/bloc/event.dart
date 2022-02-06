part of 'bloc.dart';

abstract class SettingsBlocEvent {
    const SettingsBlocEvent();
}

class SettingsStarted extends SettingsBlocEvent{
    const SettingsStarted();
}

class SettingsUpdate extends SettingsBlocEvent {
    final String key;
    final dynamic value;
    const SettingsUpdate({required this.key, required this.value});
}

class SettingsSave extends SettingsBlocEvent{
    const SettingsSave();
}

class SettingsChange extends SettingsBlocEvent{
    const SettingsChange();
}

class SettingsChangeEnd extends SettingsBlocEvent{
    const SettingsChangeEnd();
}