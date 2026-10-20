import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../models/assets.gen.dart';

class ApolloWelcome extends StatelessWidget {
  final String version;
  final String buildNumber;

  const ApolloWelcome({
    super.key,
    required this.version,
    required this.buildNumber,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final artwork = theme.brightness == Brightness.dark
        ? Assets.images.apolloWelcomeDark
        : Assets.images.apolloWelcomeLight;

    return SingleChildScrollView(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: artwork.image(
                    fit: BoxFit.contain,
                    excludeFromSemantics: true,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  context.tr('apollo_welcome.title'),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  context.tr('apollo_welcome.subtitle'),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  context.tr('apollo_welcome.tagline'),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  context.tr(
                    'apollo_welcome.build_info',
                    namedArgs: {'version': version, 'build': buildNumber},
                  ),
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
