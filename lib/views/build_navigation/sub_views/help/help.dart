import 'package:dlivrDriver/common/curved_body.dart';
import 'package:dlivrDriver/common/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'help_controller.dart';

class Help extends StatelessWidget {
  const Help({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HelpController());

    return BuildCurvedBody(title: 'Help', children: [
      Expanded(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: BuildText(
              '''
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Purus viverra accumsan in nisl nisi scelerisque eu ultrices. Tempor nec feugiat nisl pretium fusce id velit ut. Suspendisse sed nisi lacus sed viverra tellus in. Malesuada pellentesque elit eget gravida. A iaculis at erat pellentesque adipiscing commodo elit at. Potenti nullam ac tortor vitae purus faucibus. Diam quis enim lobortis scelerisque. Aenean pharetra magna ac placerat vestibulum lectus mauris ultrices. Malesuada pellentesque elit eget gravida cum sociis natoque penatibus. Lorem dolor sed viverra ipsum. Libero enim sed faucibus turpis in. Leo vel fringilla est ullamcorper.

Sit amet purus gravida quis blandit turpis. Turpis nunc eget lorem dolor sed viverra ipsum nunc aliquet. Montes nascetur ridiculus mus mauris. Habitasse platea dictumst vestibulum rhoncus est. Mauris vitae ultricies leo integer malesuada nunc vel. Feugiat vivamus at augue eget arcu. Viverra orci sagittis eu volutpat odio facilisis mauris sit amet. Ipsum dolor sit amet consectetur adipiscing elit duis tristique sollicitudin. Ut tellus elementum sagittis vitae et leo duis. Fusce id velit ut tortor pretium viverra suspendisse potenti. Aliquam ut porttitor leo a. Donec et odio pellentesque diam volutpat commodo sed egestas egestas. Velit scelerisque in dictum non consectetur a erat. Ut morbi tincidunt augue interdum velit euismod in pellentesque. Mi sit amet mauris commodo quis. Sapien faucibus et molestie ac. Dui sapien eget mi proin sed libero enim sed.

Tellus rutrum tellus pellentesque eu tincidunt tortor aliquam nulla facilisi. At lectus urna duis convallis convallis tellus id. Ac felis donec et odio pellentesque diam. Malesuada proin libero nunc consequat interdum. Velit ut tortor pretium viverra suspendisse potenti. Aliquam purus sit amet luctus venenatis lectus magna fringilla. Aliquet risus feugiat in ante metus dictum at tempor. Egestas dui id ornare arcu odio ut sem nulla. Sit amet nisl suscipit adipiscing bibendum. Sit amet mauris commodo quis imperdiet massa tincidunt nunc pulvinar.

Id diam maecenas ultricies mi eget mauris pharetra et. Enim neque volutpat ac tincidunt vitae semper quis lectus. Potenti nullam ac tortor vitae purus faucibus ornare suspendisse. Cras fermentum odio eu feugiat pretium nibh ipsum consequat nisl. Pulvinar pellentesque habitant morbi tristique. Auctor eu augue ut lectus arcu bibendum at. Malesuada proin libero nunc consequat interdum varius sit amet. Imperdiet sed euismod nisi porta lorem mollis aliquam ut porttitor. A cras semper auctor neque. Ante metus dictum at tempor commodo ullamcorper a. Tellus in metus vulputate eu. Ultrices eros in cursus turpis massa. Ultrices gravida dictum fusce ut placerat. Suspendisse sed nisi lacus sed viverra tellus in. Nulla pellentesque dignissim enim sit amet venenatis urna cursus eget. Faucibus a pellentesque sit amet porttitor. Et sollicitudin ac orci phasellus egestas. Arcu vitae elementum curabitur vitae nunc sed velit. Sagittis id consectetur purus ut faucibus pulvinar. Tincidunt eget nullam non nisi est sit amet facilisis magna.

Lectus mauris ultrices eros in cursus. Diam donec adipiscing tristique risus nec feugiat in fermentum. Proin fermentum leo vel orci. Ornare arcu dui vivamus arcu felis bibendum ut tristique et. Est pellentesque elit ullamcorper dignissim cras. Eu augue ut lectus arcu bibendum at varius vel. Eget dolor morbi non arcu risus quis varius quam quisque. Tellus orci ac auctor augue mauris. Rhoncus dolor purus non enim. Tristique risus nec feugiat in fermentum posuere urna. Et tortor consequat id porta. Luctus venenatis lectus magna fringilla urna porttitor rhoncus dolor. Lorem sed risus ultricies tristique nulla aliquet. Natoque penatibus et magnis dis parturient montes nascetur.
              ''',
              size: 2.15,
              textAlign: TextAlign.justify,
            ),
          ),
        ),
      )
    ]);
  }
}
