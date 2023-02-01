import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safe_manager/presentation/components/components.dart';

class CardsHome extends StatelessWidget {

  final int background;
  final String typeCard;
  final String number;
  final String date;
  final String cvv;
  final int uidType;
  final String logo;

  const CardsHome({
    Key? key, 
    required this.background, 
    required this.typeCard, 
    required this.number, 
    required this.date, 
    required this.cvv, 
    required this.uidType, 
    required this.logo
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return  Container(
      height: 210,
      width: double.infinity,
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Color(background)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextCustom(
            text: typeCard,
            isTitle: true,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          const SizedBox(height: 40.0),
          TextCustom(
            text: number,
            isTitle: true,
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Colors.white,
          ),
          const SizedBox(height: 50.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextCustom(
                        text: 'VALID THRU',
                        isTitle: true,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 5.0),
                      TextCustom(
                        text: date,
                        isTitle: true,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  const SizedBox(width: 20.0),
                  Column(
                    children: [
                      const TextCustom(
                        text: 'CVV',
                        isTitle: true,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 5.0),
                      TextCustom(
                        text: cvv,
                        isTitle: true,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
              SvgPicture.asset(logo,
                height: uidType == 5 || uidType == 4 || uidType == 3 ? 51 : 30
              )
            ],
          )
        ],
      ),
    );
  }
}