import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../services/firestore.dart';

class ApproveCartPage extends StatefulWidget {
  const ApproveCartPage({super.key});

  @override
  State<ApproveCartPage> createState() => _ApproveCartPageState();
}

class _ApproveCartPageState extends State<ApproveCartPage> {
  final FireStoreService fireStoreService = FireStoreService();
  final TextEditingController textController = TextEditingController();
  late Stream<QuerySnapshot> _notesStream;
  bool _ascendingOrder = true;
  String _searchText = '';
  String selectedStatus = 'Pending';

  @override
  void initState() {
    super.initState();
    _notesStream = fireStoreService.getCartsStream();
  }

  void openNoteBox({String? docID,String? email, String? docIDemail}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Change Status',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            DropdownSelection(
              onChanged: (value) {
                setState(() {
                  selectedStatus = value;
                });
              },
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
                fireStoreService.updateStatus(
                  docID!,
                  selectedStatus,
                );
                fireStoreService.updateIStatus(
                  email!,
                  docIDemail!,
                  selectedStatus,
                );
              Navigator.pop(context);
            },
            child: Text("Change Status"),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      onChanged: (value) {
        setState(() {
          _searchText = value;
        });
      },
      decoration: InputDecoration(
        labelText: 'Search',
        hintText: 'Search notes...',
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Approve'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: _buildSearchBar(),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _notesStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List notesList = snapshot.data!.docs;
                  if (_searchText.isNotEmpty) {
                    notesList = notesList.where((note) {
                      final String noteText = note['name'];
                      return noteText.toLowerCase().contains(_searchText.toLowerCase());
                    }).toList();
                  }
                  if (!_ascendingOrder) {
                    notesList = notesList.reversed.toList();
                  }
                  return ListView.builder(
                    itemCount: notesList.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot document = notesList[index];
                      String docID = document.id;

                      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                      String noteText = data['name'];
                      String subtext = data['status'] ?? '';
                      String email = data['email'] ?? '';
                      String docIDemail = data['docID'] ?? '';

                      return ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              noteText,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            SizedBox(height: 4.0),
                            Text(
                              subtext,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () => openNoteBox(docID: docID, email:email, docIDemail: docIDemail),
                              icon: Icon(Icons.settings),
                            ),
                            IconButton(
                              onPressed: () {
                                _confirmDelete(context, docID);
                              },
                              icon: Icon(Icons.delete),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: Text("No Notes!"));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
  Future<void> _confirmDelete(BuildContext context, String docID) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete this note?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                fireStoreService.deleteCart(docID);
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}

class DropdownSelection extends StatefulWidget {
  final Function(String) onChanged;

  const DropdownSelection({required this.onChanged});

  @override
  _DropdownSelectionState createState() => _DropdownSelectionState();
}


class _DropdownSelectionState extends State<DropdownSelection> {
  String selectedValue = 'Pending';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 42,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: DropdownButton<String>(
              value: selectedValue,
              onChanged: (String? newValue) {
                setState(() {
                  selectedValue = newValue!;
                  widget.onChanged(selectedValue); // Pass selected value to parent widget
                });
              },

              icon: Icon(
                Icons.arrow_drop_down,
                size: 1,
              ), // Remove the default dropdown icon
              items: <String>[
                'Pending',
                'Completed'
              ].map<DropdownMenuItem<String>>(
                    (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Text(value),
                    ),
                  );
                },
              ).toList(),
            ),
          ),
          Icon(
            Icons.arrow_drop_down,
          ), // Icon aligned to the right corner
        ],
      ),
    );
  }
}
