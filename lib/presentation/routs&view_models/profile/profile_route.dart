import 'package:event_mobile_app/app/components/constants/font_manager.dart';
import 'package:event_mobile_app/app/components/constants/icons_manager.dart';
import 'package:event_mobile_app/app/components/constants/variables_manager.dart';
import 'package:event_mobile_app/data/local_storage/shared_local.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/bloc_manage.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/states.dart';
import 'package:event_mobile_app/presentation/routs&view_models/profile/profile_model_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/components/constants/color_manager.dart';
import '../../../app/components/constants/dio_and_mapper_constants.dart';
import '../../../app/components/constants/general_strings.dart';
import '../../../app/components/constants/getSize/getSize.dart';
import '../../../app/components/constants/size_manager.dart';
import '../../../app/components/constants/stack_background_manager.dart';
import '../../../domain/local_models/models.dart';

class ProfileRoute extends StatefulWidget {
  const ProfileRoute({super.key});

  @override
  State<ProfileRoute> createState() => _ProfileRouteState();
}

class _ProfileRouteState extends State<ProfileRoute> {
  late ProfileModelView _model;

  @override
  void initState() {
    super.initState();
    _model = ProfileModelView(context);
    _model.start();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsBloc, AppStates>(
      builder: (context, state) => _getScaffold(bloc: _model.bloc),
    );
  }

  Widget _getScaffold({required EventsBloc bloc}) => Scaffold(
        body: stackBackGroundManager(
            otherWidget: _screenWidgets(bloc: bloc),
            isDark: VariablesManager.isDark),
      );

  List<Widget> _screenWidgets({required EventsBloc bloc}) => [
        SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(SizeManager.d14),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ..._buildUserSpecificItems(
                      context: context,
                      bloc: bloc,
                      isLoggedIn:
                          VariablesManager.firebaseAuthInstance.currentUser !=
                              null,
                    ),
                    ..._buildExpandableItems(
                      context: context,
                      bloc: bloc,
                    ),
                    _buildCustomListTileCard(
                      context: context,
                      leadingIcon: Icons.feedback,
                      title: GeneralStrings.feedback(context),
                      onTap: () {
                        _model.onFeedbackButtonPressed();
                      },
                    ),
                    SizedBox(
                        height: GetSize.heightValue(SizeManager.d14, context)),
                    _buildCustomListTileCard(
                      context: context,
                      leadingIcon: Icons.info,
                      title: GeneralStrings.aboutUs(context),
                      onTap: () {
                        _model.onAboutUsButtonPressed();
                      },
                    ),
                    SizedBox(
                        height: GetSize.heightValue(SizeManager.d14, context)),
                    _buildCustomListTileCard(
                      context: context,
                      leadingIcon: Icons.privacy_tip,
                      title: GeneralStrings.privacyPolicy(context),
                      onTap: () {
                        _model.onPrivacyButtonPressed();
                      },
                    ),
                    SizedBox(
                        height: GetSize.heightValue(SizeManager.d14, context)),
                    Visibility(
                      visible:
                          VariablesManager.firebaseAuthInstance.currentUser !=
                              null,
                      child: _buildCustomListTileCard(
                        context: context,
                        leadingIcon: Icons.logout,
                        title: GeneralStrings.logout(context),
                        onTap: () {
                          _model.onLogoutButtonPressed();
                        },
                      ),
                    ),
                    SizedBox(
                      height: GetSize.heightValue(SizeManager.d20, context),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ];

  List<Widget> _buildUserSpecificItems(
      {required BuildContext context,
      required EventsBloc bloc,
      required bool isLoggedIn}) {
    if (isLoggedIn) {
      return [
        //change photo icon
        Align(
          alignment: Alignment.topRight,
          child: CircleAvatar(
            backgroundColor: ColorManager.lightBlue,
            radius: 20,
            child: Center(
              child: Icon(IconsManager.camera),
            ),
          ),
        ),
        //profile photo
        RepaintBoundary(
          child: SizedBox(
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
                    ColorManager.lightBlue,
                    //TODO : ...
                    BlendMode.srcATop,
                  ),
                ),
              ),
            ),
          ),
        ),
        _buildCustomListTileCard(
          context: context,
          leadingIcon: IconsManager.cart,
          title: GeneralStrings.orders(context),
          onTap: () => _model.onOrdersButtonPressed(),
        ),
        SizedBox(height: GetSize.heightValue(SizeManager.d14, context)),
        _buildCustomListTileCard(
          context: context,
          leadingIcon: Icons.local_offer,
          title: GeneralStrings.coupons(context),
          onTap: () => _model.onCouponsButtonPressed(),
        ),
        SizedBox(height: GetSize.heightValue(SizeManager.d14, context)),
        _buildCustomListTileCard(
          context: context,
          leadingIcon: Icons.monetization_on,
          title: GeneralStrings.myAppBalance(context),
          onTap: () => _model.onMyAppBalanceButtonPressed(),
          suffix: Text('0,0 €'),
        ),
        SizedBox(height: GetSize.heightValue(SizeManager.d14, context)),
      ];
    } else {
      return [
        _buildCustomListTileCard(
          context: context,
          leadingIcon: Icons.logout,
          title: GeneralStrings.loginOrRegister(context),
          onTap: () => _model.onLoginOrRegister(),
        ),
        SizedBox(height: GetSize.heightValue(SizeManager.d14, context)),
      ];
    }
  }

  List<Widget> _buildExpandableItems(
      {required BuildContext context, required EventsBloc bloc}) {
    return [
      _buildCustomExpandableCard(
        context: context,
        leadingIcon: Icons.language,
        title: GeneralStrings.language(context),
        children: [
          ListTile(
            title: Text(
              'Netherlands',
              style: TextStyleManager.paragraphStyle(context)
                  ?.copyWith(color: Colors.black),
            ),
            onTap: () {
              _model.onChangeLanguageNetherlands();
            },
            dense: true,
            trailing: _model.selectedLanguageIndex == AppConstants.intZero
                ? Icon(IconsManager.trueIcon)
                : SizedBox(),
          ),
          ListTile(
            title: Text(
              'Español',
              style: TextStyleManager.paragraphStyle(context)
                  ?.copyWith(color: Colors.black),
            ),
            onTap: () {
              _model.onChangeLanguageSpanish();
            },
            dense: true,
            trailing: _model.selectedLanguageIndex == SizeManager.i1
                ? Icon(IconsManager.trueIcon)
                : SizedBox(),
          ),
          ListTile(
            title: Text(
              'Français',
              style: TextStyleManager.paragraphStyle(context)
                  ?.copyWith(color: Colors.black),
            ),
            onTap: () {
              _model.onChangeLanguageFranch();
            },
            dense: true,
            trailing: _model.selectedLanguageIndex == SizeManager.i2
                ? Icon(IconsManager.trueIcon)
                : SizedBox(),
          ),
          ListTile(
            title: Text(
              'العربية',
              style: TextStyleManager.paragraphStyle(context)
                  ?.copyWith(color: Colors.black),
            ),
            onTap: () {
              _model.onChangeLanguageArabic();
            },
            dense: true,
            trailing: _model.selectedLanguageIndex == SizeManager.i3
                ? Icon(IconsManager.trueIcon)
                : SizedBox(),
          ),
          ListTile(
            title: Text(
              'English',
              style: TextStyleManager.paragraphStyle(context)
                  ?.copyWith(color: Colors.black),
            ),
            onTap: () {
              _model.onChangeLanguageEnglish();
            },
            dense: true,
            trailing: _model.selectedLanguageIndex == SizeManager.i4
                ? Icon(IconsManager.trueIcon)
                : SizedBox(),
          ),
          ListTile(
            title: Text(
              'Turkish',
              style: TextStyleManager.paragraphStyle(context)
                  ?.copyWith(color: Colors.black),
            ),
            onTap: () {
              _model.onChangeLanguageTurkish();
            },
            dense: true,
            trailing: _model.selectedLanguageIndex == SizeManager.i5
                ? Icon(IconsManager.trueIcon)
                : SizedBox(),
          ),
          ListTile(
            title: Text(
              'Русский',
              style: TextStyleManager.paragraphStyle(context)
                  ?.copyWith(color: Colors.black),
            ),
            onTap: () {
              _model.onChangeLanguageRussian();
            },
            dense: true,
            trailing: _model.selectedLanguageIndex == SizeManager.i6
                ? Icon(IconsManager.trueIcon)
                : SizedBox(),
          ),
          ListTile(
            title: Text(
              'Italiano',
              style: TextStyleManager.paragraphStyle(context)
                  ?.copyWith(color: Colors.black),
            ),
            onTap: () {
              _model.onChangeLanguageItalian();
            },
            dense: true,
            trailing: _model.selectedLanguageIndex == SizeManager.i7
                ? Icon(IconsManager.trueIcon)
                : SizedBox(),
          ),
          ListTile(
            title: Text(
              'Deutsch',
              style: TextStyleManager.paragraphStyle(context)
                  ?.copyWith(color: Colors.black),
            ),
            onTap: () {
              _model.onChangeLanguageGerman();
            },
            dense: true,
            trailing: _model.selectedLanguageIndex == SizeManager.i8
                ? Icon(IconsManager.trueIcon)
                : SizedBox(),
          ),
        ],
        suffixText: Text(
            SharedPref.prefs.getString(GeneralStrings.appLanguage) ?? 'en'),
      ),
      SizedBox(height: GetSize.heightValue(SizeManager.d14, context)),
      _buildCustomExpandableCard(
        context: context,
        leadingIcon: Icons.light_mode,
        title: GeneralStrings.themeMode(context),
        children: [
          ListTile(
            title: Text(
              GeneralStrings.basedOnPhoneMode(context),
              style: TextStyleManager.paragraphStyle(context)
                  ?.copyWith(color: Colors.black),
            ),
            onTap: () {
              _model.onChangeThemeBasedOnPhone();
            },
            dense: true,
            trailing: SharedPref.prefs.getBool(GeneralStrings.isManual)!
                ? SizedBox()
                : Icon(IconsManager.trueIcon),
          ),
          ExpansionTile(
            title: Text(
              GeneralStrings.manual(context),
              style: TextStyleManager.paragraphStyle(context)
                  ?.copyWith(color: Colors.black),
            ),
            trailing: SharedPref.prefs.getBool(GeneralStrings.isManual)!
                ? Icon(IconsManager.trueIcon)
                : SizedBox(),
            onExpansionChanged: (bool expanded) {
              if (expanded) {
                _model.onChangeThemeManual();
              }
            },
            children: [
              ListTile(
                title: Text(
                  GeneralStrings.darkMode(context),
                  style: TextStyleManager.smallParagraphStyle(context)
                      ?.copyWith(color: Colors.black),
                ),
                onTap: () {
                  _model.onChangeThemeManualToDark();
                },
              ),
              ListTile(
                title: Text(
                  GeneralStrings.lightMode(context),
                  style: TextStyleManager.smallParagraphStyle(context)
                      ?.copyWith(color: Colors.black),
                ),
                onTap: () {
                  _model.onChangeThemeManualToLight();
                },
              ),
            ],
          ),
        ],
        suffixText: Text(SharedPref.prefs.getBool(GeneralStrings.isManual)!
            ? SharedPref.prefs.getString(GeneralStrings.appMode)!
            : GeneralStrings.bopm(context)),
      ),
      SizedBox(height: GetSize.heightValue(SizeManager.d14, context)),
      _buildCustomExpandableCard(
        context: context,
        leadingIcon: Icons.color_lens,
        title: GeneralStrings.colorThemeApp(context),
        children: [
          ListTile(
            title: Text(
              GeneralStrings.green(context),
              style: TextStyleManager.paragraphStyle(context)
                  ?.copyWith(color: Colors.black),
            ),
            onTap: () {
              _model.onChangeColorGreen();
            },
            dense: true,
            trailing: _model.selectedColorIndex == AppConstants.intZero
                ? Icon(IconsManager.trueIcon)
                : SizedBox(),
          ),
          ListTile(
            title: Text(
              GeneralStrings.blue(context),
              style: TextStyleManager.paragraphStyle(context)
                  ?.copyWith(color: Colors.black),
            ),
            onTap: () {
              _model.onChangeColorBlue();
            },
            dense: true,
            trailing: _model.selectedColorIndex == SizeManager.i1
                ? Icon(IconsManager.trueIcon)
                : SizedBox(),
          ),
          ListTile(
            title: Text(
              GeneralStrings.purple(context),
              style: TextStyleManager.paragraphStyle(context)
                  ?.copyWith(color: Colors.black),
            ),
            onTap: () {
              _model.onChangeColorPurple();
            },
            dense: true,
            trailing: _model.selectedColorIndex == SizeManager.i2
                ? Icon(IconsManager.trueIcon)
                : SizedBox(),
          ),
        ],
        suffixText: Text(
            SharedPref.prefs.getString(GeneralStrings.colorTheme) ??
                GeneralStrings.green(context)),
      ),
      SizedBox(height: GetSize.heightValue(SizeManager.d14, context)),
    ];
  }

  Widget _buildCustomListTileCard({
    required BuildContext context,
    required IconData leadingIcon,
    required String title,
    required VoidCallback onTap,
    Widget? suffix,
  }) {
    return CustomListTileCard(
      leadingIcon: leadingIcon,
      title: title,
      onTap: onTap,
      suffix: suffix,
    );
  }

  Widget _buildCustomExpandableCard({
    required BuildContext context,
    required IconData leadingIcon,
    required String title,
    required List<Widget> children,
    Widget? suffixText,
  }) {
    return CustomExpandableCard(
      leadingIcon: leadingIcon,
      title: title,
      suffix: suffixText,
      children: children,
    );
  }
}
