

abstract class DataProviderInterface
{
    Future<Map<String, dynamic>> getAllData();
    Future<void> writeAllData(Map<String, dynamic> mapData);
}