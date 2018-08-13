import {NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';
import {KeysPipe} from './keys.pipe';
import {HttpsPipe} from './https.pipe';
import {ArrayFirstNPipe} from './array-first-n.pipe';

@NgModule({
  imports: [
    CommonModule
  ],
  declarations: [
    KeysPipe,
    HttpsPipe,
    ArrayFirstNPipe
  ],
  exports: [
    KeysPipe,
    HttpsPipe,
    ArrayFirstNPipe
  ]
})
export class SharedPipeModule {
}
