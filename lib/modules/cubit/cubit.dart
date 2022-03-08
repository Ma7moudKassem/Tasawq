import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasawq/shared/network/remote/dio_helper.dart';

import '../../models/shop_app/login_model.dart';
import '../../shared/network/end_point.dart';
import 'states.dart';

class ShopLoginCubit extends Cubit<ShopLoginState>{

  ShopLoginCubit(): super (ShopLoginInitialState());
  
  static ShopLoginCubit get(context)=> BlocProvider.of(context);

ShopLoginModel loginModel;
  void userLogin({
  @required String email,
  @required String password,
})
  {
    emit(ShopLoginLoadingState());
    DioHelper.postData(url: LOGIN,
        data: {
      'email':email,
      'password':password,
        }).then((value) {
     // print(value.data);

      loginModel= ShopLoginModel.fromJson(value.data);
      //
       print(value.data);
      //print(value.data['message']);
     print(loginModel.message);
      print(loginModel.status);
         //print(loginModel.data.token);

          emit(ShopLoginSuccessState(loginModel));
    }).catchError((error){
      emit(ShopLoginErrorState(error.toString()));
    });

  }


  IconData suffix = Icons.visibility;
 bool isPassword = true;
  void changePasswordVisibility()
  {
    isPassword=!isPassword;

    suffix =isPassword ? Icons.visibility : Icons.visibility_off;

    emit(ShopChangePasswordVisibilityState());
  }

}