
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_delivery_app/src/controllers/reviews_controller.dart';
import 'package:food_delivery_app/src/repository/user_repository.dart';

class RatingDialog extends StatelessWidget {
  final String id;
  RatingDialog(this.id);
  ReviewsController _con=new ReviewsController();
  final _ratetext = TextEditingController();
String rating;
  LinearGradient mainButton = LinearGradient(colors: [
  Color.fromRGBO(236, 60, 3, 1),
  Color.fromRGBO(234, 60, 3, 1),
  Color.fromRGBO(216, 78, 16, 1),
], begin: FractionalOffset.topCenter, end: FractionalOffset.bottomCenter);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    Widget payNow = InkWell(
      onTap: () async {
        Navigator.of(context).pop();
       // _con.foodsReviews[int.parse(id)].review = _ratetext.text;

        //  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>CheckOutPage()));
        _con.addFoodReview( _ratetext.text, rating,currentUser.value.id,id);

      },
      child: Container(
        height: 60,
        width: width / 1.5,
        decoration: BoxDecoration(
            gradient: mainButton,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.16),
                offset: Offset(0, 5),
                blurRadius: 10.0,
              )
            ],
            borderRadius: BorderRadius.circular(9.0)),
        child: Center(
          child: Text("Add",
              style: const TextStyle(
                  color: const Color(0xfffefefe),
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                  fontSize: 20.0)),
        ),
      ),
    );

    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.grey[50]),
          padding: EdgeInsets.all(24.0),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Text(
              'Thank You!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: RichText(
                text: TextSpan(
                    style:
                        TextStyle(fontFamily: 'Montserrat', color: Colors.grey),
                    children: [
                      TextSpan(
                        text: 'You rated ',
                      ),

                    ]),
              ),
            ),
            FlutterRatingBar(
//                      borderColor: Color(0xffFF8993),
//                      fillColor: Color(0xffFF8993),

              itemSize: 32,
              allowHalfRating: false,
              initialRating: 1,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              fullRatingWidget:
                  Icon(Icons.favorite, color: Color(0xffFF8993), size: 32),
              noRatingWidget: Icon(Icons.favorite_border,
                  color: Color(0xffFF8993), size: 32),
              onRatingUpdate: (value) {
                rating = value.toString();


                //  _con.foodsReviews[int.parse(id)].rate = value.toString();

                print(value);
              },
            ),
            Container(
                margin: EdgeInsets.symmetric(vertical: 16.0),
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: TextField(
                  controller: _ratetext,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                      hintText: 'Say something about this resturant.'),
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  maxLength: 200,
                )),
            payNow
          ])),
    );
  }
}
