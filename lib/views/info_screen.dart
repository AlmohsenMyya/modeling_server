import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DevelopersPage extends StatelessWidget {
  final List<Developer> developers = [
    Developer(
      name: 'Almohsen Myya',
      image: 'assets/images/almohsen.jpg',
      description:
          'Mobile Application Developer | Software Engineer | Passionate about Project Management and Team Leadership | Transforming Ideas into Reality',
      facebook:
          'https://www.facebook.com/profile.php?id=61551818735379&mibextid=ZbWKwL',
      linkedin:
          'https://www.linkedin.com/in/almohsen-myya-79230022b?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app',
      whatsapp: '+963996367749',
    ),
    Developer(
      name: 'Majd Kherbek ',
      image: 'assets/images/mjd.jpg',
      description:
          'Network Engineer passionate about creating innovative solutions.',
      facebook: '',
      linkedin: '',
      whatsapp: '',
    ),
    Developer(
      name: 'Dr.Inas Leila ',
      image: 'assets/images/mia_photo.jpg',
      description:
      'الدكتورة ايناس ليلى , الدكتورة المشرفة على المشروع',
      facebook: '',
      linkedin: '',
      whatsapp: '',
    ),
    // Add more developers here if needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ListView(
            children: [
              const SizedBox(
                height: 40,
              ),
               Padding(
                padding: EdgeInsets.all(12.0),
                child: Text("هذا التطبيق هو محاكي لنظام انتظار وخدمة بسيط ",
                  style: TextStyle(
                    wordSpacing: 7,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              DeveloperListItem(developer: developers[0]),
              DeveloperListItem(developer: developers[1]),
              DeveloperListItem(developer: developers[2]),
              Image.asset(
                "assets/images/icon_app.png",
                height: 500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Developer {
  final String name;
  final String image;
  final String description;
  final String facebook;
  final String linkedin;
  final String whatsapp;

  Developer({
    required this.name,
    required this.image,
    required this.description,
    required this.facebook,
    required this.linkedin,
    required this.whatsapp,
  });
}

class DeveloperListItem extends StatelessWidget {
  final Developer developer;

  DeveloperListItem({required this.developer});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: CircleAvatar(
        backgroundImage: AssetImage(developer.image),
      ),
      title: Row(
        children: [
          const Spacer(),
          Text(developer.name),
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DeveloperDetails(developer: developer),
          ),
        );
      },
    );
  }
}

class DeveloperDetails extends StatelessWidget {
  final Developer developer;

  DeveloperDetails({required this.developer});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const Spacer(),
            CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage(developer.image),
            ),
            const SizedBox(height: 20),
            Text(
              developer.name,
              style: const TextStyle(color: Colors.black, fontSize: 20),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Image.asset("assets/images/facebook.gif"),
                  onPressed: () {
                    openFacebook(developer.facebook);
                    // Open Facebook profile
                  },
                ),
                IconButton(
                  icon: Container(
                      color: Colors.red,
                      child: Image.asset(
                        "assets/images/linkedin.gif",
                      )),
                  onPressed: () {
                    openLinkedIn(developer.linkedin);
                    // Open LinkedIn profile
                  },
                ),
                IconButton(
                  icon: Image.asset("assets/images/whatsapp.gif"),
                  onPressed: () {
                    openWhatsApp(developer.whatsapp);
                    // Open WhatsApp profile
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                developer.description,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

// Function to open WhatsApp
  void openWhatsApp(String phoneNumber) async {
    String whatsappUrl = "whatsapp://send?phone=$phoneNumber";
    await canLaunch(whatsappUrl)
        ? launch(whatsappUrl)
        : print('Error launching WhatsApp');
  }

// Function to open Facebook
  void openFacebook(String profileUrl) async {
    String facebookUrl = profileUrl;
    await canLaunch(facebookUrl)
        ? launch(facebookUrl)
        : print('Error launching Facebook');
  }

// Function to open LinkedIn
  void openLinkedIn(String profileUrl) async {
    String linkedInUrl = profileUrl;
    await canLaunch(linkedInUrl)
        ? launch(linkedInUrl)
        : print('Error launching LinkedIn');
  }
}
