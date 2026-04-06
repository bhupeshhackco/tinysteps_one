import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tinysteps/core/constants/app_theme.dart';

class MyClassroomScreen extends StatefulWidget {
  const MyClassroomScreen({super.key});

  @override
  State<MyClassroomScreen> createState() => _MyClassroomScreenState();
}

class _MyClassroomScreenState extends State<MyClassroomScreen> {
  final _supabase = Supabase.instance.client;
  late Future<List<Map<String, dynamic>>> _future;

  @override
  void initState() {
    super.initState();
    _future = _fetchClassrooms();
  }

  Future<List<Map<String, dynamic>>> _fetchClassrooms() async {
    final uid = _supabase.auth.currentUser?.id;
    if (uid == null) return [];
    
    final classrooms = await _supabase
        .from('classrooms')
        .select('*')
        .eq('teacher_id', uid)
        .order('name');
        
    return List<Map<String, dynamic>>.from(classrooms);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        title: Text('Classroom Settings', style: AppTextStyles.heading2),
        backgroundColor: AppColors.bgLight,
        elevation: 0,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primary));
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Could not load classroom data.\n${snapshot.error}',
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyMuted,
              ),
            );
          }
          
          final classrooms = snapshot.data ?? [];
          
          if (classrooms.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.xxl),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.meeting_room_outlined, size: 80, color: AppColors.primary.withValues(alpha: 0.3)),
                    const SizedBox(height: AppSpacing.md),
                    Text('No Classroom Assigned', style: AppTextStyles.heading2),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'You have not been assigned a classroom by the administrator yet.',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.bodyMuted,
                    )
                  ],
                ),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(AppSpacing.lg),
            itemCount: classrooms.length,
            separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.lg),
            itemBuilder: (context, index) {
              final c = classrooms[index];
              return _buildClassroomCard(c);
            },
          );
        },
      ),
    );
  }

  Widget _buildClassroomCard(Map<String, dynamic> data) {
    final name = data['name'] as String? ?? 'Unnamed Classroom';
    final ageRange = data['age_range'] as String? ?? 'N/A';
    final capacity = data['capacity']?.toString() ?? 'N/A';

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.border),
        boxShadow: AppShadows.soft,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: const BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
            ),
            child: Row(
              children: [
                const Icon(Icons.school_rounded, color: AppColors.primary),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(name, style: AppTextStyles.heading3.copyWith(color: AppColors.primaryDark)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow(Icons.escalator_warning_rounded, 'Age Range', ageRange),
                const SizedBox(height: AppSpacing.md),
                _buildInfoRow(Icons.groups_rounded, 'Capacity Limit', capacity),
                
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
                  child: Divider(),
                ),
                
                OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Roster report generation coming soon!')),
                    );
                  },
                  icon: const Icon(Icons.download_rounded),
                  label: const Text('Download Roster Report'),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.textMuted),
        const SizedBox(width: AppSpacing.sm),
        Text('$label:', style: AppTextStyles.bodyMuted),
        const SizedBox(width: AppSpacing.sm),
        Text(value, style: AppTextStyles.labelBold),
      ],
    );
  }
}