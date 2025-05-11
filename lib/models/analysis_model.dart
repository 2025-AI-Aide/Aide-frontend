class ContractAnalysis {
  final String sentence;
  final int riskLevel;
  final String hasRisk;
  final String reason;

  ContractAnalysis({
    required this.sentence,
    required this.riskLevel,
    required this.hasRisk,
    required this.reason,
  });

  factory ContractAnalysis.fromJson(Map<String, dynamic> json) {
    return ContractAnalysis(
      sentence: json['sentence'] ?? '',
      riskLevel: json['riskLevel'] ?? 0,
      hasRisk: json['hasRisk'] ?? '아니오',
      reason: json['reason'] ?? '',
    );
  }
}
