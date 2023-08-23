import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strolls/core/getit/get_it.dart';
import 'package:strolls/core/widgets/title_text.dart';
import 'package:strolls/features/home/presentation/widgets/glass_container_with_tap.dart';
import 'package:strolls/features/notification/presentation/pages/notifications_page.dart';
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

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<StrollsBloc>()..add(GetStrollsEvent()),
        ),
        BlocProvider(
          create: (context) => getIt<ProfileBloc>()..add(GetProfileEvent()),
        ),
      ],
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          BackgroundWithCircles(
            child: Padding(
              padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
              child: SingleChildScrollView(
                child: SafeArea(
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
                      Row(
                        children: [
                          _buildAllFriendsButtons(),
                          const SizedBox(
                            width: 10,
                          ),
                          Icon(
                            CupertinoIcons.bars,
                            color: Colors.white.withOpacity(0.7),
                            size: 30,
                          ),
                        ],
                      ),
                      _getStrolls()
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

  Widget _getStrolls() {
    return BlocBuilder<ProfileBloc, ProfileState>(
  builder: (context, profileState) {
    if(profileState is GotProfileState){
      return BlocBuilder<StrollsBloc, StrollsState>(
        builder: (context, state) {
          if (state is GotStrollsState) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    StrollItem(strollEntity: state.strolls[index], profileId: profileState.userEntity.id,),
                  ],
                );
              },
              itemCount: state.strolls.length,
              shrinkWrap: true,
            );
          }
          return const Center();
        },
      );

    }
    return const Center(child: CupertinoActivityIndicator(),);
  },
);
  }

  Widget _buildAppBar() {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if(state is GotProfileState){
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
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, CupertinoPageRoute(builder: (context){
                      return const NotificationsPage();
                    }));
                  },
                  child: Container(
                      width: 35,
                      height: 35,
                      margin: const EdgeInsets.only(top: 4),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment(0.00, -1.00),
                          end: Alignment(0, 1),
                          colors: [Color(0xFFFFE5BF), Color(0xFFFFC555)],
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          '1',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      )),
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 65,
                    height: 65,
                    child: ClipOval(
                      child: Image.network(
                        state.userEntity.avatarUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment(0.00, -1.00),
                        end: Alignment(0, 1),
                        colors: [Color(0xFFBFF8FF), Color(0xFF55CCFF)],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        else if(state is ProfileLoadingState){
          return const Center(child: CupertinoActivityIndicator());
        }
        else {
          return const Center(child: Text("Error"),);
        }
      },
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
