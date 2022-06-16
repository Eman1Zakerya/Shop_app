import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import 'package:shop_app/layout/shop_app/shop_layout_screen.dart';
import 'package:shop_app/modules/shop_app/login/shop_login_screen.dart';
import 'package:shop_app/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:shop_app/network/local/cash_helper.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/shared/components/constant.dart';
import 'package:shop_app/shared/styles/thems.dart';
import 'shared/styles/bloc_observe.dart';



Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
   
  BlocOverrides.runZoned(
    () {
      // Use blocs...
       
    },
    blocObserver: MyBlocObserver(),
    
  );
   DioHelper.init();
   await  CashHelper.init();
   bool? isDark = CashHelper.getData(key: 'isDark');
  Widget widget;
  bool? onBoarding = CashHelper.getData(key: 'onBoarding');
   token = CashHelper.getData(key: 'token');

    if(onBoarding != null)
    {
      if(token !=null) widget = ShopLayout();
      else widget = ShopLoginScreen();
    }else widget = OnBoardingScreen();

  runApp(MyApp(startWidget: widget,  ) );


isDark;

}

class MyApp extends StatelessWidget {
  
    bool? isDark;
     Widget startWidget;

  MyApp({required this.startWidget,this.isDark} );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(BuildContext context)=>ShopCubit()..changeAppMode(fromShared: isDark)..getHomeData()..getCategoties()..getFavorites()..getUserData() ,
   
     
     
      child: BlocConsumer<ShopCubit,ShopStates>(
        listener: ((context, state) { }),
         builder: (context, state){
          return  MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
           themeMode:ShopCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
          
          home: startWidget
        );
        },
     
      
     ) 
     );
    
  }
}
