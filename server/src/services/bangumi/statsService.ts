import * as Promise from 'bluebird';
import {Record} from '../../models/relational/bangumi/record';
import {findUserByIdOrUserName} from './userService';
import {User} from '../../models/relational/bangumi/user';
import {BanguminErrorCode, CustomError} from '../errorHandler';
import {Sequelize} from 'sequelize-typescript';
import {snakeCase} from 'change-case';

function getUserStatsByIdOrUsername(userIdOrName: number | string, sortBy = 'rowLastModified',
                                    excludingAttributes = ['tags', 'nickname', 'userId', 'username', 'comment'])
  : Promise<Record[]> {
  if (typeof userIdOrName === 'string') {
    return findUserByIdOrUserName(userIdOrName)
      .then<Record[]>(
        (user: User) => {
          if (!user) {
            throw new CustomError(BanguminErrorCode.RequestResourceNotFoundError, new Error('Invalid User'));
          }
          return getUserStatsById(user.id, sortBy, excludingAttributes);
        },
      ) as any as Promise<Record[]>;
  }

  if (typeof userIdOrName === 'number') {
    return getUserStatsById(userIdOrName, sortBy, excludingAttributes);
  }

  throw new CustomError(BanguminErrorCode.ValidationError, new Error('Invalid User name type'));
}

function getUserStatsById(userId: number, sortBy = 'rowLastModified',
                          excludingAttributes = ['tags', 'nickname', 'userId', 'username', 'comment'])
  : Promise<Record[]> {
  return Record.findAll(
    {
      where:
        {userId},
      attributes: {
        exclude: excludingAttributes,
      },
      order: sortBy ? Sequelize.literal(`${snakeCase(sortBy)} desc`) : Sequelize.literal('row_last_modified desc'),
    });
}

function getSubjectStatsById(subjectId: number, sortBy = 'rowLastModified',
                             excludingAttributes = ['tags', 'nickname', 'userId',
                               'subjectId', 'subjectType', 'username', 'comment'])
  : Promise<Record[]> {
  return Record.findAll(
    {
      where:
        {subjectId},
      attributes: {
        exclude: excludingAttributes,
      },
      order: sortBy ? Sequelize.literal(`${snakeCase(sortBy)} desc`) : Sequelize.literal('row_last_modified desc'),
    });
}

export {getUserStatsByIdOrUsername, getSubjectStatsById};
