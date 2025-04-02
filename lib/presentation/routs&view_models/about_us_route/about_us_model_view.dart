import 'package:event_mobile_app/app/components/constants/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title:  Text('عن التطبيق' ,style: TextStyleManager.bodyStyle(context),),
          centerTitle: true,
          bottom:  TabBar(
            labelStyle: TextStyleManager.bodyStyle(context),
            tabs: [
              Tab(text: 'من نحن' ),
              Tab(text: 'سياسة الخصوصية'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildAboutUsContent(
              context,
            ),
            _buildPrivacyPolicyContent(
              context,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutUsContent(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage('assets/images/logo.png'),
          ),
          const SizedBox(height: 20),
          Text(
            'اسم الشركة',
            style: TextStyleManager.header(context),
          ),
          const SizedBox(height: 10),
          Text(
            'نسعى لتقديم أفضل الخدمات لعملائنا الكرام',
            style: TextStyleManager.titleStyle(context),
          ),
          const SizedBox(height: 30),
          _buildInfoCard(
            icon: Icons.history,
            title: 'تاريخنا',
            content:
                'تأسست شركتنا عام 2010 بهدف تقديم حلول تقنية مبتكرة. خلال السنوات الماضية، استطعنا بناء سمعة طيبة في مجالنا.',
          ),
          const SizedBox(height: 20),
          _buildInfoCard(
            icon: Icons.people,
            title: 'فريقنا',
            content:
                'نحن فريق من المحترفين المتفانين في عملنا، نعمل معاً لتحقيق رضا عملائنا وتقديم أفضل الحلول التقنية.',
          ),
          const SizedBox(height: 20),
          _buildInfoCard(
            icon: Icons.phone,
            title: 'اتصل بنا',
            content:
                'للتواصل معنا:\nالبريد: info@company.com\nالهاتف: +966123456789',
            isContact: true,
          ),
          const SizedBox(height: 20),
          _buildSocialMediaLinks(),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String content,
    bool isContact = false,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(icon, size: 30, color: Colors.blue),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              content,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
              textAlign: isContact ? TextAlign.center : TextAlign.start,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialMediaLinks() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Image.asset('assets/icons/facebook.png', width: 60),
          onPressed: () => _launchURL('https://facebook.com/company'),
        ),
        IconButton(
          icon: Image.asset('assets/icons/twitter.png', width: 60),
          onPressed: () => _launchURL('https://twitter.com/company'),
        ),
        IconButton(
          icon: Image.asset('assets/icons/instagram.png', width: 60),
          onPressed: () => _launchURL('https://instagram.com/company'),
        ),
        IconButton(
          icon: Image.asset('assets/icons/linkedin.png', width: 60),
          onPressed: () => _launchURL('https://linkedin.com/company'),
        ),
      ],
    );
  }

  Widget _buildPrivacyPolicyContent(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'سياسة الخصوصية',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          _buildPrivacySection(
            context: context,
            title: '1. المعلومات التي نجمعها',
            content:
                'نجمع المعلومات التي تزودنا بها عند التسجيل في التطبيق أو استخدام خدماتنا، مثل الاسم وعنوان البريد الإلكتروني ومعلومات الدفع عند الاقتضاء.',
          ),
          _buildPrivacySection(
            context: context,
            title: '2. كيفية استخدام المعلومات',
            content:
                'نستخدم المعلومات لتقديم خدماتنا وتحسينها، وللاتصال بك، ولتحليل كيفية استخدام التطبيق، ولمنع الاحتيال.',
          ),
          _buildPrivacySection(
            context: context,
            title: '3. مشاركة المعلومات',
            content:
                'لا نبيع أو نشارك معلوماتك الشخصية مع أطراف ثالثة إلا كما هو موضح في هذه السياسة أو عند الحصول على موافقتك.',
          ),
          _buildPrivacySection(
            context: context,
            title: '4. الأمان',
            content:
                'نحن نستخدم إجراءات أمان معقولة لحماية معلوماتك الشخصية من الوصول غير المصرح به أو التغيير أو الإفشاء أو التدمير.',
          ),
          _buildPrivacySection(
            context: context,
            title: '5. التغييرات على السياسة',
            content:
                'قد نقوم بتحديث هذه السياسة من وقت لآخر. وسنخطرك بأي تغييرات جوهرية عن طريق نشر الإشعارات داخل التطبيق أو عبر البريد الإلكتروني.',
          ),
          const SizedBox(height: 20),
          const Text(
            'آخر تحديث: 1 يناير 2023',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacySection(
      {required String title,
      required String content,
      required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyleManager.titleStyle(context)),
          const SizedBox(height: 8),
          Text(
            content,
            style: TextStyleManager.bodyStyle(context),
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
