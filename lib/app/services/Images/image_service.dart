// import 'dart:typed_data';

// import 'package:get/get.dart';

// class ImageService extends GetConnect {
//   Future<Uint8List> fetchImage() async {
//     try {
//       Response response = await get(imageUrl);
//       if (response.status.hasError) {
//         throw 'Error ${response.statusText}';
//       } else {
//         final bytes = response.bodyBytes;
//         return bytes;
//       }
//     } catch (error) {
//       print('Error: $error');
//     }
//   }
// }