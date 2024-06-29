import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lito/components/container_design.dart';
import 'package:lito/controller/home_controller.dart';
import 'package:lito/controller/report_controller.dart';
import 'package:lito/model/activity.dart';

class HomePage extends StatelessWidget {
  final ReportController reportcontroller = ReportController();
  final HomeController homecontroller = HomeController();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Home',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          garbageCollectorTimer(),
          const Padding(
            padding: EdgeInsets.all(17.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Social Activities',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                )
              ],
            ),
          ),
          Expanded(
            child: _buildActivityList(homecontroller.activities),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => reportcontroller.showReportDialog(context),
        child: Icon(Icons.report),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: Container(height: 20.0),
      ),
    );
  }

  Widget _buildActivityList(List<Activity> activities) {
    return ListView.builder(
      itemCount: activities.length,
      itemBuilder: (context, index) {
        final activity = activities[index];
        return ListTile(
          title: Text(activity.name),
          subtitle: Text(
            DateFormat('MMMM d, yyyy').format(activity.date),
          ),
          leading: Icon(Icons.eco),
        );
      },
    );
  }
}
