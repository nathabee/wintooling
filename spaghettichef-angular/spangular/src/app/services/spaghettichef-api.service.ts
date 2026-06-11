import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';

import { MonitoringResponse } from '../models/monitoring.model';
import { PrintersResponse } from '../models/printer.model';
import { MonitoringSettings } from '../models/settings.model';
import { environment } from '../../environments/environment';

@Injectable({
  providedIn: 'root'
})
export class SpaghettichefApiService {
  private readonly baseUrl = environment.spaghettichefApiBaseUrl.replace(/\/$/, '');

  constructor(private readonly http: HttpClient) {}

  getMonitoring(): Observable<MonitoringResponse> {
    return this.http.get<MonitoringResponse>(`${this.baseUrl}/monitoring`);
  }

  getPrinters(): Observable<PrintersResponse> {
    return this.http.get<PrintersResponse>(`${this.baseUrl}/printers`);
  }

  getMonitoringSettings(): Observable<MonitoringSettings> {
    return this.http.get<MonitoringSettings>(`${this.baseUrl}/settings/monitoring`);
  }
}
