import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../../core/resources/string_manager.dart';
import '../../../../core/resources/value_manager.dart';

class PickCountryField extends HookConsumerWidget {
  const PickCountryField({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countryNotifier = useState<Country?>(null);

    return GestureDetector(
      onTap: () => showCountryPicker(context: context, onSelect: (pickedCountry) {}),
      child: Container(
        height: AppSize.hs60,
        padding: EdgeInsets.symmetric(horizontal: AppSize.ws20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: ColorManager.textFieldFillColor,
          borderRadius: BorderRadius.all(Radius.circular(AppSize.ws5)),
          border: Border.all(color: ColorManager.white),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    AppStrings.countryOrRegion,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  SizedBox(height: AppSize.hs8),
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(AppSize.hs2)),
                        child: Image.asset(
                          'icons/flags/png/${countryNotifier.value?.countryCode.toLowerCase() ?? 'sa'}.png',
                          package: 'country_icons',
                          fit: BoxFit.cover,
                          height: AppSize.hs16,
                        ),
                      ),
                      SizedBox(width: AppSize.ws10),
                      Text(countryNotifier.value?.name ?? AppStrings.saudiArabia,
                          style: Theme.of(context).textTheme.headline2),
                    ],
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_drop_down, size: AppSize.hs30)
          ],
        ),
      ),
    );
  }
}
