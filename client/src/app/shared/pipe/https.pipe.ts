import {Pipe, PipeTransform} from '@angular/core';

@Pipe({
    name: 'https'
})
export class HttpsPipe implements PipeTransform {

    transform(value: any, args?: any): any {
        if (value) {
            return value.replace(/^http:/, 'https:');
        }

        return '';
    }

}
