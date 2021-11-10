import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lecture_2_hometask_starter/constants.dart';
import 'package:lecture_2_hometask_starter/hash_calculator/heavy_task_performer.dart';
import 'package:lecture_2_hometask_starter/hash_calculator/spawned_isolate_task_performer.dart';
import 'package:redux/redux.dart';

class CountState {
  int iterationsCount = DefaultIterationsCount;
}

void main() {
  final store = new Store<CountState>(
    counterReducer,
    initialState: CountState(),
    // middleware: [appReducers],
  );
  runApp(MyApp(taskPerformer: SpawnedIsolateTaskPerformer(), store: store));
}

CountState counterReducer(CountState state, dynamic action) {
  if (action is ChangeIterationsCountAction) {
    state.iterationsCount = action.newCount;
  }
  return state;
}

class ChangeIterationsCountAction {
  int newCount;

  ChangeIterationsCountAction({Key? key, required this.newCount});
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.taskPerformer, required this.store})
      : super(key: key);
  final Store<CountState> store;
  final HeavyTaskPerformer taskPerformer;

  @override
  Widget build(BuildContext context) {
    return new StoreProvider<CountState>(
      store: store,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(
          title: 'Flutter Demo Home Page',
          taskPerformer: taskPerformer,
        ),
      ),
    );
  }
}

typedef OnItemIncrementCallback = Function(int newCount);


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title, required this.taskPerformer})
      : super(key: key);

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
                  : StoreConnector<CountState, CountState>(
                  converter: (store) => store.state,
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          isPerformingTask = true;
                          heavyTaskResult = '';
                        });

                        final taskResult = await widget.taskPerformer
                            .doSomeHeavyWork(state.iterationsCount);

                        setState(() {
                          isPerformingTask = false;
                          heavyTaskResult = taskResult;
                        });
                      },
                      child: const Text('Perform Heavy Task'),
                    );
                  }),
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
        StoreConnector<CountState, OnItemIncrementCallback>(
            converter: (store) {
              return (newCount) => store.dispatch(
                  ChangeIterationsCountAction(newCount: newCount));
            }, builder: (context, callback) {
          return TextFormField(
            initialValue: DefaultIterationsCount.toString(),
            onSaved: (value) => callback(int.parse(value!)),
          );
        }),
        ElevatedButton(
          style:ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurpleAccent),),
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
