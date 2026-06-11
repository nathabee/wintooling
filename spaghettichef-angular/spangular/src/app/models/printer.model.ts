export interface PrintersResponse {
  printers: Printer[];
}

export interface Printer {
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
  hotendTemperature: number | null;
  bedTemperature: number | null;
  lastResponse: string | null;
  errorMessage: string | null;
  serialFailureType: string | null;
  updatedAt: string | null;
}
