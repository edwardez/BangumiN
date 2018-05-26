import {Serializable} from '../Serializable';

export class Alias implements Serializable<Alias> {

    /** 日文名 */
    jp?: string;
    /** 纯假名 */
    kana?: string;
    /** 昵称 */
    nick?: string;
    /** 罗马字 */
    romaji?: string;
    /** 第二中文名 */
    zh?: string;

    deserialize(input) {
        this.jp = input.jp;
        this.kana = input.kana;
        this.nick = input.nick;
        this.romaji = input.romaji;
        this.zh = input.zh;
        return this;
    }
}
