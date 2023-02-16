class Transaction{

  static List<Transaction> dummyData(){
    List<Transaction> transactions = [
      Transaction("1", "Title1", "Desc 1", "Income", "Type1", "200", "10/10/2022"),
      Transaction("2", "Title2", "Desc 1", "Expense", "Type1", "200", "10/10/2022"),
      Transaction("3", "Title3", "Desc 1", "Income", "Type1", "200", "10/10/2022"),
      Transaction("4", "Title4", "Desc 1", "Expense", "Type1", "200", "10/10/2022"),
      Transaction("5", "Title5", "Desc 1", "Income", "Type1", "200", "10/10/2022"),
      Transaction("6", "Title6", "Desc 1", "Expense", "Type1", "200", "10/10/2022"),
      Transaction("7", "Title7", "Desc 1", "Income", "Type1", "200", "10/10/2022"),
      Transaction("8", "Title8", "Desc 1", "Expense", "Type1", "200", "10/10/2022"),
      Transaction("9", "Title9", "Desc 1", "Income", "Type1", "200", "10/10/2022"),
      Transaction("10", "Title10", "Desc 1", "Expense", "Type1", "200", "10/10/2022"),
      Transaction("11", "Title11", "Desc 1", "Income", "Type1", "200", "10/10/2022"),
      Transaction("12", "Title12", "Desc 1", "Expense", "Type1", "200", "10/10/2022"),
      Transaction("13", "Title13", "Desc 1", "Expense", "Type1", "200", "10/10/2022"),
      Transaction("14", "Title14", "Desc 1", "Income", "Type1", "200", "10/10/2022"),
      Transaction("15", "Title15", "Desc 1", "Income", "Type1", "200", "10/10/2022"),
    ];
        return transactions;
  }

  Transaction(this.id, this.title, this.desc, this.type, this.category, this.sum, this.date);

  String id;
  String title;
  String desc;
  String type;
  String category;
  String sum;
  String date;
}