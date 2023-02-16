import 'package:app/screens/transfer_details_screen.dart';
import 'package:app/screens/add_transfer_screen.dart';
import 'package:app/server/helper.dart';
import 'package:flutter/material.dart';
import '../model/transfer.dart';
import '../widgets/transfer_widget.dart';


class TransfersList extends StatefulWidget {
  const TransfersList({Key? key}) : super(key: key);

  @override
  State<TransfersList> createState() => _TransfersListState();
}

class _TransfersListState extends State<TransfersList> {

  Future<List<Transaction>> _transfers = ServerHelper.getAllTransactions();


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
          child: FutureBuilder<List<Transaction>?>(
            future: _transfers,
            builder: (context, AsyncSnapshot<List<Transaction>?> snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              } else if (snapshot.hasData) {
                if (snapshot.data != null) {
                  return ListView.builder(
                    itemBuilder: (context, index) => TransferWidget(
                      transfer: snapshot.data![index],
                      onTap: () async {
                        await Navigator.push(context, MaterialPageRoute(
                            builder: (context) => TransferDetailsScreen(transfer: snapshot.data![index])
                        ));
                        setState( () {} );
                      },
                    ),
                    itemCount: snapshot.data!.length,
                  );
                }
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: () async {
              await Navigator.push(context, MaterialPageRoute(
                  builder: (context) => AddTransferScreen()
              )).then((_) => setState( () {}));
            },
            backgroundColor: Colors.white,
            child: const Icon(Icons.add, color: Colors.black,),
          ),

          FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () => setState(() {
              _transfers = ServerHelper.getAllTransactions();
            }),
          child: const Icon(Icons.refresh, color: Colors.black,))]
      ),
      backgroundColor: Colors.green,
    );
  }
}