import 'package:flutter/cupertino.dart';
import 'package:vaccinedemo/models/Books.dart';
import 'package:vaccinedemo/models/Group.dart';
import 'package:vaccinedemo/services/database.dart';

class CurrentGroup extends ChangeNotifier {
  OurGroup _currentGroup = OurGroup();
  OurBook _currentBook = OurBook();

  OurGroup get getCurrentGroup => _currentGroup;
  OurBook get getCurrentBook => _currentBook;

  void UpdateStateFromDatabase(String groupId) async {
    try {
      _currentGroup = await OurDatabase().getGroupinfo(groupId);
      _currentBook = await OurDatabase()
          .getCurrentBook(groupId, _currentGroup.currentBookId);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
