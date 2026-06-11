export interface MonitoringSettings {
  pollIntervalSeconds: number;
  snapshotMinimumIntervalSeconds: number;
  temperatureDeltaThreshold: number;
  eventDeduplicationWindowSeconds: number;
  errorPersistenceBehavior: string;
  debugWireTracingEnabled: boolean;
}
