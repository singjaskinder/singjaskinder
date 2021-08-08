import 'package:dlivrDriver/common/buttons.dart';
import 'package:dlivrDriver/common/sized_box.dart';
import 'package:dlivrDriver/common/text.dart';
import 'package:dlivrDriver/common/text_field.dart';
import 'package:dlivrDriver/common/view_with_background.dart';
import 'package:dlivrDriver/res/app_colors.dart';
import 'package:dlivrDriver/res/app_styles.dart';
import 'package:dlivrDriver/utils/local.dart';
import 'package:dlivrDriver/utils/size_config.dart';
import 'package:dlivrDriver/utils/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'add_rating_controller.dart';

class AddRating extends StatelessWidget {
  const AddRating({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddRatingController());
    return BuildViewWithBackground(
      hasBackButton: true,
      haveSafeArea: false,
      positionedImage: Positioned(
        bottom: 0,
        top: 300,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Opacity(
            opacity: 0.8,
            child: Image.asset(
              getImage('bg_main2.png'),
            ),
          ),
        ),
      ),
      gradient: AppStyles.lightGradient,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BuildSizedBox(),
            Align(
              alignment: Alignment.topCenter,
              child: BuildText(
                'Rate User',
                size: 3.5,
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            BuildSizedBox(),
            Spacer(),
            BuildRateTile(
              currentSelected: controller.ratings,
              onSelected: (val) => controller.ratings = val,
            ),
            Form(
              key: controller.formKey,
              child: BuildCustomTextField(
                hint: 'Description',
                centerCursor: true,
                controller: controller.descriptionCtrl,
                textInputAction: TextInputAction.done,
                validator: (val) => Validation.validateField(
                    val, 'Please enter valid description',
                    minlength: 1),
              ),
            ),
            BuildSizedBox(height: 5),
            Spacer(
              flex: 2,
            ),
            BuildPrimaryButton(
              onTap: () => controller.addRate(),
              label: 'Rate',
            ),
          ],
        ),
      ),
    );
  }
}

class BuildRateTile extends StatefulWidget {
  const BuildRateTile(
      {@required this.onSelected, @required this.currentSelected, Key key})
      : super(key: key);
  final Function(int val) onSelected;
  final int currentSelected;

  @override
  _BuildRateTileState createState() => _BuildRateTileState();
}

class _BuildRateTileState extends State<BuildRateTile> {
  int isActive;

  @override
  void initState() {
    super.initState();
    isActive = widget.currentSelected;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.heightMultiplier * 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 0; i < 5; i++)
            GestureDetector(
              onTap: () {
                widget.onSelected(i);
                setState(() {
                  isActive = i;
                });
              },
              child: Icon(
                Icons.star,
                color: isActive >= i
                    ? AppColors.yellow
                    : AppColors.darkGrey.withOpacity(0.5),
                size: SizeConfig.imageSizeMultiplier * 12,
              ),
            )
        ],
      ),
    );
  }
}
