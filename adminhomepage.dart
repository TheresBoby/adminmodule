import 'package:flutter/material.dart';
import 'manage_doctors_page.dart';
import 'manage_users_page.dart';
import 'manage_appointments_page.dart';

class AdminHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ManageDoctorsPage()),
                );
              },
              child: Text('Manage Doctors'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ManageUsersPage()),
                );
              },
              child: Text('Manage Users'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ManageAppointmentsPage()),
                );
              },
              child: Text('Manage Appointments'),
            ),
          ],
        ),
      ),
    );
  }
}
