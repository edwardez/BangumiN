import {HttpResponse} from '@angular/common/http';
import {RuntimeConstantsService} from '../../services/runtime-constants.service';

export interface CacheEntry {
  url: string;
  response: HttpResponse<any>;
  entryTime: number;
}

export const MAX_CACHE_AGE = RuntimeConstantsService.maxCacheAge;
