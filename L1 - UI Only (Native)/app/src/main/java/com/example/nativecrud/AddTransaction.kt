package com.example.nativecrud

import android.app.Activity
import android.app.AlertDialog
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.core.text.isDigitsOnly
import kotlinx.android.synthetic.main.activity_add_transaction.*

class AddTransaction : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_add_transaction)
        val id: String = intent.getStringExtra("Id").toString()
        addTranId.setText(id)
        addTranId.isEnabled = false

        addTransaction.setOnClickListener{
            if(checkInputs()){
                val bundle = Bundle()
                bundle.putString("Id", addTranId.text.toString())
                bundle.putString("Title", addTranTitle.text.toString())
                bundle.putString("Desc", addTranDesc.text.toString())
                bundle.putString("Type", addTranType.text.toString())
                bundle.putString("Category", addTranCategory.text.toString())
                bundle.putString("Sum", addTranSum.text.toString())
                bundle.putString("Date", addTranDate.text.toString())
                val intent = Intent()
                intent.putExtras(bundle)
                setResult(Activity.RESULT_OK, intent)
                finish()
            }
            else{
                val alert = AlertDialog.Builder(this)
                alert.setTitle("Invalid Transaction entered!")
                alert.setMessage("Please fill in all the Transaction details correctly")
                alert.setPositiveButton("OK") { dialog, _ -> dialog.cancel()}
                alert.show()
            }
        }
    }

    private fun checkInputs(): Boolean {
        if(addTranId.text.isEmpty() or addTranTitle.text.isEmpty() or addTranDesc.text.isEmpty() or addTranType.text.isEmpty() or
                addTranCategory.text.isEmpty() or addTranSum.text.isEmpty() or addTranDate.text.isEmpty())
            return false
        else{
            if (!addTranSum.text.isDigitsOnly()) return false
        }
        return true
    }
}