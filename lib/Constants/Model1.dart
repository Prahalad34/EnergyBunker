

class Petrol {
  List<Result>? result;
  String? message;
  String? status;

  Petrol({this.result, this.message, this.status});

  Petrol.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}

class Result {
  String? id;
  String? limitStart;
  String? limitEnd;
  String? percentage;
  String? type;

  Result({this.id, this.limitStart, this.limitEnd, this.percentage, this.type});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    limitStart = json['limit_start'];
    limitEnd = json['limit_end'];
    percentage = json['percentage'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['limit_start'] = this.limitStart;
    data['limit_end'] = this.limitEnd;
    data['percentage'] = this.percentage;
    data['type'] = this.type;
    return data;
  }
}