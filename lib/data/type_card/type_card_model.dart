
class TypeCardModel {

  final int uid;
  final String name;
  final String icon;

  const TypeCardModel({required this.uid, required this.name, required this.icon});

  static final List<TypeCardModel> typeCardModel = [
    const TypeCardModel(uid: 1, name: 'Visa', icon: 'assets/logos/visa.svg'),
    const TypeCardModel(uid: 2, name: 'Mastercard', icon: 'assets/logos/mastercard.svg'),
    const TypeCardModel(uid: 3, name: 'Express', icon: 'assets/logos/amex-card.svg'),
    const TypeCardModel(uid: 4, name: 'PayPal', icon: 'assets/logos/paypal-card.svg'),
    const TypeCardModel(uid: 5, name: 'Discover', icon: 'assets/logos/discover-card.svg'),
    const TypeCardModel(uid: 6, name: 'Maestro', icon: 'assets/logos/maestro.svg'),
    const TypeCardModel(uid: 7, name: 'Union Pay', icon: 'assets/logos/unionpay.svg'),
    const TypeCardModel(uid: 8, name: 'Diners Club', icon: 'assets/logos/diners-club-card.svg'),
  ];

}

class TypeCardColor {

  final int uid;
  final int color;

  const TypeCardColor({required this.uid, required this.color});

  static final List<TypeCardColor> typeCardColor = [
    const TypeCardColor(uid: 1, color: 0xff3F51B5),
    const TypeCardColor(uid: 2, color: 0xff0985D9),
    const TypeCardColor(uid: 3, color: 0xffF66318),
    const TypeCardColor(uid: 4, color: 0xff0E333D),
    const TypeCardColor(uid: 5, color: 0xff013F78),
    const TypeCardColor(uid: 6, color: 0xffE53935),
    const TypeCardColor(uid: 7, color: 0xff2DD797),
    const TypeCardColor(uid: 8, color: 0xff23272E),
    const TypeCardColor(uid: 9, color: 0xDD000000),
  ];
}
