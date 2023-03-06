import 'package:flutter/material.dart';

const Color appColor = Colors.blueAccent;

const String avatarImg =
    'https://media.licdn.com/dms/image/C4E03AQHsosUpXrZH1g/profile-displayphoto-shrink_400_400/0/1658861666491?e=1683763200&v=beta&t=tEHcAmdY9a1gtSWsBb8NBiFMWFl8aLTTTNzFfnE-UZs';

void main() {
  runApp(const PersonalPortfolioApp());
}

class PersonalPortfolioApp extends StatelessWidget {
  const PersonalPortfolioApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: PersonalPortfolio(),
        ),
      ),
    );
  }
}

class PersonalPortfolio extends StatefulWidget {
  const PersonalPortfolio({Key? key}) : super(key: key);

  @override
  PersonalPortfolioState createState() => PersonalPortfolioState();
}

class PersonalPortfolioState extends State<PersonalPortfolio>
    with TickerProviderStateMixin {
  late AnimationController ctrl;
  late AnimationController contentCtrl;

  @override
  void initState() {
    super.initState();
    ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    contentCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..forward();
  }

  @override
  void dispose() {
    ctrl.dispose();
    contentCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: contentCtrl, curve: Curves.easeInOut),
      ),
      child: SlideTransition(
        position: Tween<Offset>(
                begin: const Offset(0.0, 0.125), end: Offset.zero)
            .animate(
                CurvedAnimation(parent: contentCtrl, curve: Curves.easeInOut)),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  // the glowing circle
                  FadeTransition(
                    opacity: Tween<double>(begin: 1.0, end: 0.0).animate(
                      CurvedAnimation(parent: ctrl, curve: Curves.easeInOut),
                    ),
                    child: ScaleTransition(
                      scale: Tween<double>(begin: 1.0, end: 1.5).animate(
                        CurvedAnimation(parent: ctrl, curve: Curves.easeInOut),
                      ),
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: appColor,
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                  ),
                  // the avatar image container
                  Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      image: const DecorationImage(
                        image: NetworkImage(avatarImg),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(
                        color: appColor,
                        width: 8,
                      ),
                    ),
                  ),
                ],
              ),
              const Text(
                'Sosu Alfred',
                style: TextStyle(
                  color: appColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text('GDG Organizer / Flutter Developer'),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.email, color: appColor),
                    SizedBox(width: 10),
                    Text(
                      'sosualfred@gmail.com',
                      style: TextStyle(color: appColor),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
