import { Routes } from '@angular/router';

import { DashboardComponent } from './pages/dashboard/dashboard.component';
import { PrintersComponent } from './pages/printers/printers.component';
import { SettingsComponent } from './pages/settings/settings.component';

export const routes: Routes = [
  { path: 'dashboard', component: DashboardComponent, title: 'Dashboard' },
  { path: 'printers', component: PrintersComponent, title: 'Printers' },
  { path: 'settings', component: SettingsComponent, title: 'Settings' },
  { path: '', pathMatch: 'full', redirectTo: 'dashboard' }
];
