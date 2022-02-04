part of 'settings_bloc.dart';

abstract class SettingsEvent 
{
    const SettingsEvent();
}

class SettingsStarted extends SettingsEvent
{
    const SettingsStarted();
}

class SettingsUpdate extends SettingsEvent 
{
    final String key;
    final dynamic value;

    const SettingsUpdate({required this.key, required this.value});
}

class SettingsSave extends SettingsEvent
{
    const SettingsSave();
}

class SettingsChange extends SettingsEvent
{
    const SettingsChange();
}

class SettingsChangeEnd extends SettingsEvent
{
    const SettingsChangeEnd();
}