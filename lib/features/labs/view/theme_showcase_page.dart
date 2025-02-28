import 'package:flutter/material.dart';
import '../../../core/style/style.dart';

class ThemeShowcasePage extends StatelessWidget {
  const ThemeShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cyberpunk Theme Showcase'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              context,
              title: 'Color Palette',
              child: _buildColorPalette(),
            ),
            const SizedBox(height: AppSpacing.lg),
            _buildSection(
              context,
              title: 'Typography',
              child: _buildTypography(context),
            ),
            const SizedBox(height: AppSpacing.lg),
            _buildSection(
              context,
              title: 'Buttons',
              child: _buildButtons(),
            ),
            const SizedBox(height: AppSpacing.lg),
            _buildSection(
              context,
              title: 'Cards',
              child: _buildCards(),
            ),
            const SizedBox(height: AppSpacing.lg),
            _buildSection(
              context,
              title: 'Form Elements',
              child: _buildFormElements(),
            ),
            const SizedBox(height: AppSpacing.lg),
            _buildSection(
              context,
              title: 'Gradients',
              child: _buildGradients(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context,
      {required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const Divider(),
        const SizedBox(height: AppSpacing.md),
        child,
      ],
    );
  }

  Widget _buildColorPalette() {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: [
        _colorTile('Neon Blue', AppColors.neonBlue),
        _colorTile('Cyberpunk Purple', AppColors.cyberpunkPurple),
        _colorTile('Midnight Blue', AppColors.midnightBlue),
        _colorTile('Tech Navy', AppColors.techNavy),
        _colorTile('Night Shade', AppColors.nightShade),
        _colorTile('Neon Aqua', AppColors.neonAqua),
        _colorTile('Synthetic Indigo', AppColors.syntheticIndigo),
        _colorTile('Cyborg Purple', AppColors.cyborgPurple),
        _colorTile('Digital Teal', AppColors.digitalTeal),
        _colorTile('Laser Amber', AppColors.laserAmber),
      ],
    );
  }

  Widget _colorTile(String name, Color color) {
    return Column(
      children: [
        Container(
          height: 60,
          width: 100,
          decoration: BoxDecoration(
            color: color,
            borderRadius: AppBorders.roundedSmall,
            boxShadow: AppShadows.subtle,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          name,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildTypography(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Display Large', style: textTheme.displayLarge),
        Text('Display Medium', style: textTheme.displayMedium),
        Text('Display Small', style: textTheme.displaySmall),
        Text('Headline Large', style: textTheme.headlineLarge),
        Text('Headline Medium', style: textTheme.headlineMedium),
        Text('Headline Small', style: textTheme.headlineSmall),
        Text('Title Large', style: textTheme.titleLarge),
        Text('Title Medium', style: textTheme.titleMedium),
        Text('Title Small', style: textTheme.titleSmall),
        Text('Body Large', style: textTheme.bodyLarge),
        Text('Body Medium', style: textTheme.bodyMedium),
        Text('Body Small', style: textTheme.bodySmall),
        Text('Label Large', style: textTheme.labelLarge),
        Text('Label Medium', style: textTheme.labelMedium),
        Text('Label Small', style: textTheme.labelSmall),
      ],
    );
  }

  Widget _buildButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: AppSpacing.md,
          runSpacing: AppSpacing.md,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: const Text('Elevated Button'),
            ),
            OutlinedButton(
              onPressed: () {},
              child: const Text('Outlined Button'),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Text Button'),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: AppSpacing.md,
          runSpacing: AppSpacing.md,
          children: [
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.bolt),
              label: const Text('With Icon'),
            ),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.science),
              label: const Text('With Icon'),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.hub),
              label: const Text('With Icon'),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Container(
          width: 200,
          decoration: BoxDecoration(
            gradient: AppGradients.neonDream,
            borderRadius: AppBorders.roundedSmall,
            boxShadow: AppShadows.neonGlow,
          ),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              padding: const EdgeInsets.symmetric(
                vertical: AppSpacing.sm,
              ),
            ),
            child: const Text('Gradient Button'),
          ),
        ),
      ],
    );
  }

  Widget _buildCards() {
    return Wrap(
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.md,
      children: [
        const SizedBox(
          width: 200,
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Basic Card',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.hologramWhite,
                    ),
                  ),
                  SizedBox(height: AppSpacing.sm),
                  Text(
                    'This is a basic card with some content inside.',
                    style: TextStyle(color: AppColors.matrixSilver),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: 200,
          child: Card(
            elevation: 8,
            shadowColor: AppColors.neonAqua.withOpacity(0.3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                  decoration: const BoxDecoration(
                    gradient: AppGradients.synthwaveEnergy,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.memory,
                      size: 40,
                      color: AppColors.hologramWhite,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Gradient Card',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.hologramWhite,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      const Text(
                        'This card has a cyberpunk-style gradient header.',
                        style: TextStyle(color: AppColors.matrixSilver),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Learn More'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 200,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: AppBorders.angledBorder,
              side: BorderSide(
                color: AppColors.neonAqua.withOpacity(0.5),
                width: 1.5,
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Angled Border',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.hologramWhite,
                    ),
                  ),
                  SizedBox(height: AppSpacing.sm),
                  Text(
                    'This card has an asymmetrical border for a cyber look.',
                    style: TextStyle(color: AppColors.matrixSilver),
                  ),
                  SizedBox(height: AppSpacing.md),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.chevron_right, color: AppColors.neonAqua),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFormElements() {
    return Column(
      children: [
        const TextField(
          decoration: InputDecoration(
            labelText: 'Text Field',
            hintText: 'Enter text here',
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Password Field',
            hintText: 'Enter password',
            prefixIcon: Icon(Icons.lock_outline),
            suffixIcon: Icon(Icons.visibility_off),
          ),
          obscureText: true,
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Checkbox(
              value: true,
              onChanged: (_) {},
            ),
            const Text('Enable notifications'),
          ],
        ),
        Row(
          children: [
            Switch(
              value: true,
              onChanged: (_) {},
            ),
            const Text('Dark mode'),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Radio(
              value: 1,
              groupValue: 1,
              onChanged: (_) {},
            ),
            const Text('Option 1'),
            const SizedBox(width: AppSpacing.md),
            Radio(
              value: 2,
              groupValue: 1,
              onChanged: (_) {},
            ),
            const Text('Option 2'),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        const Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            Chip(
              label: Text('Cyberpunk'),
              avatar: Icon(Icons.auto_awesome, color: AppColors.neonAqua),
            ),
            Chip(
              label: Text('Neural'),
              avatar: Icon(Icons.psychology, color: AppColors.cyborgPurple),
            ),
            Chip(
              label: Text('Digital'),
              avatar: Icon(Icons.memory, color: AppColors.digitalTeal),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGradients() {
    return Column(
      children: [
        _gradientTile('Cyber Horizon', AppGradients.cyberHorizon),
        const SizedBox(height: AppSpacing.md),
        _gradientTile('Neuro Portal', AppGradients.neuroPortal),
        const SizedBox(height: AppSpacing.md),
        _gradientTile('Synthwave Energy', AppGradients.synthwaveEnergy),
        const SizedBox(height: AppSpacing.md),
        _gradientTile('Neon Dream', AppGradients.neonDream),
      ],
    );
  }

  Widget _gradientTile(String name, Gradient gradient) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name),
        const SizedBox(height: AppSpacing.xs),
        Container(
          height: 60,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: AppBorders.roundedMedium,
            boxShadow: AppShadows.subtle,
          ),
        ),
      ],
    );
  }
}
