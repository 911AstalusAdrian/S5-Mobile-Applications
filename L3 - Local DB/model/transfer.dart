class Transfer {
  final int? id;
  final String title;
  final String desc;
  final String type;
  final String category;
  final int sum;
  final String date;

  const Transfer({this.id,
    required this.title,
    required this.desc,
    required this.type,
    required this.category,
    required this.sum,
    required this.date});

  factory Transfer.fromJson(Map<String, dynamic> json) => Transfer(
    id: json['id'],
    title: json['title'],
    desc: json['desc'],
    type: json['type'],
    category: json['category'],
    sum: json['sum'],
    date: json['date'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'desc': desc,
    'type': type,
    'category': category,
    'sum': sum,
    'date': date,
  };
}