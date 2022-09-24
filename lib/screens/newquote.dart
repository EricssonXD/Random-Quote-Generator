import 'package:flutter/material.dart';
import 'package:random_verse/provider/quotelist.dart';

class NewQuoteView extends StatefulWidget {
  final Quote? item;

  const NewQuoteView({super.key, this.item});

  @override
  State<NewQuoteView> createState() => _NewQuoteViewState();
}

class _NewQuoteViewState extends State<NewQuoteView> {
  late TextEditingController titleController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.item?.title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.item != null ? 'Edit Quote' : 'New Quote',
          key: const Key('new-item-title'),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: titleController,
              autofocus: true,
              onSubmitted: (value) => submit(),
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(
              height: 14.0,
            ),
            ElevatedButton(
              child: const Text(
                'Save',
              ),
              onPressed: () => submit(),
            )
          ],
        ),
      ),
    );
  }

  void submit() {
    Navigator.of(context).pop(titleController.text);
  }
}
