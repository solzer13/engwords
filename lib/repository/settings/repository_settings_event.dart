part of 'repository_settings_bloc.dart';

abstract class RepositorySettingsEvent 
{
    const RepositorySettingsEvent();
}

class RepositorySettingsLoad extends RepositorySettingsEvent 
{
    const RepositorySettingsLoad();
}

class RepositorySettingsUpdate extends RepositorySettingsEvent 
{
    final String key;
    final dynamic value;

    const RepositorySettingsUpdate({required this.key, required this.value});
}
