part of 'repository_settings_bloc.dart';

abstract class RepositorySettingsState 
{
    const RepositorySettingsState();
}

class RepositorySettingsInitial extends RepositorySettingsState 
{
    const RepositorySettingsInitial();
}

class RepositorySettingsLoading extends RepositorySettingsState 
{
    const RepositorySettingsLoading();
}

class RepositorySettingsLoaded extends RepositorySettingsState 
{
    const RepositorySettingsLoaded();
}
