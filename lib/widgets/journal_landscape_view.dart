import 'package:flutter/material.dart';
import 'package:journal/models/journal.dart';

class LandscapeView extends StatefulWidget {
  late final Journal _journal;

  LandscapeView({Key? key, journal}) : super(key: key) {
    _journal = journal;
  }
  @override
  _LandscapeView createState() => _LandscapeView(_journal);
}

// will display the landscape view of the application list on the left
// and detail view on the right of the screen
class _LandscapeView extends State<LandscapeView> {
  late Journal journal;
  _LandscapeView(this.journal);

  var testVar = 1;
  bool testFlag = false;

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            //fit: FlexFit.loose,
            child:
            // displays the list of journal entries to be viewed on the left
            ListView.builder(shrinkWrap:true, itemCount: journal.numEntries, itemBuilder: (context, index) {
              return ListTile(
                title: Text(journal.journalEntries[index].title, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(journal.journalEntries[index].dateTime),
                onTap: () {
                  setState(() {
                    returnVar(index);
                  });
                },
              );
            }),
          ),
          // displays the details of the entry on the left of the screen
          Expanded(
              flex: 3,
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: testFlag ? Text(journal.journalEntries[testVar].title,
                        style: textTheme.headline4) : const Text(''),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: testFlag ? Text(journal.journalEntries[testVar].body,
                        style: const TextStyle(fontSize: 17)) : const Text(''),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: testFlag ? Text(journal.journalEntries[testVar].dateTime,
                        style: const TextStyle(fontSize: 17)) : const Text(''),
                  ),
                  testFlag ? Text(journal.journalEntries[testVar].rating,
                      style: const TextStyle(fontSize: 17)) : const Text(''),
                ],
              )
          )
        ],
      ),
    );
  }

  // helper to know what entry to display and if an entry has been selected
  void returnVar(index) {
    testFlag = true;
    testVar = index;
    return;
  }

}