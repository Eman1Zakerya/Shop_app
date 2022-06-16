

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import 'package:shop_app/models/shop_app/categories_model.dart';
import 'package:shop_app/models/shop_app/home_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) { 
        if(state is ShopChangeFavoritesState)
        {
          if(!state.model!.status!)
          {
            showToast(text: state.model!.message!, state: ToastState.ERROR);
          }
        }
      },
      builder: (context, state) { 
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null && ShopCubit.get(context).categoriesModel != null, 
          builder:(context)=>productsBuilder(ShopCubit.get(context).homeModel!, ShopCubit.get(context).categoriesModel!,context) , 
          fallback: (context)=>const Center(child: const CircularProgressIndicator())
          );
      } ,
    );
   
  }
//
  //
  Widget productsBuilder(HomeModel model, CategoriesModel categoriesModel , context) => SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
          items: model.data.bannars.map((e) =>
             Image
            (image:  NetworkImage('${e.image}'),
            width: double.infinity,
            fit: BoxFit.cover,
            )
           ).toList(),
          options:CarouselOptions(
            height: 250,
            initialPage: 0,
            viewportFraction: 1,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(seconds: 1),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
  
          )
          ),
          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Categories',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800
                ),
                ),
                const SizedBox(height: 10,),
         Container(
                 height: 100,
                 child: ListView.separated(
                   physics: const BouncingScrollPhysics(),
                   scrollDirection: Axis.horizontal,
                   itemBuilder: ((context, index) =>buildCategoryItem(categoriesModel.data!.data[index]) ), 
                   separatorBuilder:((context, index) =>const SizedBox(width: 10,) ), 
                   itemCount: categoriesModel.data!.data.length
                   ),
         ),
         const SizedBox(height: 20,),
                const Text('New Products',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800
                ),
                ),
              ],
            ),
          ),
           const SizedBox(height: 10,),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 1,
              crossAxisSpacing: 10,
              childAspectRatio: 1 / 1.61,
            children: List.generate(model.data.products.length, 
            (index) => buildGridProduct(model.data.products[index], context)
            ),
            ),
          )
      ],
    ),
  );
 Widget buildCategoryItem(DataModel model)=> Container(
            width: 100,
            height: 100,
            child: Stack(
              alignment:AlignmentDirectional.bottomCenter,
              children: [
                Image(
                  image: NetworkImage(model.image!),
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                  ),
                  Container(
                    width: double.infinity,
                    color: Colors.black.withOpacity(0.8),
                    child: Text(model.name!,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                     color: Colors.white
                          
                    ),
                    )),

              ],
            ),
          );

  Widget buildGridProduct(ProductsModel model , context)=>Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Image(image: NetworkImage(model.image!),
                    width: double.infinity,
                    height: 200,
               
                    ),
                    if(model.discount != 0)
                    Container(
                      color: Colors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: const Text('Discount',
                      style: TextStyle(
                          fontSize: 9,
                          color: Colors.white
                      ),
                      ),
                    )
                  ],
                ),
               Padding(
                 padding: const EdgeInsets.all(12.0),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                      Text(model.name!,style: const TextStyle(
                    height: 1.3,
                    fontWeight: FontWeight.bold,
                    
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Text('${model.price}',
                      style: const TextStyle(
                        fontSize: 12,
                        height: 1.3,
                        fontWeight: FontWeight.bold,
                        color: defaultColor
                      ),
                 
                      ),
                      const SizedBox(width: 5,),
                      if(model.discount != 0)
                      Text('${model.old_price}',
                      style: const TextStyle(
                        fontSize: 10,
                        height: 1.3,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough
                      ),
                 
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: (){
                          ShopCubit.get(context).changeFavorites(model.id!);
                          print(model.id);
                        }, 
                      icon:  CircleAvatar(
                        radius: 15,
                        backgroundColor: ShopCubit.get(context).favorites[model.id]! ? defaultColor : Colors.grey,
                        child: Icon(Icons.favorite_border,
                        size: 14,
                         color: Colors.white,
                        ),
                      )
                      )

                    ],
                  ),
                   ],
                 ),
               )
              ],
            ),
  );
}