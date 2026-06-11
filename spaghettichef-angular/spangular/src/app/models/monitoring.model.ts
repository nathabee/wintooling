export interface MonitoringResponse {
  generatedAt: string;
  summary: MonitoringSummary;
  printers: MonitoringPrinter[];
  activeJobs: unknown[];
  activeUploads: unknown[];
}

export interface MonitoringSummary {
  totalPrinters: number;
  enabledPrinters: number;
  disabledPrinters: number;
  busyPrinters: number;
  errorPrinters: number;
  activeJobs: number;
  activeUploads: number;
}

export interface MonitoringPrinter {
  id: string;
  displayName: string;
  name: string;
  portName: string;
  mode: string;
  serialPortKind: string | null;
  stableSerialPath: boolean;
  serialPathWarning: string | null;
  enabled: boolean;
  state: string;
  busy: boolean;
  activeJobId: string | null;
  errorMessage: string | null;
  serialFailureType: string | null;
  updatedAt: string | null;
}
