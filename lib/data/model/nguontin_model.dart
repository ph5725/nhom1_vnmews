class NguonTinModel
{
  int? id; String? name; String? img; String? loaiHinh;
  String? hinhThuc; String? tinhTrang; String? chuSoHuu; String? thanhLap;
  String? giayPhep; String? ngonNgu; String? truSo; String? quocGia;
  String? webSite;

  //constructor
  NguonTinModel({
    this.id, this.name, this.img, this.loaiHinh, this.hinhThuc, this.tinhTrang, this.chuSoHuu, 
    this.thanhLap, this.giayPhep, this.ngonNgu, this.truSo, this.quocGia, this.webSite
  });

  NguonTinModel.fromJson(Map<String, dynamic> json) {
    id = json['id']; name = json['name']; img = json['img'];
    loaiHinh = json['loaiHinh']; hinhThuc = json['hinhThuc']; tinhTrang = json['tinhTrang'];
    chuSoHuu = json['chuSoHuu']; thanhLap = json['thanhLap']; giayPhep = json['giayPhep'];
    ngonNgu = json['ngonNgu']; truSo = json['truSo']; quocGia = json['quocGia']; webSite = json['webSite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic> {};
    data["id"] = id;
    data["name"] = name;
    data["img"] = img;
    data["loaiHinh"] = loaiHinh;
    data["hinhThuc"] = hinhThuc;
    data["tinhTrang"] = tinhTrang;
    data["chuSoHuu"] = chuSoHuu;
    data["thanhLap"] = thanhLap;
    data["giayPhep"] = giayPhep;
    data["ngonNgu"] = ngonNgu;
    data["truSo"] = truSo;
    data["quocGia"] = quocGia;
    data["webSite"] = webSite;

    return data;
  }
}

