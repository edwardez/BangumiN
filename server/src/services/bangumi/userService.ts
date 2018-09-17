import * as Promise from 'bluebird';
import {User} from '../../models/relational/bangumi/user';
import {Sequelize} from 'sequelize-typescript';

function findUserByIdOrUserName(id: number | string): Promise<User> {
  if (isNaN(Number(id))) {
    return User.findOne({
      where: {
        username: {
          [Sequelize.Op.eq]: String(id),
        },
      },
    });
  }

  return User.findById(id);
}

/**
 * Find username which contains or equals the keyword, case is ignored
 * @param nickname user nickname
 * @param fullMatch whether the keyword should be fully matched or partially matched
 * @param excludeFullMatchResult whether fully matched results should be excluded, doesn't work if fullMatch is set to true
 * @param offset pagination offset
 * @param limit number of results to return
 */
function findUserByNickname(nickname: string, fullMatch = false, excludeFullMatchResult = false, offset = 0,
                            limit = 25): Promise<{ rows: User[], count: number }> {
  if (fullMatch) {
    return findUserByNicknameEqual(nickname, offset, limit);
  }

  return findUserByNicknameLike(nickname, excludeFullMatchResult, offset, limit);

}

/**
 * Find username which contains the keyword, case is ignored
 * @param nickname user nickname
 * @param excludeFullMatchResult whether keyword that fully matches the result should be ignored, default to false
 * @param offset pagination offset
 * @param limit number of results to return
 */
function findUserByNicknameLike(nickname: string, excludeFullMatchResult = false, offset = 0,
                                limit = 25): Promise<{ rows: User[], count: number }> {
  let whereClause = {};

  if (excludeFullMatchResult) {
    whereClause = {
      nickname: {
        [Sequelize.Op.iLike]: `%${nickname}%`,
        [Sequelize.Op.notILike]: nickname,
      },
    };
  } else {
    whereClause = {
      nickname: {
        [Sequelize.Op.iLike]: `%${nickname}%`,
      },
    };
  }
  return User.findAndCountAll(
    {
      limit,
      offset,
      where: whereClause,
      order: Sequelize.literal('username asc'),
    },
  );

}

/**
 * Find username which equals to the nickname, case is ignored
 * @param nickname user nickname
 * @param offset pagination offset
 * @param limit number of results to return
 */
function findUserByNicknameEqual(nickname: string, offset = 0, limit = 25): Promise<{ rows: User[], count: number }> {
  return User.findAndCountAll(
    {
      limit,
      offset,
      where: {
        nickname: {
          [Sequelize.Op.iLike]: nickname,
        },
      },
      order: Sequelize.literal('username asc'),
    },
  );
}

function findUserById(id: number): Promise<User> {
  return User.findById(id);
}

export {findUserById, findUserByIdOrUserName, findUserByNickname};
