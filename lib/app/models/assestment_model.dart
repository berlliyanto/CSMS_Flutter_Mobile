class CalculateAssessmentModel {
  final Map<String, dynamic> leader;
  final Map<String, dynamic> cleaner;
  final Map<String, dynamic> location;
  final int perilaku;
  final int sikap;
  final int penampilan;
  final int tanggungJawab;
  final int kompetensi;
  final int total;
  final int id;
  final String createdAt;
  final String updatedAt;

  CalculateAssessmentModel({
    required this.id,
    required this.leader,
    required this.cleaner,
    required this.location,
    required this.perilaku,
    required this.sikap,
    required this.penampilan,
    required this.tanggungJawab,
    required this.kompetensi,
    required this.total,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CalculateAssessmentModel.fromJson(Map<String, dynamic> json) {
    return CalculateAssessmentModel(
      id: json['id'] ?? 0,
      leader: json['leader'] ?? {},
      cleaner: json['cleaner'] ?? {},
      location: json['location'] ?? {},
      perilaku: json['perilaku'] ?? 0,
      sikap: json['sikap'] ?? 0,
      penampilan: json['penampilan'] ?? 0,
      tanggungJawab: json['tanggung_jawab'] ?? 0,
      kompetensi: json['kompetensi'] ?? 0,
      total: json['total'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}