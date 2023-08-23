import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strolls/core/getit/get_it.dart';
import 'package:strolls/features/auth/presentation/bloc/registration_event.dart';

import '../../../home/presentation/widgets/glass_container.dart';
import '../bloc/registration_bloc.dart';
import '../bloc/registration_state.dart';
import '../widgets/gradient_city_dropdown.dart';
import '../widgets/gradient_date_picker.dart';
import '../widgets/gradient_gender_picker.dart';
import '../widgets/gradient_text_field.dart';

class RegisterFirstPage extends StatefulWidget {
  RegisterFirstPage(
      {required this.firstnameController,
      required this.lastnameController,
      required this.onGenderChanged,
      required this.onDateChanged,
      required this.onCityChanged,
      this.dateTime,
      this.city,
      this.gender,
      super.key});

  TextEditingController firstnameController;
  TextEditingController lastnameController;
  String? city;
  String? gender;
  DateTime? dateTime;
  Function(String) onGenderChanged;
  Function(String) onCityChanged;
  Function(DateTime) onDateChanged;

  @override
  State<RegisterFirstPage> createState() => _RegisterFirstPageState();
}

class _RegisterFirstPageState extends State<RegisterFirstPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<RegistrationBloc>()..add(GetCitiesEvent()),
      child: GlassContainer(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: GradientTextField(
                  label: "Firstname",
                  maxLines: 1,
                  controller: widget.firstnameController),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: GradientTextField(
                  label: "Lastname",
                  maxLines: 1,
                  controller: widget.lastnameController),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    flex: 10,
                    child: GradientDatePicker(
                      label: "Date of birth",
                      dateTime: widget.dateTime,
                      onDateChanged: widget.onDateChanged,
                    )),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 8,
                  child: GradientGenderPicker(
                    label: "Gender",
                    gender: widget.gender,
                    onSelectedItemChanged: widget.onGenderChanged,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<RegistrationBloc, RegistrationState>(
              builder: (context, state) {
                if (state is GotCitiesState) {
                  return Center(
                    child: GradientDropDown(
                      label: "City",
                      item: widget.city,
                      items: state.cities,
                      onChanged: widget.onCityChanged,
                    ),
                  );
                } else if (state is RegistrationLoading) {
                  return const Center(
                    child: CupertinoActivityIndicator(),
                  );
                } else {
                  return const Center(
                    child: Text("Error"),
                  );
                }
              },
            ),
          ],
        ),
      )),
    );
  }
}
