import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ManageDoctorsPage extends StatefulWidget {
  @override
  _ManageDoctorsPageState createState() => _ManageDoctorsPageState();
}

class _ManageDoctorsPageState extends State<ManageDoctorsPage> {
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Doctors'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('doctors').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          final doctors = snapshot.data!.docs;

          return ListView.builder(
            itemCount: doctors.length,
            itemBuilder: (context, index) {
              final doctor = doctors[index];
              final isVerified = doctor['isVerified'] ?? false;

              return ListTile(
                title: Text(doctor['name']),
                subtitle: Text(isVerified ? 'Verified' : 'Not Verified'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!isVerified)
                      IconButton(
                        icon: Icon(Icons.check),
                        onPressed: () {
                          _verifyDoctor(doctor.id);
                        },
                      ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _deleteDoctor(doctor.id);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _verifyDoctor(String doctorId) async {
    await _firestore.collection('doctors').doc(doctorId).update({
      'isVerified': true,
    });
  }

  Future<void> _deleteDoctor(String doctorId) async {
    await _firestore.collection('doctors').doc(doctorId).delete();
  }
}
