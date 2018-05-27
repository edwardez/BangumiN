import {TestBed, inject} from '@angular/core/testing';

import {BangumiSubjectService} from './bangumi-subject.service';

describe('BangumiSubjectService', () => {
    beforeEach(() => {
        TestBed.configureTestingModule({
            providers: [BangumiSubjectService]
        });
    });

    it('should be created', inject([BangumiSubjectService], (service: BangumiSubjectService) => {
        expect(service).toBeTruthy();
    }));
});
