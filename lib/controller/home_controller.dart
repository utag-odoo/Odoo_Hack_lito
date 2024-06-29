
import 'package:lito/model/activity.dart';

class HomeController {
  List<Activity> get activities {
    final now = DateTime.now();
    return [
      Activity(name: 'Beach Cleaning Drive', date: now.add(Duration(days: 5))),
      Activity(name: 'Park Restoration Project', date: now.add(Duration(days: 12))),
      Activity(name: 'Neighborhood Recycling Initiative', date: now.add(Duration(days: 18))),
      Activity(name: 'River Clean-up Campaign', date: now.add(Duration(days: 25))),
      Activity(name: 'Tree Planting Event', date: now.add(Duration(days: 30))),
    ];
  }

}