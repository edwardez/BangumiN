import {Component, Input, OnInit} from '@angular/core';
import {MonoBase} from '../../shared/models/mono/mono-base';

@Component({
  selector: 'app-character-list',
  templateUrl: './character-list.component.html',
  styleUrls: ['./character-list.component.scss']
})
export class CharacterListComponent implements OnInit {

  @Input()
  allCharacters;

  constructor() {
  }

  ngOnInit() {
  }

  generateActorsList(actorsInfo: MonoBase[]): string {
    const actors = actorsInfo.reduce((accumulatedValue, currentValue) => {
      accumulatedValue.push(currentValue.name);
      return accumulatedValue;
    }, []);

    return actors.length >= 1 ? 'CV: ' + actors.join(' / ') : '';
  }

}
