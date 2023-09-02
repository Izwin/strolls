import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:strolls/core/getit/get_it.dart';
import 'package:strolls/core/widgets/title_text.dart';
import 'package:strolls/features/home/domain/entities/stroll_entity.dart';
import 'package:strolls/features/home/presentation/widgets/glass_container_with_tap.dart';
import 'package:strolls/features/home/presentation/widgets/notifications_badge_widget.dart';
import 'package:strolls/features/home/presentation/widgets/round_avatar_widger.dart';
import 'package:strolls/features/notification/presentation/bloc/notification_bloc.dart';
import 'package:strolls/features/notification/presentation/pages/notifications_page.dart';
import 'package:strolls/features/profile/domain/entities/user_entity.dart';
import 'package:strolls/features/profile/presentation/bloc/profile/profile_bloc.dart';

import '../bloc/strolls_bloc.dart';
import '../widgets/background_with_circles.dart';
import '../widgets/glass_container.dart';
import '../widgets/stroll_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isAllStrollsShown = true;
  static const _pageSize = 2;
  int page = 0;
  final PagingController<int, StrollEntity> _pagingController =
      PagingController(firstPageKey: 0);

  final StrollsBloc strollsBloc = getIt<StrollsBloc>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => strollsBloc,
        ),
        BlocProvider(
          create: (context) => getIt<ProfileBloc>()..add(GetProfileEvent()),
        ),
        BlocProvider(
          create: (context) =>
              getIt<NotificationBloc>()..add(GetNotificationsEvent()),
        ),
      ],
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          BackgroundWithCircles(
            child: Padding(
              padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          _buildAppBar(),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // Row(
                      //   children: [
                      //     _buildAllFriendsButtons(),
                      //     const SizedBox(
                      //       width: 10,
                      //     ),
                      //     Icon(
                      //       CupertinoIcons.bars,
                      //       color: Colors.white.withOpacity(0.7),
                      //       size: 30,
                      //     ),
                      //   ],
                      // ),
                      BlocBuilder<ProfileBloc, ProfileState>(
                        builder: (context, state) {
                          if(state is GotProfileState){
                            return _getStrolls();
                          }
                          return Center();
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    ;
  }

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      strollsBloc.add(GetStrollsByPageEvent(size: _pageSize, page: page));
      page++;
    });
    super.initState();
  }

  Widget _getStrolls() {
    var userEntity = Get.find<UserEntity>();

    return BlocListener<StrollsBloc, StrollsState>(
      listener: (context, state) {
        if (state is GotStrollsState) {
          final newItems = state.strolls;
          final isLastPage = newItems.length < _pageSize;
          if (isLastPage) {
            _pagingController.appendLastPage(newItems);
          } else {
            final nextPageKey = page + newItems.length;
            _pagingController.appendPage(newItems, nextPageKey);
          }
        }
      },
      child: PagedListView<int, StrollEntity>(
        builderDelegate: PagedChildBuilderDelegate<StrollEntity>(
            itemBuilder: (context, item, index) {
          return Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              StrollItem(
                strollEntity: item,
                profileId: userEntity.id,
              ),
            ],
          );
        }, newPageProgressIndicatorBuilder: (context) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        }, firstPageProgressIndicatorBuilder: (context) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        }, noMoreItemsIndicatorBuilder: (context) {
          return Text("No more Strolls");
        }),
        shrinkWrap: true,
        primary: false,
        pagingController: _pagingController,
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      height: 70,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TitleText(title: "Strolls"),
          const SizedBox(
            width: 10,
          ),
          BlocBuilder<NotificationBloc, NotificationState>(
            builder: (context, state) {
              if (state is GotNotificationsState) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context) {
                      return const NotificationsPage();
                    }));
                  },
                  child: NotificationsBadgeWidget(
                    count: state.notifications.length,
                  ),
                );
              } else {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context) {
                      return const NotificationsPage();
                    }));
                  },
                  child: NotificationsBadgeWidget(
                    count: 0,
                  ),
                );
              }
            },
          ),
          const Spacer(),
          BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is GotProfileState) {
                return RoundAvatarWidget(
                  userEntity: state.userEntity,
                  size: 65,
                );
              }
              if (state is ProfileLoadingState) {
                return Center(
                  child: CupertinoActivityIndicator(),
                );
              }
              return Center();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAllFriendsButtons() {
    return Row(
      children: [
        GlassContainerWithTap(
          onTap: () {
            setState(() {
              isAllStrollsShown = true;
            });
          },
          height: 35,
          width: 85,
          gradient: isAllStrollsShown
              ? getSelectedGradient()
              : getUnselectedGradient(),
          child: const Center(
              child: Text(
            "All",
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          )),
        ),
        const SizedBox(
          width: 10,
        ),
        GlassContainerWithTap(
          onTap: () {
            setState(() {
              isAllStrollsShown = false;
            });
          },
          height: 35,
          width: 85,
          gradient: isAllStrollsShown
              ? getUnselectedGradient()
              : getSelectedGradient(),
          child: const Center(
              child: Text(
            "Friends",
            style: TextStyle(
                color: Color(0xFFAEAEAE),
                fontSize: 16,
                fontWeight: FontWeight.bold),
          )),
        ),
      ],
    );
  }

  LinearGradient getSelectedGradient() {
    return LinearGradient(
      begin: const Alignment(-0.95, -0.32),
      end: const Alignment(0.95, 0.32),
      colors: [
        const Color(0xFFFF0000).withOpacity(0.2),
        const Color(0xFF6D4904).withOpacity(0.2)
      ],
    );
  }

  LinearGradient getUnselectedGradient() {
    return LinearGradient(
      begin: const Alignment(-0.95, -0.32),
      end: const Alignment(0.95, 0.32),
      colors: [
        const Color(0xFF533C46).withOpacity(0.2),
        const Color(0x00533C46).withOpacity(0.2)
      ],
    );
  }
}
