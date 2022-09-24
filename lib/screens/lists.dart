import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:random_verse/provider/quotelist.dart';
import 'newquote.dart';

class ScreenList extends StatefulWidget {
  const ScreenList({super.key});

  @override
  State<ScreenList> createState() => _ScreenListState();
}

class _ScreenListState extends State<ScreenList>
    with SingleTickerProviderStateMixin {
  List<Quote> list = <Quote>[];

  @override
  void initState() {
    loadSharedPreferencesAndData();
    super.initState();
  }

  void loadSharedPreferencesAndData() async {
    list = context.read<QuoteList>().quotes;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => goToNewItemView(),
        ),
        body: list.isEmpty ? emptyList() : buildListView());
  }

  Widget emptyList() {
    return const Center(child: Text('No items'));
  }

  Widget buildListView() {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return buildItem(list[index], index);
      },
    );
  }

  Widget buildItem(Quote item, index) {
    return Column(
      children: [
        Dismissible(
          key: Key('${item.hashCode}'),
          background: Container(color: Colors.red[700]),
          onDismissed: (direction) => removeItem(item),
          direction: DismissDirection.startToEnd,
          child: buildListTile(item, index),
        ),
        const Divider(
          color: Colors.black87,
        ),
      ],
    );
  }

  Widget buildListTile(Quote item, int index) {
    return Column(
      children: [
        ListTile(
          onTap: () => goToEditItemView(item),
          onLongPress: () => goToEditItemView(item),
          title: Text(
            item.title,
            key: Key('item-$index'),
            style: TextStyle(
                color: item.completed ? Colors.grey : Colors.black,
                decoration: item.completed ? TextDecoration.lineThrough : null),
          ),
          // trailing: Icon(
          //   item.completed ? Icons.check_box : Icons.check_box_outline_blank,
          //   key: Key('completed-icon-$index'),
          // ),
        ),
      ],
    );
  }

  void goToNewItemView() {
    // Here we are pushing the new view into the Navigator stack. By using a
    // MaterialPageRoute we get standard behaviour of a Material app, which will
    // show a back button automatically for each platform on the left top corner
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const NewQuoteView();
    })).then((title) {
      if (title != null) {
        addItem(Quote(title: title));
      }
    });
  }

  void addItem(Quote item) {
    context.read<QuoteList>().addQuote(item);
    saveData();
  }

  void changeItemCompleteness(Quote item) {
    setState(() {
      item.completed = !item.completed;
    });
    saveData();
  }

  void goToEditItemView(item) {
    // We re-use the NewQuoteView and push it to the Navigator stack just like
    // before, but now we send the title of the item on the class constructor
    // and expect a new title to be returned so that we can edit the item
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return NewQuoteView(item: item);
    })).then((title) {
      if (title != null) {
        editItem(item, title);
      }
    });
  }

  void editItem(Quote item, String title) {
    context.read<QuoteList>().editQuote(item, title);
    saveData();
  }

  void removeItem(Quote item) {
    context.read<QuoteList>().deleteQuote(item);
    saveData();
  }

  void saveData() {
    context.read<QuoteList>().saveData();
    setState(() {});
  }
}
