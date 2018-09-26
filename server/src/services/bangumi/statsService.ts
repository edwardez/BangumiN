import * as Promise from 'bluebird';
import {Record} from '../../models/relational/bangumi/record';
import {findUserByIdOrUserName} from './userService';
import {User} from '../../models/relational/bangumi/user';
import {BanguminErrorCode, CustomError} from '../errorHandler';

function getUserStatsByIdOrUsername(userIdOrName: number | string,
                                    excludingAttributes = ['tags', 'nickname', 'rowLastModified', 'userId', 'username', 'comment'])
  : Promise<Record[]> {
  if (typeof userIdOrName === 'string') {
    return findUserByIdOrUserName(userIdOrName)
      .then<Record[]>(
        (user: User) => {
          if (!user) {
            throw new CustomError(BanguminErrorCode.RequestResourceNotFoundError, new Error('Invalid User'));
          }
          return getUserStatsById(user.id, excludingAttributes);
        },
      ) as any as Promise<Record[]>;
  }

  if (typeof userIdOrName === 'number') {
    return getUserStatsById(userIdOrName, excludingAttributes);
  }

  throw new CustomError(BanguminErrorCode.ValidationError, new Error('Invalid User name type'));
}

function getUserStatsById(userId: number,
                          excludingAttributes = ['tags', 'nickname', 'rowLastModified', 'userId', 'username', 'comment'])
  : Promise<Record[]> {
  return Record.findAll(
    {
      where:
        {userId},
      attributes: {
        exclude: excludingAttributes,
      },
    });
}

function getSubjectStatsById(subjectId: number,
                             excludingAttributes = ['tags', 'nickname', 'rowLastModified', 'userId',
                               'subjectId', 'subjectType', 'username', 'comment'])
  : Promise<Record[]> {
  return Record.findAll(
    {
      where:
        {subjectId},
      attributes: {
        exclude: excludingAttributes,
      },
    });
}

export {getUserStatsByIdOrUsername, getSubjectStatsById};
