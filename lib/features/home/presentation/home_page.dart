import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../providers/auth_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  final List<Map<String, dynamic>> menuItems = const [
    {'icon': Icons.people, 'label': 'Data Pelanggan','key': '/customer'},
    {'icon': Icons.article, 'label': 'Berita','key': '/news'},
    {'icon': Icons.receipt, 'label': 'Tagihan','key': '/receipts'},
    {'icon': Icons.notifications, 'label': 'Notification','key': '/notifications'},
    {'icon': Icons.more_horiz, 'label': 'Lain-lain','key': '/more'},
    {'icon': Icons.person, 'label': 'Profile','key': '/profile'},
    {'icon': Icons.settings, 'label': 'Settings','key': 'settings'},
    {'icon': Icons.help_outline, 'label': 'Help','key': '/help'},
    {'icon': Icons.info, 'label': 'About','key': '/info'},
  ];

  final List<Map<String, String>> beritaList = const [
    {
      'judul': 'Pemadaman Listrik Terjadwal',
      'tanggal': '21 Juli 2025',
      'ringkasan': 'Pemadaman listrik akan dilakukan pada 23 Juli 2025 dari jam 08.00 sampai 12.00.'
    },
    {
      'judul': 'Peningkatan Layanan Pelanggan',
      'tanggal': '20 Juli 2025',
      'ringkasan': 'Kami terus berupaya meningkatkan kualitas layanan pelanggan untuk kenyamanan Anda.'
    },
    {
      'judul': 'Pengumuman Tarif Baru',
      'tanggal': '19 Juli 2025',
      'ringkasan': 'Mulai 1 Agustus 2025, tarif listrik akan mengalami penyesuaian sesuai regulasi terbaru.'
    },
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(authProvider.notifier).logout();
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Grid Menu 3x3
            Expanded(
              flex: 4,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(), // supaya gak bisa scroll grid
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.9,
                ),
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  final item = menuItems[index];
                  return ElevatedButton(
                    onPressed: () {
                       context.push('${item['key']}'); 
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(content: Text('Clicked: ${item['label']}')),
                      // );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(12), backgroundColor: Colors.blue.shade700,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          item['icon'] as IconData,
                          size: 36,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 8),
                        Flexible(
                          child: Text(
                            item['label'] as String,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // Judul Berita
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Berita Terbaru',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 12),

            // List Berita (Scroll)
            Expanded(
              flex: 3,
              child: ListView.separated(
                itemCount: beritaList.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final berita = beritaList[index];
                  return ListTile(
                    title: Text(
                      berita['judul'] ?? '',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          berita['tanggal'] ?? '',
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          berita['ringkasan'] ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    leading: const Icon(Icons.article_outlined),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Buka berita: ${berita['judul']}')),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
