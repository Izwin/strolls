import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strolls/features/auth/presentation/bloc/registration_event.dart';

import '../../../../core/getit/get_it.dart';
import '../../../auth/presentation/bloc/registration_bloc.dart';
import '../../../auth/presentation/bloc/registration_state.dart';
import '../../../auth/presentation/widgets/gradient_city_dropdown.dart';

class CitiesSelectorWidget extends StatelessWidget {
  CitiesSelectorWidget({required this.city,required this.onChanged,super.key});
  String city;
  Function(String) onChanged;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<RegistrationBloc>()..add(GetCitiesEvent()),
      child: BlocBuilder<RegistrationBloc, RegistrationState>(
        builder: (context, state) {
          if (state is GotCitiesState) {
            return Center(
                child: GradientDropDown(
                  label: "City",
                  item: city,
                  items: state.cities,
                  onChanged: (city) {
                    this.city = city;
                    onChanged.call(city);
                  },
                ));
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
    );
  }
}
