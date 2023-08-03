import 'package:weather_band/app/feature/home/presenter/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final viewModel = Modular.get<HomeViewModel>();

  int? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.red[200],
              child: ListenableBuilder(
                listenable: viewModel,
                builder: (BuildContext context, Widget? child) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${viewModel.count}',
                        style: TextStyle(fontSize: 30),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          viewModel.increment();
                        },
                        child: Text("Incrementar"),
                      )
                    ],
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
