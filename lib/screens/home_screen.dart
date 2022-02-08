import 'package:fluent_ui/fluent_ui.dart';
import 'package:movie_list_app/providers/movie_provider.dart';
import 'package:provider/provider.dart';

class HomeState extends StatelessWidget {
  const HomeState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MovieProvider(),
      child: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String res = '';
    final movieProvider = Provider.of<MovieProvider>(context);
    return ScaffoldPage(
      header: const PageHeader(
        title: Text('MovieList'),
      ),
      content: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 300,
                    child: TextBox(
                      prefix: const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Icon(FluentIcons.video),
                      ),
                      controller: movieProvider.movieText,
                      placeholder: 'Write your movie',
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 200,
                    child: Combobox<String>(
                      value: movieProvider.comboBox,
                      onChanged: (value) {
                        if (value != null) {
                          movieProvider.comboBox = value;
                          print(movieProvider.comboBox);
                        }
                      },
                      isExpanded: true,
                      placeholder: const Text('Your movies...'),
                      items: movieProvider.values
                          .map((e) => ComboboxItem(
                                child: Text(e),
                                value: e,
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Button(
              child: const Text('Add movie'),
              style: ButtonStyle(
                backgroundColor:
                    ButtonState.resolveWith<Color>((states) => Colors.blue),
              ),
              onPressed: () {
                res = movieProvider.addItem();
                showDialog(
                    context: context,
                    builder: (context) {
                      return ContentDialog(
                        title: Text(
                            res == 'Saved Movie :D' ? 'Perfect!' : 'Error'),
                        content: Text(res),
                        actions: [
                          Button(
                              child: const Text('Ok'),
                              style: ButtonStyle(
                                backgroundColor: ButtonState.resolveWith<Color>(
                                    (states) => Colors.blue),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              })
                        ],
                      );
                    });
              },
            )
          ],
        ),
      ),
    );
  }
}
