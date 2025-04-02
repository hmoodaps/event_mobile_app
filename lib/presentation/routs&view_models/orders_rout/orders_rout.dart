import 'package:event_mobile_app/app/components/constants/color_manager.dart';
import 'package:event_mobile_app/app/components/constants/variables_manager.dart';
import 'package:event_mobile_app/domain/local_models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import '../../../domain/models/billing_info/billing_info.dart';
import '../../../app/components/constants/font_manager.dart';

class PurchasedMoviesPage extends StatelessWidget {
  final List<BillingInfo> bills;

  const PurchasedMoviesPage({super.key, required this.bills});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('الفواتير المُشتراة',
                  style: TextStyleManager.header(context)?.copyWith(
                    color: Colors.white,
                  )),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.secondary,
                    ],
                  ),
                ),
              ),
            ),
            pinned: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: () => _showFilterOptions(context),
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) => _BillItem(bill: bills[index]),
              childCount: bills.length,
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('تصفية الفواتير',
                style: TextStyleManager.titleStyle(context)),
            const Divider(),
            // Add filter options here
          ],
        ),
      ),
    );
  }
}

class _BillItem extends StatelessWidget {
  final BillingInfo bill;

  const _BillItem({required this.bill});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd MMM yyyy - HH:mm');
    final isRefunded = bill.refunded ?? false;

    return Card(
      color: VariablesManager.isDark ? ColorManager.green2 :ColorManager.green4,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () => _navigateToDetails(context),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Movie Poster
              Hero(
                tag: bill.movieId ?? UniqueKey(),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: bill.verticalPhoto ?? '',
                    width: 100,
                    height: 150,
                    fit: BoxFit.cover,
                    placeholder: (ctx, url) => Container(
                      color: Colors.grey.shade800,
                    ),
                    errorWidget: (ctx, url, err) => const Icon(Icons.movie),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and Status
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            bill.movieName ?? 'غير معروف',
                            style: TextStyleManager.titleStyle(context)?.copyWith(
                              color: isRefunded
                                  ? Colors.grey
                                  : Theme.of(context).colorScheme.onBackground,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        _PaymentStatusIndicator(isRefunded: isRefunded),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Screening Details
                    _DetailRow(
                      icon: Icons.date_range,
                      text:
                      '${bill.showTimesResponseDate} · ${bill.showTimesResponseTime}',
                    ),
                    _DetailRow(
                      icon: Icons.room,
                      text: 'القاعة ${bill.showTimesResponseHall}',
                    ),

                    // Seats and Price
                    Row(
                      children: [
                        Chip(
                          backgroundColor:VariablesManager.isDark ? Colors.black : Colors.white ,
                          label: Text(
                            'مقاعد: ${bill.reserved_seats?.join(', ') ?? '--'}',
                            style: TextStyleManager.smallParagraphStyle(context),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '${bill.totalBill.toStringAsFixed(2)} ر.س',
                          style: TextStyleManager.titleStyle(context)?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),

                    // Payment Method and Date
                    Row(
                      children: [
                        _PaymentMethodIcon(bill.paymentType),
                        const Spacer(),
                        Text(
                          dateFormat.format(bill.reservationDate),
                          style: TextStyleManager.smallParagraphStyle(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 300.ms).slideX(begin: 0.1);
  }

  void _navigateToDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SecSimpleMovieTicket(bill: bill),
      ),
    );
  }
}



class _PaymentMethodIcon extends StatelessWidget {
  final String? paymentType;
  final double size;

  const _PaymentMethodIcon(this.paymentType, {this.size = 24});

  @override
  Widget build(BuildContext context) {
    final iconPath = _getPaymentIconPath(paymentType);
    if (iconPath == null) return const SizedBox.shrink();

    return SvgPicture.asset(
      iconPath,
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(
        Theme.of(context).colorScheme.onSurface,
        BlendMode.srcIn,
      ),
    );
  }

  String? _getPaymentIconPath(String? type) {
    switch (type?.toLowerCase()) {
      case 'paypal':
        return 'assets/icons/paypal.svg';
      case 'ideal':
        return 'assets/icons/ideal.svg';
      case 'revolut_pay':
        return 'assets/icons/revolut.svg';
      default:
        return null;
    }
  }
}

class _PaymentStatusIndicator extends StatelessWidget {
  final bool isRefunded;

  const _PaymentStatusIndicator({required this.isRefunded});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isRefunded ? Colors.redAccent : Colors.greenAccent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        isRefunded ? 'مُسترد' : 'نشط',
        style: TextStyleManager.smallParagraphStyle(context)?.copyWith(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _DetailRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey),
          const SizedBox(width: 8),
          Text(text, style: TextStyleManager.bodyStyle(context)),
        ],
      ),
    );
  }
}