# BangumiN

BangumiN - A cloud-based progressive web app for Bangumi.

[中文](./documents/zh-Hans/README.md)

![name](./documents/en-US/images/name.png)

# Notice☠

This project is still under heavy development and features may be changed without notice.

If you find any bugs, security flaws or any other exceptions, feel free to report them!

# Install


* For client
    * `npm install`
    * `npm run start-dev`
* For server
    * `npm install`
    * `npm run start-dev`


# Highlighted Features
* Search, show and manage your subjects
* Data visualization for subjects and user
* Spoiler Box: Safely post spoilers


# Roadmap

| Plan | Status & deadline | Comment |
| --- | --- | --- |
| ~~Basic functionality: Progress Management~~ | N/A | ~~Basic implementation is done, needs to rewrite episode management using virtual scroll~~ Won't be implemented for now due to  restriction of Bangumi|
| Basic functionality: Search | Done | Needs a completely rewrite |
| Basic functionality: Subject Info | Done | Needs further css tweak |
| Spoiler Box | Done |  |
| User data visualization | Done | Done |
| Subject data visualization | Done | Done |
| Pipeline | Done | Extract data from Bangumi and store in our database. Subject pipeline: through API;User pipeline: through API;User record pipeline: through web crawler |
| Multiple Themes | Done | Available: Blue, Bangumi Pink, Night |
| PWA improvement(server-side rendering, cache, lazy loading, etc.) | Done | Needs further improvement  |
| Accessibility | 2018 Q3-Q4 | Not started |
| Test | 2018 Q4 | Time is not enough and functionalities change very fast, wait until website stabilizes |
| Continuous integration | 2018 Q3-Q4 | Basic implementation before website is in prod |
| Drag and drop | TBD | Blocked by https://github.com/angular/material2/issues/8963 |

