import {Pipe, PipeTransform} from '@angular/core';

@Pipe({
  name: 'arrayFirstN'
})
/**
 * get first N element in an array
 */
export class ArrayFirstNPipe implements PipeTransform {

  transform(value: any[], firstNElementCount: number): any {
    return value.filter(item => value.indexOf(item) < firstNElementCount);
  }

}
