# Bangumi Spider

This is a [scrapy](http://scrapy.org/) based spider used to scrape data from [Bangumi 番组计划](https://bgm.tv). 

## What information it can scrape?

Currently, bangumi spider is designed to scrape basic user information and all the items a user has favorited. For the user's basic information, user's username, id and his/her date that joined Bangumi are scraped. For a user's favorite record, his/her id, type, date that was favorited, rating, comment and tags were scraped. Those two kinds of information were extracted at the same time, and are not independent.

## How to set up the spider?

You should set up mysql first. All the information were stored in mysql. You should create two tables named “users” and “record”:

```sql
CREATE TABLE `users` (
  `uid` int(10) NOT NULL DEFAULT '0',
  `name` varchar(100) NOT NULL DEFAULT '',
  `joindate` date DEFAULT NULL,
  PRIMARY KEY (`name`),
)

CREATE TABLE `record` (
  `name` varchar(100) NOT NULL,
  `typ` varchar(8) NOT NULL,
  `iid` int(10) NOT NULL,
  `state` varchar(20) NOT NULL,
  `adddate` date NOT NULL,
  `rate` int(2) DEFAULT NULL,
  `comment` text,
  `tags` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`name`,`iid`),
)
```

Then you deploy your spider to aws EC2.

1. Clone the repository to a specific place

  ```sh
  git clone git@github.com:wattlebird/Bangumi_Spider.git
  cd Bangumi_Spider
  ```
  
2. Set up virtual environment

  ```sh
  virtualenv ve
  source ve/bin/activate
  ```
  
3. Pip install scrapy, scrapyd, mysql-python

4. Run scrapyd in background.

  ```sh
  touch /var/log/scrapyd.log
  scrapyd > /var/log/scrapyd.log &
  ```
  
5. Follow instructions given by [scrapyd documention](http://scrapyd.readthedocs.org/en/latest/deploy.html).

## License

MIT Licensed.
