import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: ChurchERPApp()));
}

class ChurchERPApp extends StatelessWidget {
  const ChurchERPApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ERP Igreja Angola',
      debugShowCheckedModeBanner: false,

      // Tema moderno e premium usando FlexColorScheme
      theme: FlexThemeData.light(
        scheme: FlexScheme.deepBlue,
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 7,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 10,
          blendOnColors: false,
          useTextTheme: true,
          useM2StyleDividerInM3: true,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        fontFamily: GoogleFonts.outfit().fontFamily,
      ),
      darkTheme: FlexThemeData.dark(
        scheme: FlexScheme.deepBlue,
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 13,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 20,
          useTextTheme: true,
          useM2StyleDividerInM3: true,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        fontFamily: GoogleFonts.outfit().fontFamily,
      ),
      themeMode: ThemeMode.system,
      home: const MainDashboard(),
    );
  }
}

class MainDashboard extends ConsumerWidget {
  const MainDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Painel de Gestão'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
          IconButton(icon: const Icon(Icons.person_outline), onPressed: () {}),
        ],
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bem-vindo à sua organização',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildStatCards(),
            const SizedBox(height: 24),
            _buildQuickActions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCards() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.5,
      children: [
        _StatCard(
          title: 'Membros',
          value: '1,240',
          icon: Icons.people,
          color: Colors.blue,
        ),
        _StatCard(
          title: 'Dízimos (Mês)',
          value: '450k Kz',
          icon: Icons.account_balance_wallet,
          color: Colors.green,
        ),
        _StatCard(
          title: 'Ofertas (Mês)',
          value: '120k Kz',
          icon: Icons.volunteer_activism,
          color: Colors.orange,
        ),
        _StatCard(
          title: 'Presenças',
          value: '85%',
          icon: Icons.event_available,
          color: Colors.purple,
        ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Ações Rápidas',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ListTile(
          leading: const CircleAvatar(child: Icon(Icons.person_add)),
          title: const Text('Registar Novo Membro'),
          subtitle: const Text('Adicione um novo fiel à base de dados'),
          onTap: () {},
        ),
        ListTile(
          leading: const CircleAvatar(child: Icon(Icons.add_chart)),
          title: const Text('Lançar Dízimo/Oferta'),
          subtitle: const Text('Registe uma nova entrada financeira'),
          onTap: () {},
        ),
        ListTile(
          leading: const CircleAvatar(child: Icon(Icons.message_outlined)),
          title: const Text('Enviar Comunicado WhatsApp'),
          subtitle: const Text('Comunicação em massa para grupos'),
          onTap: () {},
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: color.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              title,
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text('Igreja Central de Luanda'),
            accountEmail: Text('admin@igreja.ao'),
            currentAccountPicture: CircleAvatar(child: Icon(Icons.church)),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Painel'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Secretaria / Membros'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.payments),
            title: const Text('Financeiro'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.calendar_month),
            title: const Text('Eventos e Cultos'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.campaign),
            title: const Text('Comunicação'),
            onTap: () {},
          ),
          const Spacer(),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configurações'),
            onTap: () {},
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
