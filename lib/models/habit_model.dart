class Habit {
  final String? id;
  final String title;
  final int icon;
  final int color;
  final int points;
  final Map frecuency;
  final Map days;
  final Map daysPerWeek;
  final Map daysPerMonth;
  final Map time;
  final String? status;
  final String childId;

  const Habit(
      {this.id,
      required this.title,
      required this.icon,
      required this.color,
      required this.points,
      required this.frecuency,
      required this.days,
      required this.daysPerWeek,
      required this.daysPerMonth,
      required this.time,
      required this.status,
      required this.childId});

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'icon': icon,
        'color': color,
        'points': points,
        'frecuency': frecuency,
        'days': days,
        'daysPerWeek': daysPerWeek,
        'daysPerMonth': daysPerMonth,
        'time': time,
        'status': status,
        'childId': childId
      };
}
