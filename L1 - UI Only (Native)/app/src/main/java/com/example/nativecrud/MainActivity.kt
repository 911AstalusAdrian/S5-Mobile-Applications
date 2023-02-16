package com.example.nativecrud

import android.app.Activity
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.recyclerview.widget.LinearLayoutManager
import com.example.nativecrud.domain.Transaction
import kotlinx.android.synthetic.main.activity_add_transaction.view.*
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity() {

    private val LAUNCH_ADD_ACTIVITY : Int = 1
    private val LAUNCH_EDIT_ACTIVITY: Int = 2
    private val LAUNCH_DELETE_ACTIVITY: Int = 3

    private lateinit var myAdapter: TransactionAdapter
    var bundleId: String? = null
    var bundleTitle: String? = null
    var bundleDesc: String? = null
    var bundleType: String? = null
    var bundleCat: String? = null
    var bundleSum: String? = null
    var bundleDate: String? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        supportActionBar?.hide()

        myAdapter = TransactionAdapter(this)
        transactionsList.adapter = myAdapter
        transactionsList.layoutManager = LinearLayoutManager(this)

        addButton.setOnClickListener {
            val intent = Intent(this, AddTransaction::class.java)
            intent.putExtra("Id", myAdapter.getNewId().toString())
            startActivityForResult(intent, LAUNCH_ADD_ACTIVITY)
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == LAUNCH_ADD_ACTIVITY){ // request code for adding a Transaction
            if(resultCode == Activity.RESULT_OK){
                if(data != null) {
                    val transactionId = data.getStringExtra("Id").toString()
                    val transactionTitle = data.getStringExtra("Title").toString()
                    val transactionDesc = data.getStringExtra("Desc").toString()
                    val transactionType = data.getStringExtra("Type").toString()
                    val transactionCategory = data.getStringExtra("Category").toString()
                    val transactionSum = data.getStringExtra("Sum").toString()
                    val transactionDate = data.getStringExtra("Date").toString()
                    val newTransaction = Transaction(transactionId, transactionTitle, transactionDesc, transactionType, transactionCategory, transactionSum, transactionDate)
                    myAdapter.addTransaction(newTransaction)

                }
            }
        }
        if (requestCode == LAUNCH_EDIT_ACTIVITY){
            if(resultCode == Activity.RESULT_OK) {
                if (data != null) {
                    val transactionId = data.getStringExtra("editedId").toString()
                    val transactionTitle = data.getStringExtra("editedTitle").toString()
                    val transactionDesc = data.getStringExtra("editedDesc").toString()
                    val transactionType = data.getStringExtra("editedType").toString()
                    val transactionCategory = data.getStringExtra("editedCat").toString()
                    val transactionSum = data.getStringExtra("editedSum").toString()
                    val transactionDate = data.getStringExtra("editedDate").toString()
                    val editTransaction = Transaction(transactionId, transactionTitle, transactionDesc, transactionType, transactionCategory, transactionSum, transactionDate)
                    println(editTransaction)
                    myAdapter.updateTransaction(transactionId, editTransaction)
                }
            }
        }

        if (resultCode == Activity.RESULT_CANCELED){
            if (data != null){
                val transactionId = data.getStringExtra("deletedId").toString()
                myAdapter.deleteTransaction(transactionId)
            }
        }
    }
}