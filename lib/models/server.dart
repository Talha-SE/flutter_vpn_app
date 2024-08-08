class Server {
  final String hostname;
  final String ip;
  final int score;
  final int ping;
  final int speed;
  final String countryLong;
  final String countryShort;
  final int numVpnSessions;
  final int uptime;
  final int totalUsers;
  final String totalTraffic;

  Server({
    required this.hostname,
    required this.ip,
    required this.score,
    required this.ping,
    required this.speed,
    required this.countryLong,
    required this.countryShort,
    required this.numVpnSessions,
    required this.uptime,
    required this.totalUsers,
    required this.totalTraffic,
  });

  factory Server.fromJson(Map<String, dynamic> json) {
    return Server(
      hostname: json['HostName'] ?? '',
      ip: json['IP'] ?? '',
      score: int.tryParse(json['Score'] ?? '') ?? 0,
      ping: int.tryParse(json['Ping'] ?? '') ?? 0,
      speed: int.tryParse(json['Speed'] ?? '') ?? 0,
      countryLong: json['CountryLong'] ?? '',
      countryShort: json['CountryShort'] ?? '',
      numVpnSessions: int.tryParse(json['NumVpnSessions'] ?? '') ?? 0,
      uptime: int.tryParse(json['Uptime'] ?? '') ?? 0,
      totalUsers: int.tryParse(json['TotalUsers'] ?? '') ?? 0,
      totalTraffic: json['TotalTraffic'] ?? '',
    );
  }
}
