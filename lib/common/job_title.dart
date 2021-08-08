import 'package:dlivrDriver/common/sized_box.dart';
import 'package:dlivrDriver/common/text.dart';
import 'package:dlivrDriver/models/api_response/job_m.dart';
import 'package:dlivrDriver/res/app_colors.dart';
import 'package:dlivrDriver/res/app_styles.dart';
import 'package:dlivrDriver/utils/local.dart';
import 'package:dlivrDriver/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuildJobTile extends StatelessWidget {
  const BuildJobTile(this.job, {this.onTap, Key key}) : super(key: key);
  final Jobs job;
  final Function onTap;

  Color getColorViaStatus() {
    job.status = job.status.toLowerCase();
    if (job.status == 'bidding') {
      return AppColors.blue;
    } else if (job.status == 'completed') {
      return AppColors.green;
    } else if (job.status.contains('progress')) {
      return AppColors.yellow;
    } else if (job.status == 'upcoming') {
      return AppColors.medViolet;
    }
    return AppColors.red;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.all(Radius.circular(12)),
            boxShadow: [AppStyles.tileShadow]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: BuildText(
                makeDateTime(job.createdAt),
                size: 1.6,
              ),
            ),
            BuildSizedBox(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: SizeConfig.widthMultiplier * 70,
                  child: BuildText(
                    job.packageTitle + 'wefmwefwjp',
                    color: AppColors.darkViolet,
                    fontWeight: FontWeight.bold,
                    size: 2.4,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      border: Border.all(width: 1.4, color: AppColors.violet)),
                  child: BuildText(
                    withCurrency(job.finalBudget),
                    color: AppColors.violet,
                    fontWeight: FontWeight.bold,
                    size: 2.5,
                  ),
                )
              ],
            ),
            BuildSizedBox(),
            BuildText(
              job.packageDescription,
              color: AppColors.violet,
              size: 2,
            ),
            BuildSizedBox(),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    border: Border.all(
                      width: 2,
                      color: getColorViaStatus(),
                    )),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        height: SizeConfig.heightMultiplier * 3,
                        width: SizeConfig.heightMultiplier * 3,
                        decoration: BoxDecoration(
                            color: getColorViaStatus(),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border: Border.all(
                              width: 1.4,
                              color: getColorViaStatus(),
                            ))),
                    BuildSizedBox(
                      width: 2,
                    ),
                    BuildText(
                      job.status.capitalizeFirst,
                      fontWeight: FontWeight.w500,
                    ),
                    BuildSizedBox(
                      width: 2,
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
