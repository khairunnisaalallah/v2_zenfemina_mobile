part of "pages.dart";

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 253, 253),
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                  top:
                      50), // Gunakan margin untuk mengatur ruang di sekitar gambar
              child: Image.asset(
                'assets/images/welcome.png',
                height: 263,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(height: 60),
            Text(
              "Selamat Datang",
              textAlign: TextAlign.center, // Atur textAlign menjadi center
              style: GoogleFonts.outfit(
                fontSize: 40,
                color: Color(0xFF252525),
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Atur siklus haid dan jadwal shalatmu sekarang",
              textAlign: TextAlign.center, // Atur textAlign menjadi center
              style: GoogleFonts.outfit(
                fontSize: 15,
                color: greyColor,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(
              height: 120,
            ),
            Container(
                height: 42,
                width: MediaQuery.of(context).size.width - 2 * defaultMargin,
                child: ElevatedButton(
                    onPressed: () {
                      Get.to(LoginPage());
                    },
                    child: Text(
                      'Masuk',
                      style: GoogleFonts.outfit(
                        fontSize: 20,
                        color: whiteColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))))),
            SizedBox(
              height: 15,
            ),
            Container(
                height: 42,
                width: MediaQuery.of(context).size.width - 2 * defaultMargin,
                child: ElevatedButton(
                    onPressed: () {
                      Get.to(RegisterPage());
                    },
                    child: Text(
                      'Daftar',
                      style: GoogleFonts.outfit(
                        fontSize: 20,
                        color: primaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: whiteColor,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: primaryColor, width: 1),
                            borderRadius: BorderRadius.circular(10))))),
          ],
        ),
      ),
    );
  }
}
