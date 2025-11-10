import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/layouts/app_scaffold.dart';
import '../../data/models/storage_models.dart';
import '../providers/pantry_provider.dart';
import '../../../../core/layouts/android/float_add_button.dart';
import '../../data/repositories/pantry_repository.dart';
import '../widgets/small_storage_card.dart';
import '../widgets/freezer_card.dart';

class PantryScreen extends ConsumerWidget {
  const PantryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncStorages = ref.watch(pantryProvider);

    Future<void> onAddStorage() async {
      final nameCtrl = TextEditingController();
      StorageType selected = StorageType.pantry;
      final repo = PantryRepository();
      final ok = await showDialog<bool>(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text('Add Storage'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                  ),
                ),
                const SizedBox(height: 12),
                StatefulBuilder(
                  builder: (ctx, setState) {
                    return DropdownButton<StorageType>(
                      value: selected,
                      items: const [
                        DropdownMenuItem(
                          value: StorageType.pantry,
                          child: Text('Pantry'),
                        ),
                        DropdownMenuItem(
                          value: StorageType.fridge,
                          child: Text('Fridge'),
                        ),
                        DropdownMenuItem(
                          value: StorageType.freezer,
                          child: Text('Freezer'),
                        ),
                      ],
                      onChanged: (v) {
                        if (v != null) {
                          setState(() => selected = v);
                        }
                      },
                    );
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(true),
                child: const Text('Add'),
              ),
            ],
          );
        },
      );
      if (ok == true && nameCtrl.text.trim().isNotEmpty) {
        await repo.createStorage(
          name: nameCtrl.text.trim(),
          type: selected,
        );
        if (context.mounted) {
          await ref.read(pantryProvider.notifier).refresh();
        }
      }
    }

    return AppScaffold(
      title: 'Pantry',
      body: asyncStorages.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Failed to load pantry items'),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => ref.read(pantryProvider.notifier).refresh(),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (storages) {
          if (storages.isEmpty) {
            return Stack(
              children: [
                const Center(child: Text('No storages found')),
                FloatingAddButton.defaultPositioned(
                  right: 0,
                  bottom: 30,
                  items: [
                    FabMenuItem(
                      label: 'Add Storage',
                      icon: Icons.add_circle,
                      onTap: onAddStorage,
                    ),
                  ],
                ),
              ],
            );
          }
          final freezer = storages
              .where((s) => s.type == StorageType.freezer)
              .toList();
          final pantryItems = storages
              .where((s) => s.type == StorageType.pantry)
              .toList();
          final fridgeItems = storages
              .where((s) => s.type == StorageType.fridge)
              .toList();

          return Stack(
            children: [
              ListView(
                padding: EdgeInsets.zero,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).padding.top +
                        kToolbarHeight,
                  ),
                  if (pantryItems.isNotEmpty) ...[
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        'Pantry',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          fontFamily: 'MomoTrustDisplay',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 120,
                      child: PageView.builder(
                        controller: PageController(viewportFraction: 0.92),
                        padEnds: false,
                        itemCount: (pantryItems.length / 2).ceil(),
                        itemBuilder: (context, pageIndex) {
                          final start = pageIndex * 2;
                          final end = (start + 2).clamp(0, pantryItems.length);
                          final pageItems = pantryItems.sublist(start, end);
                          return Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Row(
                              children: [
                                Expanded(
                                  child: SmallStorageCard(
                                    storage: pageItems[0],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: pageItems.length > 1
                                      ? SmallStorageCard(
                                          storage: pageItems[1],
                                        )
                                      : const SizedBox.shrink(),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),

                  ],
                  if (fridgeItems.isNotEmpty) ...[
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        'Fridge',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          fontFamily: 'MomoTrustDisplay',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 120,
                      child: PageView.builder(
                        controller: PageController(viewportFraction: 0.92),
                        padEnds: false,
                        itemCount: (fridgeItems.length / 2).ceil(),
                        itemBuilder: (context, pageIndex) {
                          final start = pageIndex * 2;
                          final end = (start + 2).clamp(0, fridgeItems.length);
                          final pageItems = fridgeItems.sublist(start, end);
                          return Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Row(
                              children: [
                                Expanded(
                                  child: SmallStorageCard(
                                    storage: pageItems[0],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: pageItems.length > 1
                                      ? SmallStorageCard(
                                          storage: pageItems[1],
                                        )
                                      : const SizedBox.shrink(),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                  if (freezer.isNotEmpty) ...[
                    SizedBox(
                      height: 120,
                      child: PageView.builder(
                        controller: PageController(viewportFraction: 0.9),
                        padEnds: false,
                        itemCount: freezer.length,
                        itemBuilder: (context, index) {
                          final storage = freezer[index];
                          return Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: FreezerCard(storage: storage),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                  const SizedBox(height: 80),
                ],
              ),
              FloatingAddButton.defaultPositioned(
                items: [
                  FabMenuItem(
                    label: 'Add Storage',
                    icon: Icons.add_circle,
                    onTap: onAddStorage,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
