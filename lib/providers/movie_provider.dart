import 'package:fluent_ui/fluent_ui.dart';

class MovieProvider extends ChangeNotifier {
  final List<String> values = [];
  final movieText = TextEditingController();
  String? _comboBox;

  get comboBox => _comboBox;
  set comboBox(value) {
    _comboBox = value;
    notifyListeners();
  }

  addItem() {
    String res = '';
    if (movieText.text == '') return res = 'Please write a movie';
    values.add(movieText.text);
    movieText.text = '';
    res = 'Saved Movie :D';
    notifyListeners();
    return res;
  }
}
