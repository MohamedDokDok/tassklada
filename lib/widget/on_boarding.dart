import 'package:flutter/material.dart';
import '../models/on_boarding_model.dart';
import '../shared/style/color.dart';

class OnBoardingView extends StatelessWidget {
   OnBoardingView({Key? key, required this.model}) : super(key: key);

  OnBoardingModel model;



  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Image.asset(
            model.image,
            fit: BoxFit.scaleDown,
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            children: [
              Text(
                model.title,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: bluish,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Text(
                  model.body,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w400,
                    color: bluish,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
