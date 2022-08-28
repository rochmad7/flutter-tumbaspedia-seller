part of 'models.dart';

class Privacy {
  final int id;
  final String title;
  final String text;

  Privacy({this.id, this.title, this.text});
}

List<Privacy> mockPrivacy = [
  Privacy(
    id: 1,
    title:
        "Kami sangat memperhatikan keamanan dan privasi pelanggan kami dan kami hanya akan mengumpulkan informasi pribadi Anda.",
    text:
        "Perlindungan data adalah masalah kepercayaan dan privasi Anda sangat penting bagi kami. Kami hanya akan menggunakan nama Anda dan informasi yang berhubungan dengan Anda sebagaimana yang dinyatakan dalam Kebijakan Privasi berikut. Kami hanya akan mengumpulkan informasi yang kami perlukan dan kami hanya akan mengumpulkan informasi yang relevan dengan Anda.",
  ),
  Privacy(
    id: 2,
    title:
        "Kami hanya akan menyimpan informasi privasi Anda sepanjang kami diwajibkan oleh hukum atau selama informasi tersebut masih relevan dengan tujuan awal pengumpulan informasi tersebut.",
    text:
        "Anda dapat mengunjungi situs kami dan menjelajahinya tanpa harus memberikan informasi pribadi. Selama kunjungan Anda ke situs kami, identitas Anda akan tetap terjaga dan kami tidak akan bisa mengidentifikasi Anda kecuali Anda memiliki akun dalam situs kami dan log masuk dengan menggunakan username dan password Anda.",
  ),
  Privacy(
    id: 3,
    title: "Pengumpulan Informasi Pribadi",
    text:
        "Tumbaspedia tidak menjual, membagi atau memperjualbelikan informasi pribadi pelanggan yang dikumpulkan secara online melalui pihak ketiga. Informasi pribadi yang dikumpulkan online hanya akan dibagi di dalam perusahaan kami hanya untuk kepentingan internal. Informasi pribadi yang kami kumpulkan, ketika Anda membuat akun di Tumbaspedia adalah:\n- Nama\n- Alamat Email\n- Nomor Telepon.\n- Alamat Anda\n\nInformasi pribadi yang kami kumpulkan dari Anda akan digunakan untuk hal-hal seperti:\n- Untuk menginformasikan Anda kepada pemilik toko UKM\n- Untuk memberikan informasi produk kami\n- Untuk memberikan layanan dan informasi yang ditawarkan situs kami dan yang telah Anda minta",
  ),
  Privacy(
    id: 4,
    title: "Memperbarui Informasi Pribadi Anda",
    text:
        "Anda dapat memperbarui informasi pribadi Anda kapan saja dengan mengakses akun Tumbaspedia Anda di aplikasi.",
  ),
  Privacy(
    id: 5,
    title: "Keamanan Informasi Pribadi Anda",
    text:
        "Tumbaspedia memastikan bahwa semua informasi yang dikumpulkan akan disimpan dengan aman. Kami melindungi semua informasi pribadi Anda dengan:\n- Membatasi akses terhadap informasi pribadi\n- Mengikuti kemajuan teknologi pengamanan untuk mencegah akses komputer tidak sah menghapus data pribadi Anda yang tidak dibutuhkan lagi untuk kepentingan dokumentasi kami.",
  ),
  Privacy(
    id: 6,
    title: "Pembukaan Informasi Pribadi",
    text:
        "Kami tidak akan membagi informasi Anda dengan organisasi lainnya, selain kepada pihak toko UKM yang berhubungan dan pihak ketiga yang berhubungan langsung dengan pembelian produk yang Anda beli dari aplikasi Tumbaspedia",
  ),
  Privacy(
    id: 7,
    title: "Perubahan pada Kebijakan Privasi",
    text:
        "Tumbaspedia memiliki hak untuk mengganti dan mengubah Pernyataan Privasi pada waktu kapan saja. Semua perubahan kebijakan akan diumumkan di situs kami.",
  ),
];
