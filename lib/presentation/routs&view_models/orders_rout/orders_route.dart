import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:badges/badges.dart' as badges;
import 'package:confetti/confetti.dart';
import 'package:url_launcher/url_launcher.dart';

class BillsPage extends StatefulWidget {
  final List<Map<String, dynamic>> bills;

  const BillsPage({super.key, required this.bills});

  @override
  State<BillsPage> createState() => _BillsPageState();
}

class _BillsPageState extends State<BillsPage> {
  late ConfettiController _confettiController;
  final DateRangePickerController _dateController = DateRangePickerController();
  final List<String> _filterOptions = ['الكل', 'آخر أسبوع', 'آخر شهر', 'مخصص'];
  String _selectedFilter = 'الكل';
  bool _showDatePicker = false;
  bool _showConfetti = false;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
    if (widget.bills.isNotEmpty) {
      _showConfetti = true;
      _confettiController.play();
      Future.delayed(const Duration(seconds: 3), () {
        setState(() => _showConfetti = false);
      });
    }
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('فواتير الشراء'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: () => _showFilterBottomSheet(context),
          ),
        ],
      ),
      body: Stack(
        children: [
          if (widget.bills.isEmpty) _buildEmptyState(),
          if (widget.bills.isNotEmpty) _buildBillsList(),
          if (_showConfetti)
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                colors: const [
                  Colors.green,
                  Colors.blue,
                  Colors.pink,
                  Colors.orange,
                  Colors.purple
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/no_bills.svg',
            height: 200,
          ),
          const SizedBox(height: 20),
          Text(
            'لا توجد فواتير حتى الآن',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'بعد قيامك بحجز تذاكر الأفلام، ستظهر الفواتير هنا',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('تصفح الأفلام'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBillsList() {
    final filteredBills = _filterBills();

    return Column(
      children: [
        if (_showDatePicker) _buildDateRangePicker(),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              // Refresh logic here
            },
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        const Icon(Icons.receipt_long, color: Colors.blue),
                        const SizedBox(width: 8),
                        Text(
                          '${filteredBills.length} فاتورة',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          'الإجمالي: ${_calculateTotal(filteredBills)} ر.س',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      final bill = filteredBills[index];
                      return _buildBillCard(bill, index);
                    },
                    childCount: filteredBills.length,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBillCard(Map<String, dynamic> bill, int index) {
    final date = DateTime.parse(bill['reservationDate']);
    final formattedDate = DateFormat('yyyy/MM/dd - hh:mm a').format(date);
    final showTime = '${bill['showTimesResponseTime']} - ${bill['showTimesResponseDate']}';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () => _showBillDetails(bill),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
          Row(
          children: [
          ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            bill['verticalPhoto'] ?? bill['photo'],
            width: 80,
            height: 120,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                bill['movieName'],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.schedule, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    bill['duration'],
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.date_range, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    showTime,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.room, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    'قاعة ${bill['showTimesResponseHall']}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
        ],
      ),
      const SizedBox(height: 16),
      Divider(color: Colors.grey[300]),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'رقم الحجز',
                style: TextStyle(color: Colors.grey),
              ),
              Text(
                bill['reservations_code'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'المبلغ',
                style: TextStyle(color: Colors.grey),),
                Text(
                  '${bill['totalBill']} ر.س',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.green,
                  ),
                ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                formattedDate,
                style: TextStyle(color: Colors.grey[600]),
              ),
              badges.Badge(
                badgeStyle: badges.BadgeStyle(
                  badgeColor: _getPaymentMethodColor(bill['paymentType']),
                ),
                badgeContent: Text(
                  _getPaymentMethodText(bill['paymentType']),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
    ),
    );
  }

  Widget _buildDateRangePicker() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: SfDateRangePicker(
        controller: _dateController,
        selectionMode: DateRangePickerSelectionMode.range,
        initialSelectedRange: PickerDateRange(
          DateTime.now().subtract(const Duration(days: 30)),
          DateTime.now(),
        ),
        onCancel: () {
          setState(() {
            _showDatePicker = false;
            _selectedFilter = 'الكل';
          });
        },
        onSubmit: (value) {
          setState(() {
            _showDatePicker = false;
            _selectedFilter = 'مخصص';
          });
        },
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'تصفية الفواتير',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ..._filterOptions.map((option) {
                    return RadioListTile(
                      title: Text(option),
                      value: option,
                      groupValue: _selectedFilter,
                      onChanged: (value) {
                        setState(() {
                          _selectedFilter = value.toString();
                          if (option != 'مخصص') {
                            _showDatePicker = false;
                            Navigator.pop(context);
                            setState(() {});
                          }
                        });
                        if (option == 'مخصص') {
                          setState(() => _showDatePicker = true);
                          Navigator.pop(context);
                        }
                      },
                    );
                  }),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedFilter = 'الكل';
                        _showDatePicker = false;
                      });
                      Navigator.pop(context);
                    },
                    child: const Text('إعادة تعيين الفلتر'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showBillDetails(Map<String, dynamic> bill) {
    final reservedSeats = (bill['reserved_seats'] as List).join(', ');
    final showTime = '${bill['showTimesResponseTime']} - ${bill['showTimesResponseDate']}';
    final date = DateTime.parse(bill['reservationDate']);
    final formattedDate = DateFormat('yyyy/MM/dd - hh:mm a').format(date);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 60,
                  height: 5,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      bill['verticalPhoto'] ?? bill['photo'],
                      width: 100,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          bill['movieName'],
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'المدة: ${bill['duration']}',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'قاعة: ${bill['showTimesResponseHall']}',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'تفاصيل الحجز',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              _buildDetailRow('تاريخ ووقت العرض', showTime),
              _buildDetailRow('المقاعد المحجوزة', 'مقعد $reservedSeats'),
              _buildDetailRow('سعر التذكرة', '${bill['ticket_price']} ر.س'),
              _buildDetailRow('عدد التذاكر', '${(bill['reserved_seats'] as List).length}'),
              const SizedBox(height: 16),
              const Text(
                'تفاصيل الدفع',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              _buildDetailRow('طريقة الدفع', _getPaymentMethodText(bill['paymentType'])),
              _buildDetailRow('المبلغ الإجمالي', '${bill['totalBill']} ر.س'),
              _buildDetailRow('رقم المرجعي', bill['referenceNumber']),
              _buildDetailRow('تاريخ الحجز', formattedDate),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _viewReceipt(bill['receiptUrl']),
                      child: const Text('عرض الإيصال'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _shareBill(bill),
                      child: const Text('مشاركة'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            '$title: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          Text(value),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _filterBills() {
    if (_selectedFilter == 'الكل') return widget.bills;

    final now = DateTime.now();
    DateTime startDate;

    switch (_selectedFilter) {
      case 'آخر أسبوع':
        startDate = now.subtract(const Duration(days: 7));
        break;
      case 'آخر شهر':
        startDate = now.subtract(const Duration(days: 30));
        break;
      case 'مخصص':
        if (_dateController.selectedRange != null) {
          startDate = _dateController.selectedRange!.startDate!;
          final endDate = _dateController.selectedRange!.endDate ?? startDate;
          return widget.bills.where((bill) {
            final billDate = DateTime.parse(bill['reservationDate']);
            return billDate.isAfter(startDate) && billDate.isBefore(endDate.add(const Duration(days: 1)));
          }).toList();
        }
        return widget.bills;
      default:
        return widget.bills;
    }

    return widget.bills.where((bill) {
      final billDate = DateTime.parse(bill['reservationDate']);
      return billDate.isAfter(startDate);
    }).toList();
  }

  String _calculateTotal(List<Map<String, dynamic>> bills) {
    double total = 0;
    for (var bill in bills) {
      total += (bill['totalBill'] as num).toDouble();
    }
    return total.toStringAsFixed(2);
  }

  Color _getPaymentMethodColor(String method) {
    switch (method.toLowerCase()) {
      case 'paypal':
        return Colors.blue[800]!;
      case 'ideal':
        return Colors.orange;
      case 'revolut_pay':
        return Colors.purple;
      default:
        return Colors.green;
    }
  }

  String _getPaymentMethodText(String method) {
    switch (method.toLowerCase()) {
      case 'paypal':
        return 'PayPal';
      case 'ideal':
        return 'iDEAL';
      case 'revolut_pay':
        return 'Revolut';
      default:
        return method;
    }
  }

  void _viewReceipt(String url) {
    launchUrl(Uri.parse(url));}

  void _shareBill(Map<String, dynamic> bill) {
    // Implement sharing functionality
  }
}