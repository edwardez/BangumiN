import {Injectable} from '@angular/core';
import {Title} from '@angular/platform-browser';

@Injectable({
    providedIn: 'root'
})
export class TitleService {
    _title = '';

    get title(): string {
        return this._title;
    }

    set title(title: string) {
        this._title = title;
        if (title !== '') {
            title = `${title}`;
        }
        this.bodyTitle.setTitle(`${title}`);
    }

    constructor(private bodyTitle: Title) {
    }
}
