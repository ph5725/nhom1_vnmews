class TinTucModel {
  int? id; String? tieuDe; String? moTa;
  String? nguon; String? urlImage; String? urlNoiDung;
  String? tacGia; String? chuyenMuc; String? ngayDang;

  //constructor
  TinTucModel({
    this.id, this.tieuDe, this.moTa, this.nguon, this.urlImage,
    this.urlNoiDung, this.tacGia, this.ngayDang, this.chuyenMuc,
  });

  TinTucModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tieuDe = json['tieuDe'];
    moTa = json['moTa'];
    nguon = json['nguon'];
    urlImage = json['urlImage'];
    urlNoiDung = json['urlNoiDung'];
    tacGia = json['tacGia'];
    ngayDang = json['ngayDang'];
    chuyenMuc = json['chuyenMuc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic> {};
    data["id"] = id;
    data["tieuDe"] = tieuDe;
    data["moTa"] = moTa;
    data["nguon"] = nguon;
    data["urlImage"] = urlImage;
    data["urlNoiDung"] = urlNoiDung;
    data["tacGia"] = tacGia;
    data["ngayDang"] = ngayDang;
    data["chuyenMuc"] = chuyenMuc;

    return data;
  }
}

