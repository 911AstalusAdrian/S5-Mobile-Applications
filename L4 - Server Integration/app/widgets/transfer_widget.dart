
import 'package:flutter/material.dart';
import '../model/transfer.dart';

class TransferWidget extends StatelessWidget {

  final Transaction transfer;
  final VoidCallback onTap;
  // final VoidCallback onLongPress;

  const TransferWidget({Key? key, required this.transfer, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(transfer.title),
      subtitle: Text(transfer.desc),
      trailing: trailingWidget(),
      onTap: onTap,
    );
  }

  Widget trailingWidget(){
    if(transfer.type == "Expense" || transfer.type == 'expense'){
      return Text("-\$${transfer.sum}",
        style: const TextStyle(color: Colors.red),
      );
    }
    else{
      return Text("\$${transfer.sum}",
      style: const TextStyle(color: Colors.green),);
    }
  }

}
