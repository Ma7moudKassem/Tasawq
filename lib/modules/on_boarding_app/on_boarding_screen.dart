import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tasawq/modules/login/shop_login_screen.dart';
import 'package:tasawq/shared/components/components.dart';
import 'package:tasawq/shared/network/remote/cache_helper.dart';
import 'package:tasawq/shared/styles/colors.dart';


class BoardingModel{
  final String image;
  final String title;
  final String body;

  BoardingModel({
    @required this.image,
    @required this.title,
    @required this.body,
});

}

class OnBoardingScreen extends StatefulWidget {

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();


  List<BoardingModel> boarding = [
    BoardingModel (
        image: 'assets/images/onboarda.jpg',
        title: 'On Board 1 Title',
        body: 'On Bord 1 body '),
    BoardingModel (
        image: 'assets/images/onboarda.jpg',
        title: 'On Board 2 Title',
        body: 'On Bord 2 body '),
    BoardingModel (
        image: 'assets/images/onboarda.jpg',
        title: 'On Board 3 Title',
        body: 'On Bord 3 body '),
  ];

  bool isLast = false;

  void submit()
  {
    CacheHelper.saveData(
        key: 'onBoarding',
        value: true
    ).then((value)
    {
     if (value)
       {
         navigateAndFinish(
             context,
             ShopLoginScreen()
         );

       }
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
              function:submit,
              text: 'Skip')
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                  itemBuilder: (context, index)=>buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
                controller: boardController,
                physics: BouncingScrollPhysics(),
                onPageChanged: (int index)
                {
                  if(index == boarding.length - 1)
                    {
                    setState(() {
                     isLast = true;

                    });
                      print('last');
                    }else
                      {

                        setState(() {
                        isLast = false;
                        print('not Last');

                        });
                      }
                },
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(controller: boardController, count: boarding.length,
                effect: ExpandingDotsEffect(
                  activeDotColor: defaultColor,
                  dotColor: Colors.grey,
                  dotHeight: 10,
                  expansionFactor: 4,
                  dotWidth: 10,
                  spacing: 5
                ),),

                Spacer(),
                FloatingActionButton(onPressed: ()
                {
                  if(isLast)
                    {
                     submit();
                    }else{
                    boardController.nextPage(
                        duration: Duration(
                            milliseconds: 750
                        ) ,
                        curve: Curves.fastLinearToSlowEaseIn);

                  }

                },
                  child: Icon(Icons.arrow_forward_ios),),
              ],
            ),
          ],
        ),
      ),

    );
  }

  Widget buildBoardingItem(BoardingModel model)=> Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(child: Image(image: AssetImage('${model.image}'))),
      SizedBox(
        height: 30,
      ),
      Text('${model.title}',
        style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold
        ),),
      SizedBox(
        height: 15,
      ),
      Text('${model.body}',
        style: TextStyle(
          fontSize: 14,
        ),),
      SizedBox(
        height: 60,
      ),

    ],
  );
}
