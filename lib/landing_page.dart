import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.orange.shade700,
              Colors.white,
              Colors.green.shade700,
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Header with Emblem
                _buildHeader(),

                const SizedBox(height: 30),

                // Company Details Card
                _buildCompanyDetailsCard(),

                const SizedBox(height: 40),

                // Login Options
                _buildLoginOptions(context),

                const SizedBox(height: 40),

                // Developed By Section
                _buildDevelopedBy(),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Ashoka Emblem Style Icon
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.orange.shade800, width: 3),
              color: Colors.white,
            ),
            child: Icon(
              Icons.account_balance,
              size: 60,
              color: Colors.orange.shade800,
            ),
          ).animate().scale(duration: 600.ms, curve: Curves.easeOutBack),

          const SizedBox(height: 15),

          // Title
          // Text(
          //   'A One Infotech',
          //   style: GoogleFonts.tiroDevanagariHindi(
          //     fontSize: 24,
          //     fontWeight: FontWeight.bold,
          //     color: Colors.orange.shade900,
          //   ),
          // ).animate().fadeIn(delay: 200.ms),
          //
          // const SizedBox(height: 5),

          Text(
            'GOVERNMENT APPROVED',
            style: GoogleFonts.cinzel(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.orange.shade900,
              letterSpacing: 1.5,
            ),
          ).animate().fadeIn(delay: 300.ms),

          const SizedBox(height: 20),

          // Main Title
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.blue.shade900,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'A One Infotech',
              style: GoogleFonts.tiroDevanagariHindi(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ).animate().fadeIn(delay: 400.ms).slideY(begin: -0.2, end: 0),

          const SizedBox(height: 8),

          Text(
            'SAND MINING MANAGEMENT SYSTEM',
            style: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.blue.shade900,
              letterSpacing: 1.2,
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 500.ms),

          const SizedBox(height: 15),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.green.shade700,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.verified, color: Colors.white, size: 16),
                const SizedBox(width: 8),
                Text(
                  'Challan Management Portal',
                  style: GoogleFonts.tiroDevanagariHindi(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(delay: 600.ms).scale(),
        ],
      ),
    );
  }

  Widget _buildCompanyDetailsCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.orange.shade300, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          // Company Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.business,
                  color: Colors.orange.shade800,
                  size: 30,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'A One Infotech',
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900,
                      ),
                    ),
                    Text(
                      'Digital Solutions Partner',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          const Divider(thickness: 1),

          const SizedBox(height: 20),

          // Company Details
          _buildDetailRow(Icons.location_on, 'Address',
              'A one infotech, koilwar jamalpur, 802160,India'),
          // const SizedBox(height: 12),
          // _buildDetailRow(Icons.phone, 'Contact', '+91 XXXXX XXXXX'),
          const SizedBox(height: 12),
          _buildDetailRow(Icons.email, 'Email', 'info@aoneinfotech.com'),
          const SizedBox(height: 12),
          _buildDetailRow(Icons.language, 'Website', 'www.aoneinfotech.com'),

          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Colors.blue.shade700),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Authorized Sand Mining Challan Management System',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.blue.shade900,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 700.ms).slideY(begin: 0.2, end: 0);
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.orange.shade700),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLoginOptions(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Text(
            'Select Login Option',
            style: GoogleFonts.tiroDevanagariHindi(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade900,
            ),
          ).animate().fadeIn(delay: 800.ms),

          // const SizedBox(height: 5),
          //
          // Text(
          //   'Select Login Option',
          //   style: GoogleFonts.poppins(
          //     fontSize: 14,
          //     color: Colors.grey.shade700,
          //   ),
          // ).animate().fadeIn(delay: 900.ms),

          const SizedBox(height: 25),

          // Super Admin Login
          _buildLoginCard(
            context,
            icon: Icons.admin_panel_settings,
            title: 'Super Admin',
            subtitle: 'Full System Access',
            color: Colors.red.shade700,
            gradientColors: [Colors.red.shade700, Colors.red.shade900],
            delay: 1000,
            route: '/login/superadmin',
          ),

          const SizedBox(height: 15),

          // Admin Login
          _buildLoginCard(
            context,
            icon: Icons.manage_accounts,
            title: 'Admin',
            subtitle: 'Administrative Access',
            color: Colors.blue.shade700,
            gradientColors: [Colors.blue.shade700, Colors.blue.shade900],
            delay: 1100,
            route: '/login/admin',
          ),

          const SizedBox(height: 15),

          // Operator Login
          _buildLoginCard(
            context,
            icon: Icons.person,
            title: 'Operator',
            subtitle: 'Challan Management',
            color: Colors.green.shade700,
            gradientColors: [Colors.green.shade700, Colors.green.shade900],
            delay: 1200,
            route: '/login/operator',
          ),
        ],
      ),
    );
  }

  Widget _buildLoginCard(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String subtitle,
        required Color color,
        required List<Color> gradientColors,
        required int delay,
        required String route,
      }) {
    return InkWell(
      onTap: () {
        Get.toNamed(route);
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.4),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, size: 35, color: Colors.white),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 20,
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: delay.ms).slideX(begin: 0.3, end: 0);
  }

  Widget _buildDevelopedBy() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Text(
            'Developed By',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildDeveloperCard('Kunal', Colors.blue),
              Container(
                height: 50,
                width: 1,
                color: Colors.grey.shade300,
              ),
              _buildDeveloperCard('Vivek Kumar', Colors.orange),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(delay: 1300.ms).slideY(begin: 0.2, end: 0);
  }

  Widget _buildDeveloperCard(String name, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.code, color: color, size: 28),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}