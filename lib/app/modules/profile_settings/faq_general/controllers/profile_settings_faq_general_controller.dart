import 'package:get/get.dart';

class ProfileSettingsFaqGeneralController extends GetxController {
  RxList<FaqItem> faqItems = [
    FaqItem(
        title: "Top Up Saldo",
        subtitle: "Cara Top Up saldo saya?",
        description:
            "Untuk melakukan Top Up saldo anda bisa masuk ke dalam akun kemudian terdapat tombol chat admin untuk Top Up kemudian otomatis akan terhubung langsung ke whatsapp admin dan mengisi jumlah saldo yang akan anda isi."),
    FaqItem(
        title: "Riwayat",
        subtitle:
            "Dimana Saya dapat melihat rental/booking yang sudah saya pesan sebelumnya?",
        description:
            "Terdapat menu dibawah bernama riwayat untuk melihat rental PS yang sudah anda pesan beberapa saat yang lalu dan tampilan riwayat tersebut menampilkan pesanan yang anda pesan sebelumnya."),
    FaqItem(
        title: "Jarak Lokasi Rental",
        subtitle:
            "Rumah saya lumayan jauh dari toko apakah saya bisa sewa PS menggunakan jasa antar?",
        description:
            "Untuk pengantaran sewa PS sebelumnya anda harus memilih alamat anda didalam maps kemudian jika jarak toko dengan rumah anda lebih dari 10km maka jasa pengiriman tidak bisa dan akan muncul notif, jadi anda bisa mengambil sewa PS sendiri di toko tersebut."),
    FaqItem(
        title: "One-Time Password",
        subtitle: "Saya tidak tahu kode OTP saya bagaimana saya mencarinya?",
        description:
            "Kode OTP terdapat di gmail setelah anda melakukan register atau reset password kemudian anda bisa melihat kode OTP tersebut di pesan masuk gmail, jangan lupa untuk menggunakan gmail yang aktif agar OTP dapat masuk ke email anda."),
    FaqItem(
        title: "Rental Playstation",
        subtitle: "Bagaimana cara rental/booking Playstation?",
        description:
            "Di dalam dashboard terdapat fitur game center yang berisi cabang dari rental jika anda ingin mencari rental terdekat anda bisa melihat alamat yang sudah tertera disana kemudian anda pilih dan memilih PS yang tersedia kemudian menentukan waktu dan durasi, setelah itu melakukan pembayaran."),
    FaqItem(
        title: "Service Playstation",
        subtitle: "Apakah terdapat garansi jika kita service PS di tolonto?",
        description:
            "Untuk jasa servis PS tentu saja terdapat garansi karena kepuasan pelanggan yang paling utama untuk waktu garansi tergantung kerusakan PS tersebut."),
  ].obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

class FaqItem {
  FaqItem({
    required this.title,
    required this.subtitle,
    required this.description,
    this.isExpanded = false,
  });

  String title;
  String subtitle;
  String description;
  bool isExpanded;
}
