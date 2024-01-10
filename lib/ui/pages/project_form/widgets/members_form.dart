import 'package:drag_and_drop_lists/drag_and_drop_list_interface.dart';
import 'package:flutter/material.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';

class MembersForm extends StatefulWidget {
  MembersForm({super.key});

  @override
  State<MembersForm> createState() => _MembersFormState();
}

class _MembersFormState extends State<MembersForm> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  decoration: BoxDecoration(color: Colors.grey[800]),
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Tradutores",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            IconButton(
                                onPressed: () {}, icon: Icon(Icons.person_add))
                          ],
                        ),
                      ),
                      Divider(
                        height: 2,
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey[200],
                        ),
                        title: Text(
                          "user1",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {},
                        ),
                      )
                    ],
                  )),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  decoration: BoxDecoration(color: Colors.grey[800]),
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Revisores",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            IconButton(
                                onPressed: () {}, icon: Icon(Icons.person_add))
                          ],
                        ),
                      ),
                      Divider(
                        height: 2,
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey[200],
                        ),
                        title: Text(
                          "user1",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {},
                        ),
                      )
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
