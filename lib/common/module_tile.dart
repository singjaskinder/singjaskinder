

// class BuildModuleTile extends StatelessWidget {
//   const BuildModuleTile(this.subject, {Key key}) : super(key: key);
//   final Subject subject;

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.all(Radius.circular(10)),
//       child: Container(
//         width: SizeConfig.widthMultiplier * 36,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.all(Radius.circular(10)),
//           color: AppColors.lightGrey,
//         ),
//         child: Stack(
//           children: [
//             Image.asset(
//               subject.image,
//               fit: BoxFit.cover,
//               width: double.infinity,
//               height: double.infinity,
//             ),
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: Padding(
//                 padding: const EdgeInsets.all(15.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     BuildText(
//                       subject.title.capitalize,
//                       color: AppColors.white,
//                       isBold: true,
//                       size: 1.45,
//                       fontFamily: 'Anybody Expanded Bold',
//                     ),
//                     BuildSizedBox(),
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(8.0),
//                       child: LinearProgressIndicator(
//                         value: subject.progress,
//                         minHeight: 8.0,
//                         backgroundColor: Colors.grey,
//                         valueColor: AlwaysStoppedAnimation<Color>(
//                           AppColors.white,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
