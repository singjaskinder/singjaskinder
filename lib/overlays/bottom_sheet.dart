import 'package:dlivrDriver/common/buttons.dart';
import 'package:dlivrDriver/common/sized_box.dart';
import 'package:dlivrDriver/common/text.dart';
import 'package:dlivrDriver/res/app_colors.dart';
import 'package:dlivrDriver/routes/app_routes.dart';
import 'package:dlivrDriver/utils/local.dart';
import 'package:dlivrDriver/utils/size_config.dart';
import 'package:flutter/material.dart';

class BuildBottomSheet {
  BuildBottomSheet(BuildContext context, {Widget body}) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              BuildSizedBox(height: 2.4),
              body,
              BuildSizedBox(height: 2.4),
            ],
          ),
        );
      },
    );
  }
}

class BuildRetryBottomSheet {
  BuildRetryBottomSheet(BuildContext context, Function whenRetry,
      {String text,
      String label,
      bool done = false,
      bool errored = false,
      bool cancellable = true,
      bool autoClose = false}) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              BuildSizedBox(height: 2.4),
              Image.asset(
                getImage((done ? 'done' : 'info') + '.png'),
                width: SizeConfig.imageSizeMultiplier * 30,
              ),
              BuildSizedBox(),
              BuildText(text ?? 'Oops,\nSomething Went wrong...',
                  size: 2.55,
                  textAlign: TextAlign.center,
                  color: AppColors.violet,
                  fontWeight: FontWeight.w600),
              BuildSizedBox(
                height: 2.5,
              ),
              BuildPrimaryButton(
                onTap: () {
                  if (!errored) {
                    Routes.back();
                  }
                  if (autoClose) {
                    Routes.back();

                  }
                  whenRetry();
                },
                label: label ?? 'Try Again',
              ),
              BuildSizedBox(height: 2),
              Visibility(
                visible: cancellable,
                child: BuildPrimaryButton(
                  onTap: () => Routes.back(),
                  label: 'Cancel',
                  isOutLined: true,
                ),
              ),
              BuildSizedBox(height: 2.4),
            ],
          ),
        );
      },
    );
  }
}
