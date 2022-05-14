import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';
import '../shared/style/color.dart';

class ChooseColorSection extends StatelessWidget {
  const ChooseColorSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context,state){},
      builder: (context, state){
        return Wrap(
          children: List.generate(3, (index) {
            return GestureDetector(
              onTap: () {
                AppCubit.get(context).changeColor(index: index);
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0, top: 5.0),
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: index == 0
                      ? bluish
                      : index == 1
                      ? yellow
                      : pink,
                  child: AppCubit.get(context).selectedColor == index
                      ? const Icon(
                    Icons.done,
                    size: 18,
                    color: Colors.white,
                  )
                      : Container(),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
