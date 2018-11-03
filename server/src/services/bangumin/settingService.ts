import * as Promise from 'bluebird';
import {UserExclude} from '../../models/relational/bangumin/userExclude';
import {logger} from '../../utils/logger';

export class SettingService {

  /**
   * Updates exclude settings in rds according to input
   * TODO: rethink how to save this setting and refactor this method
   * @param excludeUser Whether user wants to be excluded
   * @param userId user id
   */
  static updateUserExcludeSettings(excludeUser: boolean, userId: number): Promise<any> {
    return UserExclude.findByPrimary(userId).then(
      (userExcludingInstance) => {
        if (excludeUser && userExcludingInstance === null) {
          return UserExclude.create({userId, reason: 'user_request'});
        }
        if (!excludeUser && userExcludingInstance !== null) {
          return userExcludingInstance.destroy().then();
        }

        logger.error(`Unexpected combination: user ${userId} wants to change excludeUser to ${excludeUser} and
           instance in rds is ${userExcludingInstance}`);
        return userExcludingInstance;
      }) as any as Promise<UserExclude>;
  }

}
