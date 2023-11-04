import '../widgets/widgets.dart';

class RoomUtil {
  getService(String services) {
    String imageUrl = '';
    String name = '';
    switch (services) {
      case 'RESTAURENT':
        imageUrl = 'assets/images/restaurant.png';
        name = 'Restaurant';

      case 'FREE_WIFI':
        imageUrl = 'assets/images/wifi.png';
        name = 'Wifi';
      case 'CURRENCY_EXCHANGE':
        imageUrl = 'assets/images/currency.png';
        name = 'Currency Exchange';
      case '24_HOURS_FRONT_DESK':
        imageUrl = 'assets/images/24hour.png';
        name = '24-hour Front Desk';
      case 'NON_SMOKING':
        imageUrl = 'assets/images/nonSmoking.png';
        name = 'Non - Smoking';
      case 'ROOM_SERVICE':
        imageUrl = 'assets/images/roomService.png';
        name = 'Room Service';
      case 'NON_REFUNDABLE':
        imageUrl = 'assets/images/nonRefundable.png';
        name = 'Non - Refundable';
      case 'FREE_BREAKFAST':
        imageUrl = 'assets/images/breakfast.png';
        name = 'Free BreakFast';
    }
    return OptionService(imageUrl: imageUrl, name: name);
  }
}
