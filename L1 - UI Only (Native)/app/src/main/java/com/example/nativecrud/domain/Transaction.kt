package com.example.nativecrud.domain
data class Transaction(
    val id: String = "-",
    val title: String,
    val desc: String,
    val type: String,
    val category: String,
    val sum: String,
    val date: String
)