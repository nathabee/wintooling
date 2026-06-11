import { AsyncPipe } from '@angular/common';
import { Component } from '@angular/core';
import { catchError, Observable, of } from 'rxjs';

import { MonitoringSettings } from '../../models/settings.model';
import { SpaghettichefApiService } from '../../services/spaghettichef-api.service';

@Component({
  selector: 'app-settings',
  imports: [AsyncPipe],
  templateUrl: './settings.component.html',
  styleUrl: './settings.component.css'
})
export class SettingsComponent {
  errorMessage = '';
  settings$: Observable<MonitoringSettings | null>;

  constructor(private readonly api: SpaghettichefApiService) {
    this.settings$ = this.api.getMonitoringSettings().pipe(
      catchError(() => {
        this.errorMessage = 'Could not load settings from http://localhost:18080/settings/monitoring.';
        return of(null);
      })
    );
  }
}
