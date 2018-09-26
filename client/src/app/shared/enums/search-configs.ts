export interface SearchBarAutoCompleteOptionValue {
  inputValue: string;
  autoCompleteType: AutoCompleteType;
  extraInfo: SearchBarAutoCompleteDefaultOptions;
}

export interface SearchBarAutoCompleteDefaultOptions {
  'searchIn': SearchIn;
  'searchBy': SearchBy;
  'translationLabel': string;
}

export enum SearchIn {
  'subject', 'user'
}

export enum SearchBy {
  'keyword', 'id'
}

export enum AutoCompleteType {
  'default', 'remoteResponse'
}

