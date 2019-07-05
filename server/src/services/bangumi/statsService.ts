import * as Promise from 'bluebird';
import {Record} from '../../models/relational/bangumi/record';
import {findUserByIdOrUserName} from './userService';
import {User} from '../../models/relational/bangumi/user';
import {BanguminErrorCode, CustomError} from '../errorHandler';
import {Sequelize} from 'sequelize-typescript';
import {snakeCase} from 'change-case';

function getUserStatsByIdOrUsername(userIdOrName: number | string, sortBy = 'addDate',
                                    excludingAttributes = ['tags', 'nickname', 'userId', 'username', 'comment'])
  : Promise<Record[]> {
  if (typeof userIdOrName === 'string') {
    return findUserByIdOrUserName(userIdOrName)
      .then<Record[]>(
        (user: User) => {
          if (!user) {
            throw new CustomError(BanguminErrorCode.RequestResourceNotFoundError, new Error('Invalid User'));
          }
          return getUserStatsById(user.id, sortBy, false, excludingAttributes);
        },
      ) as any as Promise<Record[]>;
  }

  if (typeof userIdOrName === 'number') {
    return getUserStatsById(userIdOrName, sortBy, false, excludingAttributes);
  }

  throw new CustomError(BanguminErrorCode.ValidationError, new Error('Invalid User name type'));
}

function getUserStatsById(userId: number, sortBy = 'addDate', descending = false,
                          excludingAttributes = ['tags', 'nickname', 'userId', 'username', 'comment'])
  : Promise<Record[]> {
  const sortSequence = descending ? 'desc' : 'asc';
  return Record.findAll(
    {
      where:
        {userId},
      attributes: {
        exclude: excludingAttributes,
      },
      order: sortBy ? Sequelize.literal(`${snakeCase(sortBy)} ${sortSequence}`) : Sequelize.literal(`addDate ${sortSequence}`),
    }) as any as Promise<Record[]>;
}

function getSubjectStatsById(subjectId: number, sortBy = 'addDate', descending = false,
                             excludingAttributes = ['tags', 'nickname', 'userId',
                               'subjectId', 'subjectType', 'username', 'comment'])
  : Promise<Record[]> {
  const sortSequence = descending ? 'desc' : 'asc';
  return Record.findAll(
    {
      where:
        {subjectId},
      attributes: {
        exclude: excludingAttributes,
      },
      order: sortBy ? Sequelize.literal(`${snakeCase(sortBy)} ${sortSequence}`) : Sequelize.literal(`addDate ${sortSequence}`),
    }) as any as Promise<Record[]>;
}

export {getUserStatsByIdOrUsername, getSubjectStatsById};
