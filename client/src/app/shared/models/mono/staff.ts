import {Serializable} from '../Serializable';

export class Staff implements Serializable<Staff> {
    /**
     * 人物类型
     * example: 主角
     */
    role_name?: string;
    /** 职位 */
    jobs?: string[];

    deserialize(input) {
        this.role_name = input.role_name;
        this.jobs = input.jobs;
        return this;
    }
}
