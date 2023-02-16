package com.example.nativecrud

import android.app.Activity
import android.app.AlertDialog
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import androidx.core.text.isDigitsOnly
import kotlinx.android.synthetic.main.activity_add_transaction.*
import kotlinx.android.synthetic.main.activity_edit_transaction.*

class EditTransaction : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        var editedId: String? = null
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_edit_transaction)


        val bundle = intent.extras
        if (bundle != null){
            editTranId.isEnabled = false
            editTranId.setText(bundle.getString("editId"))
            editedId = bundle.getString("editId").toString()
            editTranTitle.setText(bundle.getString("editTitle"))
            editTranDesc.setText(bundle.getString("editDesc"))
            editTranType.setText(bundle.getString("editType"))
            editTranCategory.setText(bundle.getString("editCat"))
            editTranSum.setText(bundle.getString("editSum"))
            editTranDate.setText(bundle.getString("editDate"))
        }

        editTransaction.setOnClickListener{
            val editedBundle = Bundle()
            editedBundle.putString("editedId",editedId)
            editedBundle.putString("editedTitle", editTranTitle.text.toString())
            editedBundle.putString("editedDesc", editTranDesc.text.toString())
            editedBundle.putString("editedType", editTranType.text.toString())
            editedBundle.putString("editedCat", editTranCategory.text.toString())
            editedBundle.putString("editedSum", editTranSum.text.toString())
            editedBundle.putString("editedDate", editTranDate.text.toString())

            val intent = Intent()
            intent.putExtras(editedBundle)
            setResult(Activity.RESULT_OK, intent)
            finish()
        }

        deleteTransaction.setOnClickListener{
            val alert = AlertDialog.Builder(this)
            alert.setTitle("Are you sure you want to delete this transaction?")
            alert.setMessage("Press 'YES' to confirm")
            alert.setPositiveButton("YES"){ _, _ ->
                val deletedBundle = Bundle()
                deletedBundle.putString("deletedId", editedId)
                val intent = Intent()
                intent.putExtras(deletedBundle)
                setResult(Activity.RESULT_CANCELED, intent)
                finish()
            }
            alert.setNegativeButton("NO") { dialog, _ -> dialog.cancel()}
            alert.show()
        }
    }
}