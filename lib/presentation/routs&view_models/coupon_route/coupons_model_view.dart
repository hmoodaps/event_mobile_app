import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CouponsPage extends StatelessWidget {
  final List<Coupon> coupons = []; // سيتم ملؤها من API أو قاعدة بيانات

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('كوبونات الخصم'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: coupons.isEmpty
            ? _buildNoCouponsUI()
            : ListView.builder(
          itemCount: coupons.length,
          itemBuilder: (context, index) {
            return _buildCouponCard(coupons[index]);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddCouponDialog(context),
        child: const Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget _buildNoCouponsUI() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/no_coupons.svg',
            height: 200,
          ),
          const SizedBox(height: 20),
          Text(
            'لا يوجد كوبونات متاحة حالياً',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'يمكنك إضافة كوبون جديد بالضغط على زر (+)',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildCouponCard(Coupon coupon) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.only(bottom: 20),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade400,
              Colors.blue.shade700,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    coupon.code,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Chip(
                    label: Text(
                      '${coupon.discount}%',
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.black.withOpacity(0.2),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                coupon.description,
                style: const TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'صالح حتى: ${coupon.expiryDate}',
                    style: const TextStyle(color: Colors.white70),
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy, color: Colors.white),
                    onPressed: () => _copyCouponCode(coupon.code),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _copyCouponCode(String code) {
    // كود نسخ الكوبون
  }

  void _showAddCouponDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('إضافة كوبون جديد'),
          content: const CouponForm(),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('إلغاء'),
            ),
            ElevatedButton(
              onPressed: () {
                // حفظ الكوبون
                Navigator.pop(context);
              },
              child: const Text('حفظ'),
            ),
          ],
        );
      },
    );
  }
}

class CouponForm extends StatefulWidget {
  const CouponForm({Key? key}) : super(key: key);

  @override
  _CouponFormState createState() => _CouponFormState();
}

class _CouponFormState extends State<CouponForm> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  final _descController = TextEditingController();
  double _discount = 10;
  DateTime _expiryDate = DateTime.now().add(const Duration(days: 30));

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _codeController,
              decoration: const InputDecoration(
                labelText: 'كود الكوبون',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'الرجاء إدخال كود الكوبون';
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            TextFormField(
              controller: _descController,
              decoration: const InputDecoration(
                labelText: 'وصف الكوبون',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('نسبة الخصم'),
                Slider(
                  value: _discount,
                  min: 5,
                  max: 100,
                  divisions: 19,
                  label: _discount.round().toString(),
                  onChanged: (value) {
                    setState(() {
                      _discount = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                const Text('تاريخ الانتهاء:'),
                const SizedBox(width: 10),
                TextButton(
                  onPressed: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: _expiryDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (selectedDate != null) {
                      setState(() {
                        _expiryDate = selectedDate;
                      });
                    }
                  },
                  child: Text(
                    '${_expiryDate.day}/${_expiryDate.month}/${_expiryDate.year}',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Coupon {
  final String code;
  final String description;
  final double discount;
  final String expiryDate;

  Coupon({
    required this.code,
    required this.description,
    required this.discount,
    required this.expiryDate,
  });
}