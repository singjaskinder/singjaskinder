
// class BuildFeaturedVideoTile extends StatelessWidget {
//   const BuildFeaturedVideoTile(this.featuredVideo, {Key key}) : super(key: key);
//   final FeaturedVideo featuredVideo;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         print('uhuhu');
//       },
//       child: Padding(
//         padding: const EdgeInsets.only(left: 10.0),
//         child: Container(
//           width: SizeConfig.widthMultiplier * 58,
//           child: Stack(
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(15.0),
//                 child: Image.asset(
//                   featuredVideo.image,
//                   fit: BoxFit.cover,
//                   width: double.infinity,
//                   height: double.infinity,
//                 ),
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                   color: AppColors.black.withOpacity(0.35),
//                   borderRadius: BorderRadius.circular(15.0),
//                 ),
//               ),
//               Center(
//                 child: Icon(Icons.play_arrow,
//                     color: AppColors.white,
//                     size: SizeConfig.widthMultiplier * 10),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
