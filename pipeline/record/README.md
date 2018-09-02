# Original repo
Original repo: https://github.com/wattlebird/Bangumi_Spider

# Bangumi Spider

This is a [scrapy](http://scrapy.org/) based spider used to scrape data from [Bangumi 番组计划](https://bgm.tv). It is especially designed for machine learning task carried out by [Chi](http://ikely.me/chi)

## What information it can scrape?

Currently, bangumi spider can scrape user information, users' item record (their favorited items, rates and so on), friendship and user composed indexes. Each of the task has its dedicated spider.

## How to set up the spider?

### Bangumi spider defaults generates scraped data in the form of TSV.

Currently, we added the support to scrape the data in the format of TSV. No prerequisites are required to store in TSV.

Besides, we have added the functionality to upload data to Azure Blob storage after the scrape of data. You just have provide you Azure account name, container name and access key. One must set up his/her own container (by Azure protal or other methods) in `bgm/settings.py` before open up this functionality.

Then you deploy your spider to your server. Don't forget to open 6800 port for [scrapyd](http://scrapyd.readthedocs.org/en/latest/), the scrapy on the production environment.

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
pip install azure # if you enabled azure storage
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

## Known issue

Due to sensitive content restriction, this spider cannot scrape subjects that are marked as R-18.

## License

MIT Licensed.
