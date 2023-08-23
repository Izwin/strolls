import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:strolls/core/widgets/gradient_scaffold.dart';
import 'package:strolls/features/home/domain/entities/stroll_entity.dart';
import 'package:strolls/features/home/domain/entities/stroll_request_entity.dart';
import 'package:strolls/features/home/presentation/widgets/background_with_circles.dart';
import 'package:strolls/features/home/presentation/widgets/member_item_widget.dart';
import 'package:strolls/features/profile/presentation/pages/profile_page.dart';

import '../../../../core/getit/get_it.dart';
import '../../../../core/widgets/subtitle_text.dart';
import '../../../../core/widgets/title_text.dart';
import '../../../chat/presentation/pages/stroll_chat_page.dart';
import '../../../profile/domain/entities/user_entity.dart';
import '../../../profile/presentation/widgets/rouned_avatar.dart';
import '../bloc/stroll_single/stroll_single_bloc.dart';
import '../widgets/glass_container.dart';
import '../widgets/key_value_title_stroll_widget.dart';
import '../widgets/key_value_title_white.dart';
import '../widgets/request_item_widget.dart';
import '../widgets/white_button.dart';

class StrollInfoCreatorPage extends StatelessWidget {
  StrollInfoCreatorPage({required this.strollId, super.key});

  int strollId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      getIt<StrollSingleBloc>()
        ..add(GetStrollByIdEvent(id: strollId)),
      child: GradientScaffold(
        child: SingleChildScrollView(
          child: SafeArea(
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
                      const SizedBox(
                        height: 10,
                      ),
                      SubtitleText(
                          title:
                          state.strollEntity.description.capitalizeFirst ??
                              ""),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        Jiffy.parseFromDateTime(state.strollEntity.date)
                            .format(pattern: "dd/MM HH:mm"),
                        style: const TextStyle(
                            color: Color(0xFFFFD9D9),
                            fontSize: 32,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      KeyValueTitleStrollWidget(
                        title: "Gender",
                        value: state.strollEntity.gender.capitalizeFirst ?? "",
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
                        value: state.strollEntity.gender.capitalizeFirst ?? "",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Members",
                        style: TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      _buildMemberList(state.strollEntity.members),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Requests",
                        style: TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      BlocProvider(
                        create: (context) =>
                        getIt<StrollSingleBloc>()
                          ..add(GetStrollRequestsEvent(id: strollId)),
                        child: BlocBuilder<StrollSingleBloc, StrollSingleState>(
                          builder: (context, state) {
                            if (state is GotStrollsRequestsState) {
                              return _buildRequestsList(state.strollRequests);
                            }
                            return const Center(
                              child: CupertinoActivityIndicator(),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      WhiteButton(
                          text: "Chat",
                          onTap: () {
                            Navigator.push(context,
                                CupertinoPageRoute(builder: (context) {
                                  return StrollChatPage(strollId: strollId);
                                }));
                          }),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  );
                }
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              },
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

  Widget _buildRequestsList(List<StrollRequestEntity> requests) {
    if(requests.isNotEmpty){
      return ListView.separated(
        itemBuilder: (context, index) {
          return RequestItemWidget(
            userEntity: requests[index].userModel,
            onAccept: (user) {
              context.read<StrollSingleBloc>().add(
                  AcceptStrollRequestEvent(
                      strollId: strollId,
                      userId: user.id));
            },
            onDecline: (user) {
              context.read<StrollSingleBloc>().add(
                  DeclineStrollRequestEvent(
                      strollId: strollId,
                      userId: user.id));
            },
          );
        },
        itemCount: requests.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(height: 10,);
        },
      );
    }
    else{
      return SubtitleText(title: "Empty");
    }

  }
}
