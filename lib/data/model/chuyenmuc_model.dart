class ChuyenMucModel {
  int? id;
  String? name;
  String? img;

  // Constructor
  ChuyenMucModel({this.id, this.name, this.img});

  // Phương thức từ JSON
  ChuyenMucModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;  // Sử dụng giá trị mặc định nếu không có dữ liệu
    name = json['name'] ?? "";  // Giá trị mặc định là chuỗi rỗng nếu không có tên
    img = json['img'] ?? '';  // Giá trị mặc định là chuỗi rỗng nếu không có hình ảnh
  }

  // Phương thức chuyển đổi đối tượng thành JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['img'] = img;
    return data;
  }
}
