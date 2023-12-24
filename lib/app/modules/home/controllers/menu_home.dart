class MenuHomeModel {
  String? title;
  String? image;
  String? route;

  MenuHomeModel({this.title, this.image, this.route});

  MenuHomeModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    image = json['image'];
    route = json['route'];
  }
}

abstract class MenuHome {
  static List<Map<String, dynamic>> menuCleaner = [
    {
      'title': 'Cleaning',
      'image': 'assets/images/cleaning.png',
      'route': '/cleaning'
    },
    {
      'title': 'Training',
      'image': 'assets/images/training.png',
      'route': '/training'
    },
  ];

  static List<Map<String, dynamic>> menuManagement = [
    {
      'title': 'Cleaning',
      'image': 'assets/images/cleaning.png',
      'route': '/cleaning'
    },
    {
      'title': 'Report',
      'image': 'assets/images/report.png',
      'route': '/report'
    },
    {
      'title': 'Request',
      'image': 'assets/images/request.png',
      'route': '/requestmenu'
    },
    {
      'title': 'Stock Opname',
      'image': 'assets/images/stock.png',
      'route': '/stockopname'
    },
    {
      'title': 'User Verification',
      'image': 'assets/images/userverification.png',
      'route': '/user-verification'
    },
    {
      'title': 'Assesment',
      'image': 'assets/images/assesment.png',
      'route': '/assesment'
    },
    {
      'title': 'Training',
      'image': 'assets/images/training.png',
      'route': '/training'
    },
  ];

  static List<Map<String, dynamic>> menuSupervisor = [
    {
      'title': 'Cleaning',
      'image': 'assets/images/cleaning.png',
      'route': '/cleaning'
    },
    {
      'title': 'Report',
      'image': 'assets/images/report.png',
      'route': '/report'
    },
    {
      'title': 'Request',
      'image': 'assets/images/request.png',
      'route': '/requestmenu'
    },
    {
      'title': 'User Verification',
      'image': 'assets/images/userverification.png',
      'route': '/user-verification'
    },
    {
      'title': 'Assesment',
      'image': 'assets/images/assesment.png',
      'route': '/assesment'
    },
  ];

  static List<Map<String, dynamic>> menuLeader = [
    {
      'title': 'Cleaning',
      'image': 'assets/images/cleaning.png',
      'route': '/cleaning'
    },
    {
      'title': 'Request',
      'image': 'assets/images/request.png',
      'route': '/requestmenu'
    },
    {
      'title': 'User Verification',
      'image': 'assets/images/userverification.png',
      'route': '/user-verification'
    },
    {
      'title': 'Assesment',
      'image': 'assets/images/assesment.png',
      'route': '/assesment'
    },
    {
      'title': 'Training',
      'image': 'assets/images/training.png',
      'route': '/training'
    },
  ];

  static List<Map<String, dynamic>> menuDanone = [
    {
      'title': 'User Verification',
      'image': 'assets/images/userverification.png',
      'route': '/user-verification'
    },
  ];
}