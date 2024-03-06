import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:path_provider/path_provider.dart';

class FastCacheImageService {
    static Future<void> initImagesCacheConfig() async {
    String storageLocation = (await getApplicationDocumentsDirectory()).path;
    await FastCachedImageConfig.init(
      subDir: storageLocation,
      clearCacheAfter: const Duration(days: 15),
    );
  }
}