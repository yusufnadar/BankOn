import 'package:get_storage/get_storage.dart';

class LocalService {
  GetStorage storage = GetStorage();

  read(key) {
    return storage.read(key);
  }

  Future<void> write(key, value) async {
    await storage.write(key, value);
  }

  remove(key)async{
    await storage.remove(key);
  }
}