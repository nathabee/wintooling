import { AsyncPipe, DatePipe } from '@angular/common';
import { Component } from '@angular/core';
import { catchError, Observable, of } from 'rxjs';

import { MonitoringResponse } from '../../models/monitoring.model';
import { SpaghettichefApiService } from '../../services/spaghettichef-api.service';

@Component({
  selector: 'app-dashboard',
  imports: [AsyncPipe, DatePipe],
  templateUrl: './dashboard.component.html',
  styleUrl: './dashboard.component.css'
})
export class DashboardComponent {
  errorMessage = '';
  monitoring$: Observable<MonitoringResponse | null>;

  constructor(private readonly api: SpaghettichefApiService) {
    this.monitoring$ = this.api.getMonitoring().pipe(
      catchError(() => {
        this.errorMessage = 'Could not load monitoring data from http://localhost:18080/monitoring.';
        return of(null);
      })
    );
  }
}
