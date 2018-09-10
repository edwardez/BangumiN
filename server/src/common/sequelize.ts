import {Sequelize} from 'sequelize-typescript';
import config from '../config/web';
import {Subject} from '../models/bangumi/subject';
import {User} from '../models/bangumi/user';

import Logger from '../utils/logger';
const logger = Logger(module);

const sequelize = new Sequelize({
  dialect: 'postgres',
  operatorsAliases: Sequelize.Op as any,
  host: config.rds.address,
  database: config.rds.dbName,
  username: config.rds.userName,
  password: config.rds.password,
  port: config.rds.port,
  logging: config.env === 'dev' ? logger.info : false,
  dialectOptions: {
    ssl: true,
  },
});

sequelize.addModels([Subject]);
sequelize.addModels([User]);

export {sequelize};
