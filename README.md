# Bangumi Spider

This is a [scrapy](http://scrapy.org/) based spider used to scrape data from [Bangumi 番组计划](https://bgm.tv). It is especially designed for machine learning task carried out by [Chi](http://ikely.me/chi)

## What information it can scrape?

Currently, bangumi spider can scrape user information, users' item record (their favorited items, rates and so on), friendship and user composed indexes. Each of the task has its dedicated spider.

## How to set up the spider?

You should set up mysql first. All the information were stored in mysql. You should create two tables named “users” and “record”:

```sql
CREATE TABLE `users` (
  `uid` INTEGER(9) NOT NULL,
  `name` VARCHAR(30) NOT NULL,
  `joindate` DATE NOT NULL,
  PRIMARY KEY (`name`)
);

CREATE TABLE `record` (
  `name` varchar(100) NOT NULL,
  `typ` varchar(5) NOT NULL,
  `iid` int(9) NOT NULL,
  `state` varchar(7) NOT NULL,
  `adddate` date NOT NULL,
  `rate` int(2) DEFAULT NULL,
  `tags` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`name`,`iid`)
)
```

Then you deploy your spider to aws EC2. Don't forget to open 6800 port for [scrapyd](http://scrapyd.readthedocs.org/en/latest/), the scrapy on the production environment.

Then follow the following steps:

1. Go to [Miniconda](http://conda.pydata.org/miniconda.html) to download the latest Miniconda to your VPS.  
2. Create an environment for scrapy. In this case, we name it "scrapyenv":
```
conda create -n scrapyenv python
source activate scrapyenv
```  
3. Install the prerequisites for scrapyd:
```
conda install lxml
pip install scrapyd
pip install mysql-python
pip install service_identity
```  
4. Run scrapyd:
```
sudo touch /var/log/scrapyd.log
sudo chown ec2-user:ec2-user /var/log/scrapyd.log
scrapyd --logfile=/var/log/scrapyd.log &
```  
At this time, you can check http://votre.site:6800/ to see if scrapyd presents you a web interface.  
5. Then on your local machine, you have to package your project to upload it to your scrapyd server. You have to `pip install scrapyd-client` to help you package and upload. For this part, you can refer to [here](https://github.com/scrapy/scrapyd-client).  
6. Execute `curl http://votre.site:6800/schedule.json -d project=bgm -d spider=the-spider-you-want`  

## License

MIT Licensed.
