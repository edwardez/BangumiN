import {Sequelize} from 'sequelize-typescript';
import config from '../config/web';
import {logger} from '../utils/logger';
import {Subject} from '../models/relational/bangumi/subject';
import {User} from '../models/relational/bangumi/user';
import {Record} from '../models/relational/bangumi/record';
import {UserExclude} from '../models/relational/bangumin/userExclude';

const sequelize = new Sequelize({
  dialect: 'postgres',
  operatorsAliases: Sequelize.Op as any,
  host: config.rds.address,
  database: config.rds.dbName,
  username: config.rds.userName,
  password: config.rds.password,
  port: config.rds.port,
  logging: logger.info,
  dialectOptions: {
    ssl: true,
  },
});

sequelize.addModels([Subject]);
sequelize.addModels([User]);
sequelize.addModels([Record]);
sequelize.addModels([UserExclude]);

export {sequelize};
