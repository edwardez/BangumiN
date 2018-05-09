import {NgModule} from '@angular/core';

import {
  MatButtonModule,
  MatToolbarModule,
  MatIconModule,
  MatInputModule,
  MatSidenavModule,
  MatListModule,
  MatCardModule,
  MatTableModule,
  MatDialogModule,
  MatSelectModule,
  MatRadioModule,
  MatTooltipModule,
  MatSnackBarModule,
  MatCheckboxModule,
  MatChipsModule, MatAutocompleteModule
} from '@angular/material';
import {CdkTableModule} from '@angular/cdk/table';
import {BrowserAnimationsModule} from '@angular/platform-browser/animations';
import {FlexLayoutModule} from '@angular/flex-layout';
import {MatMenuModule} from '@angular/material/menu';
import {MatTabsModule} from '@angular/material/tabs';

@NgModule({
  imports: [
    MatCardModule,
    MatButtonModule,
    MatToolbarModule,
    MatSidenavModule,
    MatMenuModule,
    MatIconModule,
    MatListModule,
    FlexLayoutModule,
    BrowserAnimationsModule,
    FlexLayoutModule,
    MatTabsModule,
    MatSelectModule,
    MatRadioModule,
    MatInputModule,
    MatDialogModule,
    MatSnackBarModule,
    MatTooltipModule,
    MatCheckboxModule,
    MatChipsModule,
    MatAutocompleteModule
  ],
  exports: [
    MatCardModule,
    MatButtonModule,
    MatToolbarModule,
    MatSidenavModule,
    MatMenuModule,
    MatIconModule,
    MatListModule,
    FlexLayoutModule,
    BrowserAnimationsModule,
    FlexLayoutModule,
    MatTabsModule,
    MatSelectModule,
    MatRadioModule,
    MatInputModule,
    MatDialogModule,
    MatSnackBarModule,
    MatTooltipModule,
    MatCheckboxModule,
    MatChipsModule,
    MatAutocompleteModule
  ]
})
export class MaterialLayoutCommonModule {
}
