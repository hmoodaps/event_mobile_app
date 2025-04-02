

// class DeepSeekLuxuryCinemaTicket extends StatefulWidget {
//   final double seatPrice;
//   final String? movieName;
//   final String? photo;
//   final String? showDate;
//   final String? showTime;
//   final String? hall;
//   final List<dynamic>? reservedSeats;
//   final String? reservationCode;
//
//   const DeepSeekLuxuryCinemaTicket({
//     super.key,
//     required this.seatPrice,
//     required this.movieName,
//     required this.photo,
//     this.showDate,
//     this.showTime,
//     this.hall,
//     required this.reservedSeats,
//     required this.reservationCode,
//   });
//
//   @override
//   State<DeepSeekLuxuryCinemaTicket> createState() => _LuxuryCinemaTicketState();
// }
//
// class _LuxuryCinemaTicketState extends State<DeepSeekLuxuryCinemaTicket> {
//   bool _isFlipped = false;
//   final double _ticketHeight = 400;
//   final double _ticketWidth = 300;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: GestureDetector(
//           onTap: () => setState(() => _isFlipped = !_isFlipped),
//           child: AnimatedSwitcher(
//             duration: const Duration(milliseconds: 800),
//             child: _isFlipped ? _buildBackSide() : _buildFrontSide(),
//             transitionBuilder: (child, animation) {
//               return RotationTransition(
//                 turns: Tween(begin: 0.0, end: 1.0).animate(animation),
//                 child: child,
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildFrontSide() {
//     return Container(
//       key: const ValueKey<bool>(false),
//       height: _ticketHeight,
//       width: _ticketWidth,
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           colors: [Colors.black87, Color(0xFF2A2A2A)],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.yellow.withOpacity(0.3),
//             blurRadius: 10,
//             spreadRadius: 3,
//           )
//         ],
//       ),
//       child: Stack(
//         children: [
//           // Movie Poster with overlay
//           Positioned.fill(
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(20),
//               child: ColorFiltered(
//                 colorFilter: ColorFilter.mode(
//                     Colors.black.withOpacity(0.4), BlendMode.darken),
//                 child: CachedNetworkImage(
//                   imageUrl: widget.photo ?? '',
//                   fit: BoxFit.cover,
//                   errorWidget: (_, __, ___) =>
//                       const Icon(Icons.movie_creation, size: 100),
//                 ),
//               ),
//             ),
//           ),
//
//           // Glossy effect
//           Positioned.fill(
//             child: Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [
//                     Colors.white.withOpacity(0.1),
//                     Colors.transparent,
//                   ],
//                 ),
//               ),
//             ),
//           ),
//
//           // Ticket Content
//           Padding(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildGoldenText(
//                   widget.movieName?.toUpperCase() ?? 'MOVIE TITLE',
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 const Spacer(),
//                 _buildInfoRow('Date', widget.showDate ?? 'N/A'),
//                 _buildInfoRow('Time', widget.showTime ?? 'N/A'),
//                 _buildInfoRow('Hall', widget.hall ?? 'N/A'),
//                 const SizedBox(height: 20),
//                 _buildGoldenText(
//                   'SEATS: ${widget.reservedSeats?.join(', ') ?? 'N/A'}',
//                   fontSize: 16,
//                 ),
//                 const Spacer(),
//                 _buildPriceTag(),
//               ],
//             ),
//           ),
//
//           // Tear line effect
//           ..._buildTearLines(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildBackSide() {
//     return Container(
//       key: const ValueKey<bool>(true),
//       height: _ticketHeight,
//       width: _ticketWidth,
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           colors: [Color(0xFF1A1A1A), Colors.black],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.yellow.withOpacity(0.3),
//             blurRadius: 10,
//             spreadRadius: 3,
//           )
//         ],
//       ),
//       child: Stack(
//         children: [
//           // Holographic effect
//           Positioned.fill(
//             child: Opacity(
//               opacity: 0.1,
//               child: Container(
//                 decoration: const BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage('assets/images/holographic_pattern.png'),
//                     fit: BoxFit.fill,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//
//           Padding(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               children: [
//                 QrImageView(
//                   data: widget.reservationCode ?? 'ERROR',
//                   version: QrVersions.auto,
//                   size: 150,
//                   foregroundColor: Colors.amber,
//                   embeddedImage: const AssetImage(AssetsManager.cinemaAsset),
//                 ),
//                 const SizedBox(height: 20),
//                 _buildGoldenText(
//                   'RESERVATION CODE',
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 _buildGoldenText(
//                   widget.reservationCode ?? 'XXXX-XXXX',
//                   fontSize: 22,
//                 ),
//                 const Divider(color: Colors.amber),
//                 _buildGoldenText(
//                   'VIP ACCESS CARD',
//                   fontSize: 16,
//                   letterSpacing: 1.5,
//                 ),
//                 const SizedBox(height: 10),
//                 _buildSecurityFeatures(),
//               ],
//             ),
//           ),
//
//           ..._buildTearLines(),
//         ],
//       ),
//     );
//   }
//
//   // Helper Widgets
//   Widget _buildGoldenText(
//     String text, {
//     double fontSize = 14,
//     FontWeight fontWeight = FontWeight.normal,
//     double letterSpacing = 1.0,
//   }) {
//     return Text(text,
//         style: TextStyle(
//           fontSize: fontSize,
//           fontWeight: fontWeight,
//           letterSpacing: letterSpacing,
//           foreground: Paint()
//             ..shader = const LinearGradient(
//               colors: [Color(0xFFFFD700), Color(0xFFD4AF37)],
//             ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
//         ));
//   }
//
//   Widget _buildInfoRow(String title, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: Row(
//         children: [
//           Icon(Icons.info_outline, color: Colors.amber, size: 16),
//           const SizedBox(width: 10),
//           _buildGoldenText('$title: ', fontSize: 14),
//           _buildGoldenText(value, fontSize: 14, fontWeight: FontWeight.bold),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildPriceTag() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//       decoration: BoxDecoration(
//         color: Colors.black.withOpacity(0.5),
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: Colors.amber, width: 1),
//       ),
//       child: _buildGoldenText(
//         'TOTAL: \$${widget.seatPrice.toStringAsFixed(2)}',
//         fontSize: 18,
//         fontWeight: FontWeight.bold,
//       ),
//     );
//   }
//
//   Widget _buildSecurityFeatures() {
//     return Wrap(
//       spacing: 10,
//       children: [
//         Icon(Icons.verified_user, color: Colors.amber, size: 16),
//         _buildGoldenText('• HOLOGRAM •', fontSize: 12),
//         Icon(Icons.fingerprint, color: Colors.amber, size: 16),
//         _buildGoldenText('• RFID SECURE •', fontSize: 12),
//       ],
//     );
//   }
//
//   List<Widget> _buildTearLines() {
//     return [
//       Positioned(
//         top: -5,
//         left: 20,
//         right: 20,
//         child: CustomPaint(
//           painter: _TicketTearLinePainter(),
//           size: const Size(double.infinity, 10),
//         ),
//       ),
//       Positioned(
//         bottom: -5,
//         left: 20,
//         right: 20,
//         child: CustomPaint(
//           painter: _TicketTearLinePainter(),
//           size: const Size(double.infinity, 10),
//         ),
//       ),
//     ];
//   }
// }
//
// class _TicketTearLinePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.amber
//       ..strokeWidth = 2
//       ..style = PaintingStyle.stroke;
//
//     final path = Path();
//     const dashWidth = 8.0;
//     const dashSpace = 6.0;
//
//     double startX = 0;
//     while (startX < size.width) {
//       path.moveTo(startX, 0);
//       path.relativeLineTo(dashWidth , 0);
//       startX += dashWidth + dashSpace;
//     }
//
//     canvas.drawPath(path, paint);
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
// }




