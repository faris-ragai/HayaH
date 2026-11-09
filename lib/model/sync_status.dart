enum SyncStatus { offline, pending, synced, conflict }

extension SyncStatusLabel on SyncStatus {
  String get label {
    switch (this) {
      case SyncStatus.offline:
        return 'Offline';
      case SyncStatus.pending:
        return 'Pending';
      case SyncStatus.synced:
        return 'Synced';
      case SyncStatus.conflict:
        return 'Conflict';
    }
  }
}
