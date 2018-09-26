import {Subject} from '../../models/relational/bangumi/subject';
import * as Promise from 'bluebird';

function findSubjectById(id: number, exclude = ['eps', 'epsCount', 'rank', 'rating', 'collection']): Promise<Subject> {
  return Subject.findById(id, {attributes: {exclude}});
}

export {findSubjectById};
