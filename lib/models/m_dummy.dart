class MudarisDummy {
  String nama, halaqah, jadwalHari, jadwalJam, gambar;
  MudarisDummy({
    this.nama,
    this.halaqah,
    this.gambar,
    this.jadwalHari,
    this.jadwalJam,
  });
}

List<MudarisDummy> listMudarisDummy = [
  MudarisDummy(
    nama: 'Mahad Imam Ahmad bin Hambal',
    gambar: 'assets/images/profile/profile1.png',
    halaqah: 'Halaqah Online',
    jadwalHari: 'Senin',
    jadwalJam: '10.00',
  ),
  // MudarisDummy(
  //   nama: 'Ustadz Fulan bin Fulan',
  //   gambar: 'assets/images/profile/profile2.png',
  //   halaqah: 'Tuhfatul Athfal',
  //   jadwalHari: 'Sabtu',
  //   jadwalJam: '08.00',
  // ),
  // MudarisDummy(
  //   nama: 'Ustadz Abdullah bin Fulan',
  //   gambar: 'assets/images/profile/profile3.png',
  //   halaqah: 'Al Kabair',
  //   jadwalHari: 'Kamis',
  //   jadwalJam: '18.00',
  // ),
];

class Thullab {
  String nama, gambar;
  bool isAccepted;
  Thullab({
    this.nama,
    this.gambar,
    this.isAccepted,
  });
}

/// used in notification screen
List<Thullab> listKonfirmasiThullab = [
  Thullab(
    nama: 'Fulan bin Fulan',
    gambar: 'assets/images/profile/profile3.png',
    isAccepted: true,
  ),
  Thullab(
    nama: 'Abdullah bin Fulan',
    gambar: 'assets/images/profile/profile2.png',
    isAccepted: false,
  ),
  Thullab(
    nama: 'Fulan bin Fulan',
    gambar: 'assets/images/profile/profile3.png',
    isAccepted: true,
  ),
  Thullab(
    nama: 'Abdullah bin Fulan',
    gambar: 'assets/images/profile/profile2.png',
    isAccepted: false,
  ),
  Thullab(
    nama: 'Fulan bin Fulan',
    gambar: 'assets/images/profile/profile3.png',
    isAccepted: true,
  ),
  Thullab(
    nama: 'Abdullah bin Fulan',
    gambar: 'assets/images/profile/profile2.png',
    isAccepted: false,
  ),
  Thullab(
    nama: 'Fulan bin Fulan',
    gambar: 'assets/images/profile/profile3.png',
    isAccepted: true,
  ),
  Thullab(
    nama: 'Abdullah bin Fulan',
    gambar: 'assets/images/profile/profile2.png',
    isAccepted: false,
  ),
];
