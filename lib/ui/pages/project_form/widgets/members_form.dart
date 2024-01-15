import 'package:flutter/material.dart';

class MembersForm extends StatefulWidget {
  const MembersForm({super.key});

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
          Flexible(
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
                                onPressed: () {}, icon: const Icon(Icons.person_add))
                          ],
                        ),
                      ),
                      const Divider(
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
                          icon: const Icon(Icons.clear),
                          onPressed: () {},
                        ),
                      )
                    ],
                  )),
            ),
          ),
          Flexible(
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
                                onPressed: () {}, icon: const Icon(Icons.person_add))
                          ],
                        ),
                      ),
                      const Divider(
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
                          icon: const Icon(Icons.clear),
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
