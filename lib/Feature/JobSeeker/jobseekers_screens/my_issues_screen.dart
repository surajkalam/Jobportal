// screens/my_issues_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobapp/Feature/JobSeeker/modelclass/issue_report_model.dart';
import 'package:jobapp/Feature/JobSeeker/provider/jobaccess_provider.dart';
import 'package:jobapp/Feature/JobSeeker/provider/jobseeker_provider.dart';

class MyIssuesScreen extends ConsumerWidget {
  const MyIssuesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final jobseekerState = ref.watch(jobseekerProvider);
    final jobseekerInfo = jobseekerState.jobseekerInfo;

    if (jobseekerInfo == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('My Issues & Reports'),
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
        ),
        body: const Center(
          child: Text('Please complete your profile to view your issues'),
        ),
      );
    }

    final issuesAsync = ref.watch(StreamProvider<List<IssueReport>>((ref) {
      final repository = ref.read(jobRepositoryProvider);
      return repository.getJobseekerIssues(jobseekerInfo.email);
    }));

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Issues & Reports'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.invalidate(StreamProvider<List<IssueReport>>((ref) {
                final repository = ref.read(jobRepositoryProvider);
                return repository.getJobseekerIssues(jobseekerInfo.email);
              }));
            },
          ),
        ],
      ),
      body: issuesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
        data: (issues) {
          if (issues.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inbox, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('No issues or reports submitted yet'),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: issues.length,
            itemBuilder: (context, index) {
              final issue = issues[index];
              return IssueReportCard(issue: issue);
            },
          );
        },
      ),
    );
  }
}

class IssueReportCard extends StatelessWidget {
  final IssueReport issue;

  const IssueReportCard({super.key, required this.issue});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    Color statusColor = Colors.orange;
    if (issue.status == 'in_progress') statusColor = Colors.blue;
    if (issue.status == 'resolved') statusColor = Colors.green;

    Color typeColor = issue.type == 'issue' ? Colors.orange : Colors.red;
    IconData typeIcon = issue.type == 'issue' ? Icons.warning : Icons.report_problem;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: typeColor.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(typeIcon, color: typeColor, size: 16),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    issue.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Chip(
                  label: Text(
                    issue.status.replaceAll('_', ' ').toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: statusColor,
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              issue.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.access_time, size: 14, color: colorScheme.onSurfaceVariant),
                const SizedBox(width: 4),
                Text(
                  _timeAgo(issue.createdAt),
                  style: TextStyle(
                    fontSize: 12,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const Spacer(),
                Text(
                  issue.type.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: typeColor,
                  ),
                ),
              ],
            ),
            // Show admin response if available
            if (issue.adminResponse != null) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: statusColor.withOpacity(0.3), width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          statusColor == Colors.green ? Icons.check_circle : Icons.info,
                          size: 16,
                          color: statusColor,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Admin Response',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: statusColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      issue.adminResponse!,
                      style: TextStyle(
                        fontSize: 13,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _timeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) return '${difference.inDays}d ago';
    if (difference.inHours > 0) return '${difference.inHours}h ago';
    if (difference.inMinutes > 0) return '${difference.inMinutes}m ago';
    return 'Just now';
  }
}
