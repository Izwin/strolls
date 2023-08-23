import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';
import 'package:strolls/core/widgets/gradient_scaffold.dart';
import 'package:strolls/features/auth/presentation/widgets/gradient_text_field.dart';
import 'package:strolls/features/chat/presentation/bloc/chats_bloc.dart';
import 'package:strolls/features/home/presentation/widgets/glass_container.dart';
import 'package:strolls/features/profile/domain/entities/user_entity.dart';

import '../../../../core/getit/get_it.dart';
import '../../../../core/widgets/title_text.dart';
import '../../../home/presentation/bloc/stroll_single/stroll_single_bloc.dart';
import '../../../home/presentation/widgets/background_with_circles.dart';
import '../../domain/entities/message_entity.dart';
import '../widgets/message_item_widget.dart';
import '../widgets/my_message_item_widget.dart';

class StrollChatPage extends StatefulWidget {
  StrollChatPage({required this.strollId, super.key});

  int strollId;

  @override
  State<StrollChatPage> createState() => _StrollChatPageState();
}

class _StrollChatPageState extends State<StrollChatPage> {
  List<MessageEntity> messages = [];
  ScrollController scrollController = ScrollController();
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<StrollSingleBloc>()
            ..add(GetStrollByIdEvent(id: widget.strollId)),
        ),
        BlocProvider(
          create: (context) => getIt<ChatsBloc>()
            ..add(GetMessagesEvent(strollId: widget.strollId)),
        ),
      ],
      child: Scaffold(
        body: BackgroundWithCircles(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 30.0, left: 20, right: 20, bottom: 10),
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
                        SizedBox(
                          height: 70,
                          child: ListView.builder(
                              itemCount: state.strollEntity.members.length,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemBuilder: (i, c) {
                                return Row(
                                  children: [
                                    Center(
                                      child: Container(
                                        width: 70,
                                        height: 70,
                                        child: ClipOval(
                                          child: Image.network(
                                            state.strollEntity.members[c]
                                                .avatarUrl,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: LinearGradient(
                                            begin: Alignment(0.00, -1.00),
                                            end: Alignment(0, 1),
                                            colors: [
                                              Color(0xFFBFF8FF),
                                              Color(0xFF55CCFF)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    )
                                  ],
                                );
                              }),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Expanded(
                            child: GlassContainer(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Expanded(
                                  child: BlocListener<ChatsBloc, ChatsState>(
                                    listener: (context, state) async {
                                      if (state is GotMessagesState) {
                                        setState(() {
                                          messages = state.messages;
                                        });
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                          scrollController.animateTo(
                                              scrollController
                                                  .position.maxScrollExtent,
                                              duration: Duration(milliseconds: 200),
                                              curve: Curves.linear);
                                        });
                                      } else if (state is GotNewMessageState) {
                                        setState(() {
                                          messages.add(state.messageEntity);
                                        });
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                          scrollController.animateTo(
                                              scrollController
                                                  .position.maxScrollExtent,
                                              duration: Duration(milliseconds: 200),
                                              curve: Curves.linear);
                                        });
                                      }
                                    },
                                    child: ListView.builder(
                                        itemCount: messages.length,
                                        shrinkWrap: true,
                                        controller: scrollController,
                                        itemBuilder: (context, index) {
                                          var user = Get.find<UserEntity>();
                                          if (user.id ==
                                              messages[index].userId) {
                                            return MyMessageItemWidget(
                                              messageEntity: messages[index],
                                            );
                                          } else {
                                            return MessageItemWidget(
                                              messageEntity: messages[index],
                                            );
                                          }
                                        }),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: GradientTextField(
                                          controller: textEditingController),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          context.read<ChatsBloc>().add(
                                              SendMessageEvent(
                                                  message: textEditingController.text.trim(),
                                                  strollId: widget.strollId));
                                          textEditingController.clear();
                                        },
                                        icon: Icon(
                                          Icons.arrow_circle_right,
                                          color: Colors.white,
                                        ))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ))
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
}
