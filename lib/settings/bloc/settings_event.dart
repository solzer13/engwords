part of 'settings_bloc.dart';

abstract class SettingsEvent 
{
    const SettingsEvent();
}

class SettingsStarted extends SettingsEvent
{
    const SettingsStarted();
}

class SettingsSave extends SettingsEvent
{
    final Settings settings;

    const SettingsSave(this.settings);
}

class SettingsChange extends SettingsEvent
{
    final Settings settings;

    const SettingsChange(this.settings);
}

class SettingsChangeEnd extends SettingsEvent
{
    final Settings settings;

    const SettingsChangeEnd(this.settings);
}