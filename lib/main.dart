import 'package:flutter/material.dart';
import 'package:lecture_2_hometask_starter/constants.dart';
import 'package:lecture_2_hometask_starter/hash_calculator/heavy_task_performer.dart';
import 'package:lecture_2_hometask_starter/hash_calculator/spawned_isolate_task_performer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(DefaultIterationsCount);

  void changeIterationsCount(int newCount) => emit(newCount);
}

void main() {
  runApp(
    MyApp(
      taskPerformer: SpawnedIsolateTaskPerformer(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.taskPerformer,
  }) : super(key: key);

  final HeavyTaskPerformer taskPerformer;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (_) => CounterCubit(),
        child: MyHomePage(
          title: 'Flutter Demo Home Page',
          taskPerformer: taskPerformer,
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    required this.title,
    required this.taskPerformer,
  }) : super(key: key);

  final String title;
  final HeavyTaskPerformer taskPerformer;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String heavyTaskResult = '';
  bool isPerformingTask = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Please fill in the iterations count'),
              FormWidget(),
              Text(
                'Heavy task result is equal to: $heavyTaskResult',
                textAlign: TextAlign.center,
              ),
              isPerformingTask
                  ? const CircularProgressIndicator()
                  : BlocBuilder<CounterCubit, int>(
                      builder: (context, count) => ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                isPerformingTask = true;
                                heavyTaskResult = '';
                              });

                              final taskResult = await widget.taskPerformer
                                  .doSomeHeavyWork(count);

                              setState(() {
                                isPerformingTask = false;
                                heavyTaskResult = taskResult;
                              });
                            },
                            child: const Text('Perform Heavy Task'),
                          )),
              ElevatedButton(
                  onPressed: () {
                    widget.taskPerformer.terminateSomeHeavyWork();
                  },
                  child: const Text('Stop Heavy Task'))
            ],
          ),
        ),
      ),
    );
  }
}

class FormWidget extends StatefulWidget {
  const FormWidget({Key? key}) : super(key: key);

  @override
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: this._formKey,
      child: Column(children: <Widget>[
        TextFormField(
            initialValue: DefaultIterationsCount.toString(),
            onSaved: (value) => context
                .read<CounterCubit>()
                .changeIterationsCount(int.parse(value!))),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.deepPurpleAccent),
          ),
          child: Text('Submit'),
          onPressed: () {
            if (this._formKey.currentState!.validate()) {
              setState(() {
                this._formKey.currentState!.save();
              });
            }
          },
        ),
      ]),
    );
  }
}
