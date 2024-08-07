import 'package:real_estate_app_ui/model/models.dart';

import '../util/utils.dart';

class OfferRepository {
  List<OfferModel> getOffers() {
    return [
      OfferModel(count: AppInts.buyInt, type: AppStrings.buyText),
      OfferModel(count: AppInts.rentInt, type: AppStrings.rentText),
    ];
  }
}