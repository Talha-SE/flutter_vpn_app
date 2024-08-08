// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/csv_parser.dart';
import '../models/server.dart';
import 'dart:convert';

class ApiService {
  static const String vpnGateApiUrl = 'https://www.vpngate.net/api/iphone/';
  static const String _cacheKey = 'cachedServers';

  Future<List<Server>> fetchServers() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedData = prefs.getString(_cacheKey);

      if (cachedData != null) {
        final jsonData = json.decode(cachedData) as List<dynamic>;
        return jsonData.map((json) => Server.fromJson(json)).toList();
      }

      final response = await http.get(Uri.parse(vpnGateApiUrl));
      if (response.statusCode == 200) {
        final csvData = response.body;
        final jsonData = CsvParser.parseCsvToJson(csvData);

        // Cache the data
        await prefs.setString(_cacheKey, json.encode(jsonData));

        return jsonData.map((json) => Server.fromJson(json)).toList();
      } else {
        print('Failed to load servers. Status code: ${response.statusCode}');
        throw Exception('Failed to load servers');
      }
    } catch (e) {
      print('Error fetching servers: $e');
      throw Exception('Failed to load servers');
    }
  }

  Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cacheKey);
  }
}
