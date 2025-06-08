import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/custom_app_bar.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  Widget _sectionTitle(String title) {
    return Row(
      children: [
        Container(
          width: 6,
          height: 28,
          color: AppColors.primary,
          margin: const EdgeInsets.only(right: 12),
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }

  Widget _sectionText(String content) {
    return Text(
      content,
      style: const TextStyle(fontSize: 13, height: 1.5),
      textAlign: TextAlign.justify,
    );
  }

  Widget _sectionCard(String title, String content, {Widget? leadingImage}) {
    return Card(
      color: Colors.white.withOpacity(0.95),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 8,
      margin: const EdgeInsets.symmetric(vertical: 14),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (leadingImage != null) ...[
              leadingImage,
              const SizedBox(width: 16),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionTitle(title),
                  const SizedBox(height: 12),
                  _sectionText(content),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.iconBackground,
      appBar: CustomAppBar(
        title: 'O nas',
        showActions: false,
        showAboutUs: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _sectionCard(
                  'Historia firmy',
                  'Firma WoodSpace powstała w 2018 roku w Krakowie. Zaczynaliśmy jako dwuosobowy zespół w małym warsztacie. '
                      'Dziś nasze meble trafiają do tysięcy domów w całej Polsce i Europie. '
                      'W WoodSpace wierzymy, że każde wnętrze zasługuje na indywidualne podejście. '
                      'Naszą misją jest tworzenie mebli, które są piękne, trwałe i funkcjonalne. '
                      'Wartości, które nami kierują to: jakość, zrównoważony rozwój i szacunek dla rzemiosła.',
                  leadingImage: Icon(
                    Icons.history,
                    size: 48,
                    color: AppColors.primary,
                  ),
                ),
                _sectionCard(
                  'Nasz zespół',
                  'Aleksandra Woźniak – kreatywna projektantka wnętrz\n\n'
                      'Amadeusz Reszke – mistrz stolarski, dbający o każdy detal wykonania mebli\n\n'
                      'Dawid Tylka – analityk rynku, który dba o rozwój firmy\n\n'
                      'Grzegorz Cichosz – specjalista ds. obsługi klienta, zawsze gotowy do pomocy \n\n'
                      'Kasia Kowalczyk – ekspertka ds. logistyki, dbająca o organizację\n\n'
                      'Klaudia Młyńska – specjalistka ds. jakości, dbająca o najwyższe standardy\n\n'
                      'Mikołaj Więckowski – specjalista ds. marketingu, promujący markę WoodSpace',
                  leadingImage: Icon(
                    Icons.group,
                    size: 48,
                    color: AppColors.primary,
                  ),
                ),
                _sectionCard(
                  'Nasze osiągnięcia',
                  ' Produkt Roku 2022 w kategorii mebli\n'
                      'Ponad 5000 zadowolonych klientów\n'
                      'Drewno z certyfikatem FSC',
                  leadingImage: Icon(
                    Icons.emoji_events,
                    size: 48,
                    color: AppColors.primary,
                  ),
                ),
                Card(
                  color: Colors.white.withOpacity(0.95),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 8,
                  margin: const EdgeInsets.symmetric(vertical: 14),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _sectionTitle('Kontakt'),
                        const SizedBox(height: 12),
                        ListTile(
                          leading: Icon(Icons.email, color: AppColors.primary),
                          title: const Text('kontakt@woodspace.pl'),
                        ),
                        ListTile(
                          leading: Icon(Icons.phone, color: AppColors.primary),
                          title: const Text('+48 600 123 456'),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.location_on,
                            color: AppColors.primary,
                          ),
                          title: const Text('ul. Stolarzy 10, 30-001 Kraków'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
