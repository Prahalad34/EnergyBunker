
class Discount {
  String? totalAmount;
  String? discount;
  String? afterDiscount;
  String? result;
  String? message;
  String? status;

  Discount(
      {this.totalAmount, this.discount, this.afterDiscount, this.result, this.message, this.status});

  Discount.fromJson(Map<String, dynamic> json) {
    totalAmount = json['total_amount'];
    discount = json['discount'];
    afterDiscount = json['after_discount'];
    result = json['result'];
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_amount'] = this.totalAmount;
    data['discount'] = this.discount;
    data['after_discount'] = this.afterDiscount;
    data['result'] = this.result;
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}