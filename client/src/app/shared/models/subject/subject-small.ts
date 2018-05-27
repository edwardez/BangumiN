import {SubjectBase} from './subject-base';
import {SubjectCollection} from './subject-collection';
import {SubjectRating} from './subject-rating';
import {Serializable} from '../Serializable';
import {Images} from '../common/images';

export class SubjectSmall extends SubjectBase implements Serializable<SubjectSmall> {
    /**
     * 话数
     * example: 27
     * format: int32
     */
    eps?: number;
    /**
     * 话数
     * example: 27
     * format: int32
     */
    eps_count?: number;
    rating?: SubjectRating;
    /**
     * 排名
     * example: 573
     * format: int32
     */
    rank?: number;
    images?: Images;
    collection?: SubjectCollection;

    deserialize(input) {
        super.deserialize(input);
        this.eps = input.episodes || 0;
        this.eps_count = input.eps_count || 0;
        this.rating = input.rating === undefined ? new SubjectRating() : new SubjectRating().deserialize(input.rating);
        this.rank = input.rank === undefined ? '-' : input.rank;
        this.collection = input.collection === undefined ? new SubjectCollection() : new SubjectCollection().deserialize(input.collection);
        this.images = input.images === undefined ? new Images() : new Images().deserialize(input.images);
        return this;
    }

}
