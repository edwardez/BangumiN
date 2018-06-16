// inspired by https://github.com/ERS-HCL/star-rating-angular-material with heavy modification
import {Component, EventEmitter, Input, OnInit, Output} from '@angular/core';
import {ControlValueAccessor, NG_VALUE_ACCESSOR} from '@angular/forms';

@Component({
  selector: 'app-star-rating',
  providers: [{
    provide: NG_VALUE_ACCESSOR,
    useExisting: StarRatingComponent,
    multi: true
  }],
  templateUrl: './star-rating.component.html',
  styleUrls: ['./star-rating.component.scss']
})
export class StarRatingComponent implements OnInit, ControlValueAccessor {

  @Input() currentRating = 0;
  @Input() starCount = 10;
  @Input() isEditable = false; // whether edit is allowed
  @Input() isRemovable = false; // whether to show removal button
  @Output() ratingUpdated = new EventEmitter();

  private ratingToBeStore: number;
  private ratingArray = [];
  private propagateChange = (_: any) => {
  }

  constructor() {
  }


  ngOnInit() {
    for (let index = 0; index < this.starCount; index++) {
      this.ratingArray.push(index);
    }
    this.ratingToBeStore = this.currentRating;
  }

  onClickSingleRatingStar(rating: number) {
    if (!this.isEditable) {
      return false;
    }

    this.currentRating = rating;
    this.ratingToBeStore = rating;
    this.propagateChange(rating);
    this.ratingUpdated.emit(this.ratingToBeStore);
    return false;
  }

  onHoverEnterSingleRatingStar(rating: number) {
    if (!this.isEditable) {
      return false;
    }
    this.currentRating = rating;
  }

  onHoverLeaveRatingArea() {
    if (!this.isEditable) {
      return false;
    }
    this.currentRating = this.ratingToBeStore;
  }

  onClickRemoveRating() {
    this.onClickSingleRatingStar(0);
  }

  onHoverEnterRemoveRating() {
    this.onHoverEnterSingleRatingStar(0);
  }

  showIcon(index: number) {
    if (this.currentRating >= index + 1) {
      return 'star';
    } else {
      return 'star_border';
    }
  }


  registerOnChange(fn: any): void {
    if (this.isEditable) {
      this.propagateChange = fn;
    }
  }

  registerOnTouched(fn: any): void {
  }

  setDisabledState(isDisabled: boolean): void {
    this.isEditable = !isDisabled;
  }

  writeValue(value: any): void {
    if (this.isEditable) {
      this.currentRating = value;
    }
  }

}
