import 'package:flutter/material.dart';
import 'package:secondapp/AddScreen.dart';
import 'package:secondapp/TransactionDetailScreen.dart';
import 'Transaction.dart';


void main() => runApp(const MaterialApp(
  home: Test(),
));

class Test extends StatefulWidget {
  const Test({super.key});

  // final List<Transaction> items;
  // const Test({super.key, required this.items});

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text("Transactions Manager App"),
  //       centerTitle: true,
  //       backgroundColor: Colors.green,
  //     ),
  //     body: Center(
  //       child: Container(
  //         decoration: const BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.all(Radius.circular(10))
  //         ),
  //         padding: const EdgeInsets.all(10.0),
  //         margin: const EdgeInsets.fromLTRB(40.0, 40.0, 40.0, 90.0),
  //         child: ListView.builder(
  //           itemCount: items.length,
  //           itemBuilder: (context, index) {
  //             return ListTile(
  //               title: Text(items[index].title),
  //               subtitle: Text(items[index].desc),
  //               onTap: () async {
  //                 await Navigator.push(context, MaterialPageRoute(builder: (context) => TransactionDetailScreen(transactionId: items[index].id)));
  //               },
  //             );
  //           },
  //         )
  //       ),
  //     ),
  //     floatingActionButton: FloatingActionButton(
  //       onPressed: () async {
  //         Transaction t = await Navigator.push(
  //             context,
  //           MaterialPageRoute(builder: (context) => AddScreen(transactionId: (items.length+1).toString()))
  //         );
  //         items.add(t);
  //       },
  //       backgroundColor: Colors.white,
  //       child: const Text(
  //         "+",
  //         style: TextStyle(color: Colors.black, fontSize: 35),
  //       ),
  //     ),
  //     floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
  //     backgroundColor: Colors.green,
  //   );
  // }

  @override
  State<StatefulWidget> createState() => _mainState();
}

class _mainState extends State<Test> {

  final List<Transaction> items = Transaction.dummyData();

  Transaction? getTransactionById(String searchId){
    for (Transaction t in items){
      if (t.id == searchId) { return t; }
    }
  }

  void updateTransaction(Transaction newT){
    for (int i = 0; i < items.length; i++){
      if(items[i].id == newT.id) { items[i] = newT; }
    }
  }

  void deleteTransaction(String removeId){
    items.removeWhere((element) => element.id == removeId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transactions Manager App"),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.fromLTRB(40.0, 40.0, 40.0, 90.0),
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(items[index].title),
                  subtitle: Text(items[index].desc),
                  onTap: () async {
                    Transaction? t = getTransactionById(items[index].id);
                    final Map<String, dynamic> data = await Navigator.push(context, MaterialPageRoute(builder: (context) => TransactionDetailScreen(transaction: t!)));
                    setState(() {
                      String status = data["action"]!;
                      if (status == "edit") {
                        Transaction t = data["item"];
                        updateTransaction(t);
                      }
                      else {
                        String id = data["item"];
                        deleteTransaction(id);
                      }
                    });
                  },
                );
              },
            )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Transaction t = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddScreen(transactionId: (items.length+1).toString()))
          );
          setState(() {items.add(t);});
        },
        backgroundColor: Colors.white,
        child: const Text(
          "+",
          style: TextStyle(color: Colors.black, fontSize: 35),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: Colors.green,
    );
  }
}
