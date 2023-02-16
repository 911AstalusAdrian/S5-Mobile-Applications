import 'package:assignment_4/screens/transfer_details_screen.dart';
import 'package:assignment_4/screens/add_transfer_screen.dart';
import 'package:flutter/material.dart';
import '../model/transfer.dart';
import '../services/db_helper.dart';
import '../widgets/transfer_widget.dart';


class TransfersList extends StatefulWidget {
  const TransfersList({Key? key}) : super(key: key);

  @override
  State<TransfersList> createState() => _TransfersListState();
}

class _TransfersListState extends State<TransfersList> {
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
          child: FutureBuilder<List<Transfer>?>(
            future: DatabaseHelper.getAllTransfers(),
            builder: (context, AsyncSnapshot<List<Transfer>?> snapshot) {
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(
            builder: (context) => AddTransferScreen()
          ));
          setState(() {});
        },
        backgroundColor: Colors.white,
        child: const Icon(Icons.add, color: Colors.black,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: Colors.green,
    );
  }
}
