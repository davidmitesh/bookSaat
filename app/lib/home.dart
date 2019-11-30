import 'package:nothotdog/models/loading.dart';
import 'package:nothotdog/search_page.dart';
import 'package:nothotdog/viewmodels/searchState.dart';
import 'package:provider/provider.dart';

import 'badge_icon.dart';
import 'camera_page.dart';
import 'package:flutter/material.dart';

import 'recommended.dart';
import 'viewmodels/recommended.dart';

class Home extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<RecommendedState>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: Padding(
          padding: const EdgeInsets.all(14.0),
          child: CircleAvatar(
            radius: 16,
            backgroundColor: Colors.blue,
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: 16,
            ),
          ),
        ),
        centerTitle: false,
        title: Text(
          'Hello Bibek!',
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          NotifbadgeIcon(
            icon: Icons.chat_bubble_outline,
            count: 2,
          ),
          NotifbadgeIcon()
        ],
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          padding: const EdgeInsets.only(bottom: 80),
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(38.0),
                        ),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              offset: const Offset(2, 2),
                              blurRadius: 8.0),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: TextFormField(
                          controller: controller,
                          onChanged: (String txt) {},
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                          cursorColor: Colors.blue,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Would you like to read a book today?',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.blue,
                  ),
                  onPressed: () async {
                    if (controller.text.isNotEmpty) {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ChangeNotifierProvider<SearchState>(
                                    create: (_) => SearchState(
                                        loadingState.IS_LOADING,
                                        null,
                                        controller.text),
                                    child: SearchPage(
                                      searchTerm: controller.text,
                                    ),
                                  )));
                      state.fetchData();
                    }
                  },
                )
              ],
            ),
            RecommendedBooks(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Exchange'),
        icon: Icon(Icons.swap_horiz),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CameraPage()));
        },
      ),
    );
  }
}
