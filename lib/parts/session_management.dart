class SessionManagement {
  final String teamId;
  final String teamPassword;

  SessionManagement({this.teamId, this.teamPassword});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> sessionManagement = Map<String, dynamic>();
    sessionManagement["teamId"] = this.teamId;
    sessionManagement["teamPassword"] = this.teamPassword;
    return sessionManagement;
  }
}
