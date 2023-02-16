class Transaction {
  final int? id;
  final String title;
  final String desc;
  final String type;
  final String category;
  final int sum;
  final String date;

  const Transaction({this.id,
    required this.title,
    required this.desc,
    required this.type,
    required this.category,
    required this.sum,
    required this.date});

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
    id: json['id'],
    title: json['title'],
    desc: json['description'],
    type: json['type'],
    category: json['category'],
    sum: json['sum'],
    date: json['date'],
  );

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': desc,
    'type': type,
    'category': category,
    'sum': sum,
    'date': date,
  };
}