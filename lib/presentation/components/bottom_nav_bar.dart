import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../../consetant/page_routes.dart';

class BottomNavBar extends StatelessWidget {
  late final int screenIndex;
  BottomNavBar({super.key,required this.screenIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
      child: _bottomBarContainer(screenIndex , context),
    );
  }

  Widget _bottomBarContainer( int screenIndex, BuildContext context){
    return Padding(
      padding:  Directionality.of(context).name == TextDirection.ltr.name? const EdgeInsets.only(left: 30):const EdgeInsets.only(right: 30),
      child: Container(
        clipBehavior: Clip.hardEdge,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow:Theme.of(context).badgeTheme == Brightness.light? [
            const BoxShadow(
                color: Colors.grey,
                blurRadius: 8
            ),
          ]:[
            const BoxShadow(
                color: Colors.black45,
                blurRadius: 8
            ),
          ],
        ),
        child: _bottomBarContent(screenIndex,context),
      ),
    );
  }

  Widget _bottomBarContent( int screenIndex, BuildContext context){
    return NavigationBar(
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      selectedIndex: screenIndex,
      height: 60,
      destinations: _bottomBarIcons(context),
      onDestinationSelected: (selectedIndex){
        if(selectedIndex == 0 && screenIndex != 0) {
          Navigator.of(context).pushNamed(PageRoutes.addTaskScreen);
        }
        if(selectedIndex == 1 && screenIndex != 1) {
          Navigator.of(context).pushNamed(PageRoutes.homeScreen);
        }
        if(selectedIndex == 2&& screenIndex != 2) {
          Navigator.of(context).pushNamed(PageRoutes.paginationScreen);
        }
      },
    );
  }

  List<Widget> _bottomBarIcons(BuildContext context){
    return [
      NavigationDestination(icon: const Icon(Icons.add), label: AppLocalizations.of(context)!.new_task),
      NavigationDestination(icon: const Icon(Icons.home), label: AppLocalizations.of(context)!.home),
      NavigationDestination(
          icon: const Icon(Icons.menu_open),
          label: AppLocalizations.of(context)!.pagination),
    ];
  }
}


