import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/font_manager.dart';
import '../../../../core/resources/value_manager.dart';
import '../../../../domain/entities/score_model.dart';

class ScoreCard extends StatelessWidget {
  const ScoreCard(this.index, this.score, {Key? key}) : super(key: key);

  final int index;
  final ScoreModel score;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: ColorManager.primaryButtonColor.withOpacity(.2),
        highlightColor: ColorManager.backgroundColor.withOpacity(.5),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: AppSize.ws30),
        focusColor: ColorManager.primaryButtonColor,
        hoverColor: ColorManager.primaryButtonColor,
        onTap: () {},
        leading: Text(
          '${index + 1}',
          style: Theme.of(context).textTheme.headline2?.copyWith(color: Colors.black, fontSize: FontSize.s16),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              index % 2 == 0 ? FontAwesomeIcons.person : FontAwesomeIcons.personDress,
              color: ColorManager.primaryButtonColor,
            ),
            SizedBox(width: AppSize.ws30),
            Text(
              score.name,
              style: Theme.of(context)
                  .textTheme
                  .headline2
                  ?.copyWith(color: ColorManager.primaryButtonColor, fontSize: FontSize.s15),
            ),
          ],
        ),
        trailing: Text(
          score.score.toString(),
          style: Theme.of(context).textTheme.headline2?.copyWith(color: Colors.black, fontSize: FontSize.s19),
        ),
      ),
    );
  }
}
