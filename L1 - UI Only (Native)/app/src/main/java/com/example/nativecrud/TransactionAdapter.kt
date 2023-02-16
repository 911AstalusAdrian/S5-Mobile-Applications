package com.example.nativecrud

import android.app.Activity
import android.content.Intent
import android.graphics.Color
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.example.nativecrud.domain.Transaction
import kotlinx.android.synthetic.main.transaction_entry.view.*

class TransactionAdapter(private var context: MainActivity) : RecyclerView.Adapter<TransactionAdapter.TransactionViewHolder>() {
    private var transactions: MutableList<Transaction> = mutableListOf()
    private val LAUNCH_EDIT_ACTIVITY: Int = 2

    init { generateTransactions() }

    private fun generateTransactions(){
        transactions.add(Transaction("1","Transaction 1", "desc", "income", "salary", "1200", "31/10/2022"))
        transactions.add(Transaction("2","Transaction 2", "desc", "income", "salary", "1200", "31/11/2022"))
        transactions.add(Transaction("3","Transaction 3", "desc", "income", "salary", "1200", "31/12/2022"))
        transactions.add(Transaction("4","Transaction 4", "desc", "income", "salary", "1200", "31/01/2023"))
        transactions.add(Transaction("5","Transaction 5", "desc", "expense", "new car", "1200", "31/02/2023"))
        transactions.add(Transaction("6","Transaction 6", "desc", "income", "salary", "1200", "31/03/2023"))
        transactions.add(Transaction("7","Transaction 7", "desc", "income", "salary", "1200", "31/04/2023"))
        transactions.add(Transaction("8","Transaction 8", "desc", "income", "salary", "1200", "31/05/2023"))
        transactions.add(Transaction("9","Transaction 9", "desc", "income", "salary", "1200", "31/06/2023"))
        transactions.add(Transaction("10","Transaction 10", "desc", "income", "salary", "1200", "31/07/2023"))
        transactions.add(Transaction("11","Transaction 11", "desc", "income", "salary", "1200", "31/08/2023"))
        transactions.add(Transaction("12","Transaction 12", "desc", "income", "salary", "1200", "31/09/2023"))
        transactions.add(Transaction("13","Transaction 13", "desc", "income", "salary", "1200", "31/10/2023"))
        transactions.add(Transaction("14","Transaction 14", "desc", "income", "salary", "1200", "31/11/2023"))
    }

    inner class TransactionViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView)

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): TransactionViewHolder {
        return TransactionViewHolder(
            LayoutInflater.from(parent.context).inflate(
                R.layout.transaction_entry,
                parent,
                false
            )
        )
    }

    override fun onBindViewHolder(holder: TransactionViewHolder, position: Int) {

        val currentTran = transactions[position]
        holder.itemView.apply {
            transactionTitle.text = currentTran.title
            if(currentTran.type == "income") {
                transactionSum.text = "+" + currentTran.sum.toString() + "$"
                transactionSum.setTextColor(Color.parseColor("#00FF00"))
            }
            if(currentTran.type == "expense"){
                transactionSum.text = "-" + currentTran.sum.toString() + "$"
                transactionSum.setTextColor(Color.parseColor("#FF0000"))
            }
        }

        holder.itemView.editTransactionButton.setOnClickListener(){
            val bundle = Bundle()
            bundle.putString("editId", currentTran.id)
            bundle.putString("editTitle", currentTran.title)
            bundle.putString("editDesc", currentTran.desc)
            bundle.putString("editType", currentTran.type)
            bundle.putString("editCat", currentTran.category)
            bundle.putString("editSum", currentTran.sum)
            bundle.putString("editDate", currentTran.date)
            val intent = Intent(holder.itemView.context, EditTransaction::class.java)
//            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK )
            intent.putExtras(bundle)
            context.startActivityForResult(intent, LAUNCH_EDIT_ACTIVITY)
        }
    }

    override fun getItemCount(): Int {
        return transactions.size
    }


    fun addTransaction(tran: Transaction){
        transactions.add(tran)
        notifyItemInserted(transactions.size-1)
    }

    fun deleteTransaction(identifier: String){
        for(i in 0 until transactions.size){
            if(transactions[i].id == identifier){
                transactions.removeAt(i)
                notifyItemRemoved(i)
                break
            }
        }
    }

    fun updateTransaction(identifier: String, newTran: Transaction){
        for (i in 0 until transactions.size){
            if (transactions[i].id == identifier){
                transactions[i] = newTran
                notifyItemChanged(i)
                break
            }
        }
    }

    fun getNewId(): Int {
        return transactions.size + 1
    }
}