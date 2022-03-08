import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasawq/modules/cubit/cubit.dart';
import 'package:tasawq/modules/cubit/states.dart';
import 'package:tasawq/modules/register/shop_register_screen.dart';
import 'package:tasawq/shared/components/components.dart';
import 'package:tasawq/shared/network/remote/cache_helper.dart';
import 'package:tasawq/shared/styles/icons_broken.dart';

import '../../Layout/shop_layout.dart';
class ShopLoginScreen extends StatelessWidget
{

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    var formKey =GlobalKey<FormState>();

    return BlocProvider(
      create: (BuildContext context)=>ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginState>(
          listener: (context , state){
            if(state is ShopLoginSuccessState )
              {
                if(state.loginModel.status)
                  {

                    print(state.loginModel.message);
                    print(state.loginModel.data.token);

                   CacheHelper.saveData(
                       key: 'token',
                       value: state.loginModel.data.token
                   ).then((value) {
                   navigateAndFinish(context, ShopLayout());
                   });

                  }else{print(state.loginModel.message);
                showToast(
                    text: state.loginModel.message);
                }

              }
          },
          builder: (context , state){
            return Scaffold(

              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('LOGIN',
                            style: Theme.of(context).textTheme.headline4.copyWith(color: Colors.black),),
                          Text('Login now to browse our hot offers',
                            style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.grey),),
                          SizedBox(height: 30,),
                          defaultTextFormField(
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              prefix: IconBroken.Message,
                              lapelText: 'E-mail Address',
                              validate: (String value)
                              {
                                if(value.isEmpty){
                                  return 'Please enter your email ';
                                }
                              }),
                          SizedBox(
                            height: 20,
                          ),


                          defaultTextFormField(
                              controller: passwordController,
                              type: TextInputType.visiblePassword,
                              prefix: IconBroken.Lock,
                              lapelText: 'Password',
                              isPassword: ShopLoginCubit.get(context).isPassword,
                              suffixPressed: ()
                              {
                                ShopLoginCubit.get(context).changePasswordVisibility();
                              },
                              onSubmitted: (value)
                              {
                                if(formKey.currentState.validate())
                                {
                                  ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              suffix:ShopLoginCubit.get(context).suffix,
                              validate: (String value){
                                if(value.isEmpty){
                                  return 'Please enter password ';
                                }
                              }),
                          SizedBox(height: 15,),


                          ConditionalBuilder(
                            condition:state is! ShopLoginLoadingState,
                            builder: (context)=> defaultButton(
                              background: Colors.pink,
                              function: ()
                              {
                                if(formKey.currentState.validate())
                                {
                                  ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              isUpperCase: true,
                              radius: 10,
                              height: 50,
                              text: 'Login'

                            ),
                            fallback:(context)=> Center(child: CircularProgressIndicator()) ,
                          ),
                          SizedBox(height: 15,),
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Don\'t have an account?',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey
                                ),),
                                SizedBox(height: 15,),
                              defaultButton(
                              height: 50,
                              text: 'REGISTER NOW',
                              function: () {
                                navigateTo(context, RegisterScreen());
                              },
                              radius: 10,
                              background: Color(0xff69bed3),
                            ),
                          ],
                        ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

            );
          }
      ),
    );
  }
}
