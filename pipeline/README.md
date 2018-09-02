# Oboe Introduction

## What is Oboe?

Oboe refers to all BangumiN pipelines. It contains:

1. Integration between Bangumi's subject API and our database

2. Integration between Bangumi's user API and our database

3. Integration between Bangumi's web user record page and our database, this pipeline is merged from
[Bangumi_Spider](https://github.com/wattlebird/Bangumi_Spider), all credit goes to the original author

## Note

This is not a efficient/verbose enough solution(considering it was initially written in few hours!), rewriting using 
some industry-strength library is needed if time is given


## Usage

Execute Each full/partial syncer under subject/user/record. Full scyner syncs from the very first id to the latest one, 
partial syncer will querying the database and syncing only newest ids that don't exist in database.

## Caution
#### Be civil
Bangumi's API has a rate limit and that limit exists for some reasons. Thus, this pipeline doesn't offer features such 
as scraping through proxy pool for now.