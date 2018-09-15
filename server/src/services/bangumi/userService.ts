import * as Promise from 'bluebird';
import {User} from '../../models/relational/bangumi/user';
import {Subject} from '../../models/relational/bangumi/subject';
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

function findUserById(id: number): Promise<User> {
  return User.findById(id);
}

export {findUserById, findUserByIdOrUserName};
