import {DocumentsModule} from './documents.module';

describe('DocumentsModule', () => {
  let documentsModule: DocumentsModule;

  beforeEach(() => {
    documentsModule = new DocumentsModule();
  });

  it('should create an instance', () => {
    expect(documentsModule).toBeTruthy();
  });
});
