export enum SubjectType {
    all = -1, // we use a 'trick' here, bangumi will return all results if type is not in their list, so we use -1 to indicate all type
    book = 1,
    anime = 2,
    music = 3,
    game = 4,
    real = 6,
}
