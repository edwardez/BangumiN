// import {Component, Input, OnInit} from '@angular/core';
// import {CollectionWatchingResponseMedium} from '../../../shared/models/collection/collection-watching-response-medium';
// import {SubjectType} from '../../../shared/enums/subject-type.enum';
//
// @Component({
//   selector: 'app-progress-content',
//   templateUrl: './progress-content.component.html',
//   styleUrls: ['./progress-content.component.scss']
// })
// export class ProgressContentComponent implements OnInit {
//
//   @Input()
//   collectionWatchingResponse: CollectionWatchingResponseMedium[];
//
//   @Input()
//   currentSubjectType: SubjectType;
//
//   constructor() {
//   }
//
//   ngOnInit() {
//   }
//
//
//   filterBySubjectType(collectionWatchingResponse: CollectionWatchingResponseMedium[],
//                       subjectType: SubjectType): CollectionWatchingResponseMedium[] {
//     if (subjectType === SubjectType.all) {
//       return collectionWatchingResponse;
//     }
//     const filteredCollectionWatchingResponse: CollectionWatchingResponseMedium[] = [];
//
//     for (const collection of collectionWatchingResponse) {
//       if (collection.subject.type === subjectType) {
//         filteredCollectionWatchingResponse.push(collection);
//       }
//     }
//
//     return filteredCollectionWatchingResponse;
//
//   }
// }
