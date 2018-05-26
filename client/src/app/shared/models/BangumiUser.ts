import {Serializable} from './Serializable';
import {Avatar} from './common/avatar';

interface AvatarType {
    large: string;
    medium: string;
    small: string;
}

export class BangumiUser implements Serializable<BangumiUser> {

    user_id: number;
    id: number;
    url: string;
    sign: string;
    avatar: Avatar;
    nickname: string;
    username: string;


    // user id coild be from id or user_id, if neither of them have a value, then use a empty one
    static getUserId(input) {
        if (input.id === undefined) {
            if (input.user_id === undefined) {
                return undefined;
            }

            return input.user_id;
        }

        return input.id;

    }

    constructor() {
        this.user_id = 0;
        this.avatar = new Avatar();
        this.nickname = '';
        this.username = '';
    }

    deserialize(input) {
        this.user_id = BangumiUser.getUserId(input);
        this.avatar = input.avatar === undefined ? new Avatar() : new Avatar().deserialize(input.avatar);
        this.nickname = input.nickname === undefined ? '' : input.nickname;
        this.username = input.username === undefined ? '' : input.username;
        return this;
    }


}


