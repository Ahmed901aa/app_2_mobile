import 'package:app_2_mobile/features/home/data/models/cuisine_model.dart';
import 'package:app_2_mobile/features/home/presentation/widgets/featured_banner.dart';

class DefaultHomeData {
  static List<CuisineModel> getDefaultCuisines() {
    return [
      const CuisineModel(
        id: '1',
        name: 'Italian',
        image:
            'https://images.unsplash.com/photo-1595295333158-4742f28fbd85?w=400',
      ),
      const CuisineModel(
        id: '2',
        name: 'Asian',
        image:
            'https://images.unsplash.com/photo-1617093727343-374698b1b08d?w=400',
      ),
      const CuisineModel(
        id: '3',
        name: 'Mexican',
        image:
            'https://images.unsplash.com/photo-1565299585323-38d6b0865b47?w=400',
      ),
    ];
  }

  static List<BannerItem> getDefaultBanners() {
    return const [
      BannerItem(
        title: 'Fresh Salads',
        subtitle: 'Healthy & Green',
        imageUrl:
            'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80',
      ),
      BannerItem(
        title: 'Premium Steaks',
        subtitle: 'Grilled to Perfection',
        imageUrl:
            'https://images.unsplash.com/photo-1600891964092-4316c288032e?w=800&q=80',
      ),
      BannerItem(
        title: 'Sweet Delights',
        subtitle: 'Taste the Magic',
        imageUrl:
            'https://images.unsplash.com/photo-1551024506-0bccd828d307?w=800&q=80',
      ),
    ];
  }
}
