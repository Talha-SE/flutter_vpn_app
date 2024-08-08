// ignore_for_file: avoid_print

class CsvParser {
  static List<Map<String, dynamic>> parseCsvToJson(String csvData) {
    List<Map<String, dynamic>> jsonResult = [];
    List<String> lines = csvData.split('\n');

    // Find the header line (starts with #HostName)
    int headerIndex = lines.indexWhere((line) => line.startsWith('#HostName'));
    if (headerIndex == -1) {
      print('Error: CSV header not found');
      return [];
    }

    List<String> headers = lines[headerIndex].substring(1).split(',');

    for (int i = headerIndex + 1; i < lines.length; i++) {
      if (lines[i].trim().isNotEmpty && !lines[i].startsWith('#')) {
        List<String> values = lines[i].split(',');
        if (values.length != headers.length) {
          print('Warning: Skipping malformed line: ${lines[i]}');
          continue;
        }
        Map<String, dynamic> jsonLine = {};
        for (int j = 0; j < headers.length; j++) {
          jsonLine[headers[j]] = values[j];
        }
        jsonResult.add(jsonLine);
      }
    }

    return jsonResult;
  }
}
