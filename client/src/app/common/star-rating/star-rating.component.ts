// inspired by https://github.com/ERS-HCL/star-rating-angular-material
import {Component, EventEmitter, Input, OnInit, Output} from '@angular/core';

@Component({
  selector: 'app-star-rating',
  templateUrl: './star-rating.component.html',
  styleUrls: ['./star-rating.component.scss']
})
export class StarRatingComponent implements OnInit {

  @Input('currentRating') private currentRating: number;
  @Input('starCount') private starCount: number;
  @Input('isEditable') private isEditable: boolean;
  @Output() private ratingUpdatedClick = new EventEmitter();
  @Output() private ratingUpdatedHover = new EventEmitter();

  ratingToBeStore: number;

  private ratingArray = [];

  constructor() {
  }


  ngOnInit() {
    for (let index = 0; index < this.starCount; index++) {
      this.ratingArray.push(index);
    }
    this.ratingToBeStore = this.currentRating;
  }

  onClickSingleRatingStar(rating: number) {
    if (!this.isEditable) { return false; }

    this.ratingUpdatedClick.emit(rating);
    this.ratingToBeStore = rating;
    return false;
  }

  onHoverEnterSingleRatingStar(ratingId: number) {
    if (!this.isEditable) { return false; }

    this.ratingUpdatedHover.emit(ratingId);

  }

  onHoverLeaveRatingArea() {
    if (!this.isEditable) { return false; }

    this.currentRating = this.ratingToBeStore;
    this.ratingUpdatedClick.emit(this.ratingToBeStore);
  }

  showIcon(index: number) {
    if (this.currentRating >= index + 1) {
      return 'star';
    } else {
      return 'star_border';
    }
  }

}
