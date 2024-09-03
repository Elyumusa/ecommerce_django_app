import 'package:e_commerce_site_django/common/utils/kcolors.dart';
import 'package:e_commerce_site_django/common/widgets/app_style.dart';
import 'package:e_commerce_site_django/common/widgets/back_button.dart';
import 'package:e_commerce_site_django/common/widgets/custom_text.dart';
import 'package:e_commerce_site_django/common/widgets/reusable_text.dart';
import 'package:e_commerce_site_django/src/reviews/controllers/rating_notifier.dart';
import 'package:e_commerce_site_django/src/reviews/models/create_rating_model.dart';
import 'package:e_commerce_site_django/src/reviews/widgets/review_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final TextEditingController _reviewController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: ReusableText(
            text: "Add Review",
            style: appStyle(15, Kolors.kPrimary, FontWeight.bold)),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 12),
        children: [
          SizedBox(
            height: 10.h,
          ),
          const ReviewTile(),
          SizedBox(
            height: 10,
          ),
          Divider(
            thickness: 0.5.h,
            color: Kolors.kGrayLight,
          ),
          Center(
            child: ReusableText(
                text: "Rate your order",
                style: appStyle(16, Kolors.kPrimary, FontWeight.bold)),
          ),
          SizedBox(
            height: 10.h,
          ),
          Divider(
            thickness: 0.5.h,
            color: Kolors.kGrayLight,
          ),
          SizedBox(
            height: 10.h,
          ),
          Center(
            child: RatingBar.builder(
                initialRating: 3.0,
                itemSize: 60,
                minRating: 1.0,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.w),
                allowHalfRating: false,
                itemBuilder: (context, _) =>
                    const Icon(Icons.star, color: Kolors.kGold, size: 50),
                onRatingUpdate: (r) {
                  context.read<RatingNotifier>().setRating(r);
                }),
          ),
          SizedBox(
            height: 20.h,
          ),
          Divider(
            thickness: 0.5.h,
            color: Kolors.kGrayLight,
          ),
          Center(
            child: ReusableText(
                text: "Add Review",
                style: appStyle(16, Kolors.kPrimary, FontWeight.bold)),
          ),
          SizedBox(
            height: 10.h,
          ),
          CustomTextField(
            maxLines: 7,
            controller: _reviewController,
            hintText: "Write your review here",
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
        height: 60,
        color: Kolors.kOffWhite,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
                onPressed: () {},
                child: ReusableText(
                    text: "Cancel",
                    style: appStyle(18, Kolors.kRed, FontWeight.bold))),
            ElevatedButton(
                onPressed: () {
                  var rating = CreateRating(
                      review: _reviewController.text,
                      rating: context.read<RatingNotifier>().rating,
                      product: context.read<RatingNotifier>().order!.productId,
                      order: context.read<RatingNotifier>().orderId);
                  String data = createRatingToJson(rating);
                  context.read<RatingNotifier>().addReview(data, context);
                  print("rating data: ${data}");
                },
                child: ReusableText(
                    text: "Submit",
                    style: appStyle(18, Kolors.kPrimary, FontWeight.bold)))
          ],
        ),
      ),
    );
  }
}
