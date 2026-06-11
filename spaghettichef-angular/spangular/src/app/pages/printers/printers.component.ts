import { AsyncPipe, DatePipe, DecimalPipe } from '@angular/common';
import { Component } from '@angular/core';
import { catchError, Observable, of } from 'rxjs';

import { PrintersResponse } from '../../models/printer.model';
import { SpaghettichefApiService } from '../../services/spaghettichef-api.service';

@Component({
  selector: 'app-printers',
  imports: [AsyncPipe, DatePipe, DecimalPipe],
  templateUrl: './printers.component.html',
  styleUrl: './printers.component.css'
})
export class PrintersComponent {
  errorMessage = '';
  printers$: Observable<PrintersResponse | null>;

  constructor(private readonly api: SpaghettichefApiService) {
    this.printers$ = this.api.getPrinters().pipe(
      catchError(() => {
        this.errorMessage = 'Could not load printers from http://localhost:18080/printers.';
        return of(null);
      })
    );
  }
}
