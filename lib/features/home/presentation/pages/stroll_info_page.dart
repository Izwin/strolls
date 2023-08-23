import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:strolls/core/widgets/title_text.dart';
import 'package:strolls/features/home/domain/entities/stroll_entity.dart';
import 'package:strolls/features/home/presentation/bloc/stroll_single/stroll_single_bloc.dart';
import 'package:strolls/features/home/presentation/widgets/background_with_circles.dart';
import 'package:strolls/features/home/presentation/widgets/glass_container.dart';
import 'package:strolls/features/home/presentation/widgets/key_value_title.dart';
import 'package:strolls/features/home/presentation/widgets/key_value_title_stroll_widget.dart';
import 'package:strolls/features/home/presentation/widgets/key_value_title_white.dart';
import 'package:strolls/features/home/presentation/widgets/member_item_widget.dart';
import 'package:strolls/features/home/presentation/widgets/white_button.dart';
import 'package:strolls/features/profile/presentation/widgets/rouned_avatar.dart';

import '../../../../core/getit/get_it.dart';
import '../../../profile/domain/entities/user_entity.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import '../bloc/strolls_bloc.dart';

class StrollInfoPage extends StatelessWidget {
  StrollInfoPage({required this.strollId, super.key});

  int strollId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<StrollSingleBloc>()..add(GetStrollByIdEvent(id: strollId)),
      child: Scaffold(
        body: BackgroundWithCircles(
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
              child: BlocBuilder<StrollSingleBloc, StrollSingleState>(
                builder: (context, state) {
                  if (state is GotStrollSingleState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        TitleText(
                          title: state.strollEntity.title,
                          height: 1,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          state.strollEntity.description.capitalizeFirst ?? "",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                              fontWeight: FontWeight.w400,
                              height: 1,
                              fontSize: 28),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          Jiffy.parseFromDateTime(state.strollEntity.date)
                              .format(pattern: "dd/MM HH:mm"),
                          style: TextStyle(
                              color: Color(0xFFFFD9D9),
                              fontSize: 32,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        KeyValueTitleStrollWidget(
                          title: "Gender",
                          value:
                              state.strollEntity.gender.capitalizeFirst ?? "",
                        ),
                        KeyValueTitleStrollWidget(
                            title: "Age",
                            value: state.strollEntity.minimumAge.toString()),
                        KeyValueTitleStrollWidget(
                          title: "Language",
                          value: state.strollEntity.language,
                        ),
                        KeyValueTitleStrollWidget(
                          title: "City",
                          value:
                              state.strollEntity.gender.capitalizeFirst ?? "",
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Members",
                          style: TextStyle(
                              fontSize: 40,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                        _buildMemberList(state.strollEntity.members),
                        Spacer(),
                        WhiteButton(text: "Request", onTap: (){
                          context.read<StrollSingleBloc>().add(RequestStrollEvent(id: strollId));
                        })
                      ],
                    );
                  }
                  return Center(
                    child: CupertinoActivityIndicator(),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMemberList(List<UserEntity> members) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return MemberItemWidget(
          userEntity: members[index],
        );
      },
      itemCount: members.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: 10);
      },
    );
  }
}
