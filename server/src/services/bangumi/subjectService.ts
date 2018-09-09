import {Subject} from '../../models/bangumi/subject';
import * as Promise from 'bluebird';

function findSubjectById(id: number): Promise<Subject> {
  return Subject.findById(id, {attributes: {exclude: ['eps', 'epsCount', 'rank', 'rating', 'collection']}});
}

export {findSubjectById};
