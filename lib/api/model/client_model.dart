class client {
  final String cliId;
  final String cliPass;
  final String cliName;
  final String cliEmail;
  final int cliPhone;
  final String cliProjectName;
  final String cliProjectDesc;

  client({
    required this.cliId,
    required this.cliPass,
    required this.cliName,
    required this.cliEmail,
    required this.cliPhone,
    required this.cliProjectName,
    required this.cliProjectDesc,
  });

  factory client.fromJson(Map<String, dynamic> json) {
    return client(
      cliId: json['cli_id'],
      cliPass: json['cli_pass'],
      cliName: json['cli_name'],
      cliEmail: json['cli_email'],
      cliPhone: json['cli_phone'],
      cliProjectName: json['cli_project_name'],
      cliProjectDesc: json['cli_project_desc'],
    );
  }

  // factory Student.fromJson(Map<String, dynamic> json) {
  //   return Student(
  //     id: json['id'],
  //     name: json['name'],
  //     age: json['age'],
  //   );
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cli_id'] = cliId;
    data['cli_pass'] = cliPass;
    data['cli_name'] = cliName;
    data['cli_email'] = cliEmail;
    data['cli_phone'] = cliPhone;
    data['cli_project_name'] = cliProjectName;
    data['cli_project_desc'] = cliProjectDesc;
    return data;
  }
}
