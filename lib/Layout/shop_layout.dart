import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasawq/shared/cubit/states.dart';

import '../shared/cubit/cubit.dart';
import '../shared/styles/icons_broken.dart';
class ShopLayout extends StatelessWidget {




  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit , ShopState>(
     listener: (context ,state){},
     builder: (context ,state)
        {


          var cubit = ShopCubit.get(context);
          return  Scaffold(
            appBar: AppBar(
              title:Text(
                  'TASAWQ'
              ),
              actions: [
                IconButton(
                    onPressed: (){

                      ShopCubit.get(context).getHomeData();


                      // navigateTo(context, ShopSearchScreen());
                    },
                    icon: Icon(
                      IconBroken.Search,
                    ))
              ],


            ),
            body: cubit.bottomScreens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index){
                cubit.changeBottom(index);
              },
              currentIndex: cubit.currentIndex,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(IconBroken.Home),
                  label: 'Home'
                ),
                BottomNavigationBarItem(
                  icon: Icon(IconBroken.Category),
                  label: 'Categories'
                ),
                BottomNavigationBarItem(
                  icon: Icon(IconBroken.Heart),
                  label: 'Favorite'
                ),
                BottomNavigationBarItem(
                  icon: Icon(IconBroken.Setting),
                  label: 'Settings'
                ),
              ],
            ),
          );
        }
    );
  }
}
