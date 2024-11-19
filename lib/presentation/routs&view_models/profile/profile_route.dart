import 'package:event_mobile_app/app/components/constants/icons_manager.dart';
import 'package:event_mobile_app/app/components/constants/variables_manager.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/bloc_manage.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/components/constants/stack_background_manager.dart';

class ProfileRoute extends StatefulWidget {
  const ProfileRoute({super.key});

  @override
  State<ProfileRoute> createState() => _ProfileRouteState();
}

class _ProfileRouteState extends State<ProfileRoute> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EventsBloc, AppStates>(
        builder: (context, state) => _getScaffold(),
        listener: (context, state) {});
  }

  Widget _getScaffold() => Scaffold(
        body: stackBackGroundManager(
            otherWidget: _screenWidgets(), isDark: VariablesManager.isDark),
      );

  List<Widget> _screenWidgets() => [
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //change photo icon
                  Align(
                    alignment: Alignment.topRight,
                    child: CircleAvatar(
                      backgroundColor: Colors.cyanAccent,
                      radius: 20,
                      child: Center(
                        child: Icon(IconsManager.camera),
                      ),
                    ),
                  ),
                  //profile photo
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 5,
                    child: Container(
                      width: MediaQuery.of(context).size.height / 5,
                      height: MediaQuery.of(context).size.height / 5,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(
                            'https://static.thenounproject.com/png/1110353-200.png',
                          ),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.cyanAccent,
                            //TODO : ...
                            BlendMode.srcATop, // مزج اللون مع الصورة
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  //list view all bottons
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        // Past films (bought films)
                        CustomListTileCard(
                          leadingIcon: IconsManager.cart,
                          title: 'Orders',
                          onTap: () => print("Orders button pressed!"),
                        ),
                        const SizedBox(height: 14),

                        // Coupons
                        CustomListTileCard(
                          leadingIcon: Icons.local_offer,
                          title: 'Coupons',
                          onTap: () => print("Coupons button pressed!"),
                        ),
                        const SizedBox(height: 14),

                        // My movies balance
                        CustomListTileCard(
                          leadingIcon: Icons.monetization_on,
                          title: 'My App Balance',
                          onTap: () => print("My App Balance button pressed!"),
                          suffix: Text('0.0 €'),
                        ),
                        const SizedBox(height: 14),

                        // Address
                        CustomListTileCard(
                          leadingIcon: Icons.my_location,
                          title: 'Address',
                          onTap: () => print("Address button pressed!"),
                        ),
                        const SizedBox(height: 14),

                        // Payment methods
                        CustomListTileCard(
                          leadingIcon: Icons.credit_card,
                          title: 'Payment Methods',
                          onTap: () => print("Payment Methods button pressed!"),
                        ),
                        const SizedBox(height: 14),

                        // Language
                        CustomExpandableCard(
                          leadingIcon: Icons.language,
                          title: 'Language',
                          children: [
                            ListTile(
                              title: Text('Netherlands'),
                              onTap: () => print("Netherlands selected"),
                            ),
                            ListTile(
                              title: Text('العربية'),
                              onTap: () => print("Arabic selected"),
                            ),
                            ListTile(
                              title: Text('English'),
                              onTap: () => print("English selected"),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),

                        // Theme Mode (Dark & Light)
                        CustomExpandableCard(
                          leadingIcon: Icons.light_mode,
                          title: 'Theme Mode',
                          children: [
                            ListTile(
                              title: Text('Based on phone mode'),
                              onTap: () =>
                                  print("Based on phone mode selected"),
                            ),
                            ListTile(
                              title: Text('Manual'),
                              onTap: () => print("Manual selected"),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),

                        // Color Theme (Green, Blue, Purple)
                        CustomExpandableCard(
                          leadingIcon: Icons.color_lens,
                          title: 'Color Theme',
                          children: [
                            ListTile(
                              title: Text('Green'),
                              onTap: () => print("Green selected"),
                            ),
                            ListTile(
                              title: Text('Blue'),
                              onTap: () => print("Blue selected"),
                            ),
                            ListTile(
                              title: Text('Purple'),
                              onTap: () => print("Purple selected"),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),

                        // Feedback, Complaints, and Suggestions
                        CustomListTileCard(
                          leadingIcon: Icons.feedback,
                          title: 'Feedback and Complaints',
                          onTap: () => print("Feedback button pressed!"),
                        ),
                        const SizedBox(height: 14),

                        // About Us
                        CustomListTileCard(
                          leadingIcon: Icons.info,
                          title: 'About Us',
                          onTap: () => print("About Us button pressed!"),
                        ),
                        const SizedBox(height: 14),

                        // Privacy and Policy
                        CustomListTileCard(
                          leadingIcon: Icons.privacy_tip,
                          title: 'Privacy and Policy',
                          onTap: () => print("Privacy button pressed!"),
                        ),
                        const SizedBox(height: 14),

                        // Logout
                        CustomListTileCard(
                          leadingIcon: Icons.logout,
                          title: 'Logout',
                          onTap: () => print("Logout button pressed!"),
                        ),
                        const SizedBox(height: 14),
                      ],
                    ),
                  ),
                ]),
          ),
        )
      ];

// Widget myColumn()=> Column(
//   mainAxisAlignment: MainAxisAlignment.center,
//   crossAxisAlignment: CrossAxisAlignment.center,
//   children: [
//     googleAndAppleButton(
//         nameOfButton: "login",
//         context: context,
//         onTap: () {
//           navigateTo(context, RouteStringsManager.loginRoute);
//         }),
//     SizedBox(
//       height: 10,
//     ),
//     googleAndAppleButton(
//         nameOfButton: "logout",
//         context: context,
//         onTap: () {
//           bloc.add(LogoutEvent());
//         }),
//     Row(
//       children: [
//         GestureDetector(
//             onTap: () {
//               bloc.add(ChangeColorModeEvent(AppColorsTheme.green));
//             },
//             child: Container(
//               height: 70,
//               width: 120,
//               color: Colors.green,
//             )),
//         GestureDetector(
//             onTap: () {
//               bloc.add(ChangeColorModeEvent(AppColorsTheme.purple));
//             },
//             child: Container(
//               height: 70,
//               width: 120,
//               color: Colors.purple,
//             )),
//         GestureDetector(
//             onTap: () {
//               bloc.add(ChangeColorModeEvent(AppColorsTheme.blue));
//             },
//             child: Container(
//               height: 70,
//               width: 120,
//               color: Colors.blue,
//             )),
//       ],
//     ),
//     GestureDetector(
//         onTap: () {
//           bloc.add(ChangeLanguageEvent(ApplicationLanguage.ar));
//         },
//         child: Container(
//           height: 70,
//           width: 120,
//           color: Colors.red,
//           child: Text(GeneralStrings.arabicLanguage),
//         )),
//     GestureDetector(
//         onTap: () {
//           bloc.add(ChangeLanguageEvent(ApplicationLanguage.en));
//         },
//         child: Container(
//           height: 70,
//           width: 120,
//           color: Colors.red,
//           child: Text(GeneralStrings.englishLanguage),
//         )),
//     GestureDetector(
//         onTap: () {
//           bloc.add(ChangeLanguageEvent(ApplicationLanguage.nl));
//         },
//         child: Container(
//           height: 70,
//           width: 120,
//           color: Colors.red,
//           child: Text(GeneralStrings.netherlandsLanguage),
//         )),
//   ],
// ),
}

// Widget for ListTile Card
class CustomListTileCard extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final VoidCallback onTap;
  final Widget? suffix;

  const CustomListTileCard(
      {super.key,
      required this.leadingIcon,
      required this.title,
      required this.onTap,
      this.suffix});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 9,
      shadowColor: VariablesManager.isDark ? Colors.white : Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.cyanAccent,
          ),
          child: ListTile(
            dense: true,
            leading: Icon(leadingIcon, color: Colors.orange),
            title: Text(title),
            onTap: onTap,
            trailing: suffix,
          ),
        ),
      ),
    );
  }
}

// Widget for Expandable Card
class CustomExpandableCard extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final List<Widget> children;

  const CustomExpandableCard({
    super.key,
    required this.leadingIcon,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 9,
      shadowColor: VariablesManager.isDark ? Colors.white : Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.cyanAccent,
          ),
          child: ExpansionTile(
            dense: true,
            collapsedBackgroundColor: Colors.cyanAccent,
            childrenPadding: const EdgeInsets.symmetric(horizontal: 40),
            leading: Icon(leadingIcon, color: Colors.orange),
            title: Text(title),
            backgroundColor: Colors.green,
            children: children,
          ),
        ),
      ),
    );
  }
}
