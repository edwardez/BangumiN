import {Serializable} from '../Serializable';
import {SpoilerTextChunkSchema} from './spoiler-base';

export interface SpoilerTextChunkSchema {
  insert: string;
  attributes?: {
    spoiler: boolean;
  };
}

export class SpoilerBase implements Serializable<SpoilerBase> {
  spoilerText: SpoilerTextChunkSchema[];

  constructor(spoilerText?: any[]) {
    this.spoilerText = SpoilerBase.normalizeSpoilerText(spoilerText || []);
  }

  static normalizeSpoilerText(spoilerText: any[]): SpoilerTextChunkSchema[] {

    return spoilerText.map((spoilerTextChunkRaw: any) => {
      const newSpoilerTextChunk: SpoilerTextChunkSchema = {
        insert: String(spoilerTextChunkRaw.insert)
      };
      if (spoilerTextChunkRaw.attributes && typeof(spoilerTextChunkRaw.attributes.spoiler) === 'boolean') {
        newSpoilerTextChunk.attributes = {
          spoiler: spoilerTextChunkRaw.attributes.spoiler
        };
      }
      return newSpoilerTextChunk;
    });
  }

  deserialize(input) {
    this.spoilerText = SpoilerBase.normalizeSpoilerText(input.spoilerText || []);
    return this;
  }
}
