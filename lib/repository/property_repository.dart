import 'package:real_estate_app_ui/model/models.dart';

class PropertyRepository {
  List<PropertyModel> getProperties() {
    final baseProperties = [
      PropertyModel(
        address: 'Gladkova St., 25',
        imageUrl: 'https://images.livspace-cdn.com/plain/https://jumanji.livspace-cdn.com/magazine/wp-content/uploads/sites/2/2022/09/20124936/Cover-3.jpg',
      ),
      PropertyModel(
        address: 'Gladkova St., 27',
        imageUrl: 'https://i.pinimg.com/originals/1b/e6/b9/1be6b9c2434f0d2951316407829b98fc.jpg',
      ),
      PropertyModel(
        address: 'Gladkova St., 28',
        imageUrl: 'https://images.livspace-cdn.com/plain/https://jumanji.livspace-cdn.com/magazine/wp-content/uploads/sites/2/2022/09/20124936/Cover-3.jpg',
      ),
    ];

    return _duplicateProperties(baseProperties, 5); // 5 is the number of times to duplicate
  }

  List<PropertyModel> _duplicateProperties(List<PropertyModel> properties, int times) {
    final duplicatedList = <PropertyModel>[];
    for (var i = 0; i < times; i++) {
      duplicatedList.addAll(properties.map((prop) => PropertyModel(
        address: '${prop.address}${i + 1}',
        imageUrl: prop.imageUrl,
      )));
    }
    return duplicatedList;
  }
}