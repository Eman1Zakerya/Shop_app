import 'package:flutter/material.dart';
import 'package:shop_app/modules/shop_app/login/shop_login_screen.dart';
import 'package:shop_app/network/local/cash_helper.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class BordingModel
{
  final String? image;
  final String? title;
  final String? body;
  BordingModel({this.image,this.title,this.body});

  
}

class OnBoardingScreen extends StatefulWidget {

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

List<BordingModel> boarding =[
  BordingModel(
    image:'assets/images/onboarding1.png',
    title: 'On Board 1 Title',
    body: 'On Board 1 Body',
     ),
     BordingModel(
    image:'assets/images/onboarding2.png',
    title: 'On Board 2 Title',
    body: 'On Board 2 Body',
     ),
     BordingModel(
    image:'assets/images/onboarding3.png',
    title: 'On Board 3 Title',
    body: 'On Board 3 Body',
     ),
];

bool isLast = false;

void submit(){
  CashHelper.saveData(key: 'onBoarding', value: true)
  .then((value) {
    if(value!)
    {
      navigateAndFinish(context, ShopLoginScreen());
    }

  } ,);
  

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed:submit,
          child: Text('SKIP',style: TextStyle(fontSize: 20),))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardController,
                onPageChanged: (int index){
                  if(index == boarding.length -1)
                  {
                    setState(() {
                      isLast = true;
                    });
                  
                  }else{
                     setState(() {
                      isLast = false;
                    });
                   

                  }
                },
                itemBuilder: ((context, index) =>buildBoardingItem(boarding[index]) ),
              itemCount: boarding.length,
              ),
            ),
            SizedBox(height: 40,),
            Row(
              children: [
                SmoothPageIndicator(controller: boardController,
                effect: ExpandingDotsEffect(
                  dotColor: Colors.grey,
                  activeDotColor: defaultColor,
                  dotHeight: 10,
                  expansionFactor: 4,
                  dotWidth: 10,
                  spacing: 5,
                ), 
                count: boarding.length),
                Spacer(),
                FloatingActionButton(
                  onPressed: ()
                  {

                    if(isLast)
                    {
                      submit();
                    }
                    else
                    {
                       boardController.nextPage(duration: Duration(milliseconds: 750), 
                    curve: Curves.fastLinearToSlowEaseIn);
                    }

                    
                  },
                child: Icon(Icons.arrow_forward_ios),
                )
              ],
            )
            
          ],
        ),
      ),
    );
  }
}

Widget buildBoardingItem (BordingModel model)=>  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:  [
        Expanded(child: Image(image: AssetImage('${model.image}'),)),
        const SizedBox(height: 30,),
        Text('${model.title}',
        style: const TextStyle(
          fontSize: 24,
          
        ),
        ),
        const SizedBox(height: 15,),
         Text('${model.body}',
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold
        ),
        ),
        const SizedBox(height: 30,)
      ]
      );
 

  
  
