import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _feedbackController = TextEditingController();
  double _rating = 3;
  FeedbackType _feedbackType = FeedbackType.complaint;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الشكاوى والملاحظات'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'نرحب بملاحظاتكم واستفساراتكم',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _buildFeedbackTypeSelector(),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'الاسم بالكامل',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال الاسم';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'البريد الإلكتروني',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال البريد الإلكتروني';
                  }
                  if (!value.contains('@')) {
                    return 'البريد الإلكتروني غير صالح';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              if (_feedbackType == FeedbackType.feedback)
                Column(
                  children: [
                    const Text('تقييمك لخدمتنا:'),
                    RatingBar.builder(
                      initialRating: _rating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        setState(() {
                          _rating = rating;
                        });
                      },
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              TextFormField(
                controller: _feedbackController,
                decoration: InputDecoration(
                  labelText: _feedbackType == FeedbackType.complaint
                      ? 'تفاصيل الشكوى'
                      : 'ملاحظاتك',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.comment),
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال التفاصيل';
                  }
                  if (value.length < 10) {
                    return 'الرجاء إدخال تفاصيل أكثر';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 25),
              Center(
                child: ElevatedButton(
                  onPressed: _submitFeedback,
                  child: const Text('إرسال'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeedbackTypeSelector() {
    return Row(
      children: [
        Expanded(
          child: ChoiceChip(
            label: const Text('شكوى'),
            selected: _feedbackType == FeedbackType.complaint,
            onSelected: (selected) {
              setState(() {
                _feedbackType = FeedbackType.complaint;
              });
            },
            selectedColor: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ChoiceChip(
            label: const Text('ملاحظات'),
            selected: _feedbackType == FeedbackType.feedback,
            onSelected: (selected) {
              setState(() {
                _feedbackType = FeedbackType.feedback;
              });
            },
            selectedColor: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }

  void _submitFeedback() {
    if (_formKey.currentState!.validate()) {
      // إرسال البيانات
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('تم الإرسال بنجاح'),
          content: const Text('شكراً لك على ملاحظاتك، سنقوم بمراجعتها قريباً.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _formKey.currentState!.reset();
              },
              child: const Text('حسناً'),
            ),
          ],
        ),
      );
    }
  }
}

enum FeedbackType { complaint, feedback }