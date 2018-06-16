import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import {KeysPipe} from './keys.pipe';
import {HttpsPipe} from './https.pipe';

@NgModule({
  imports: [
    CommonModule
  ],
  declarations: [
    KeysPipe,
    HttpsPipe
  ],
  exports:[
    KeysPipe,
    HttpsPipe
  ]
})
export class SharedPipeModule { }
