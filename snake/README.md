
## 在MAX 里玩游戏 - 贪吃蛇

#### 本地下载

#### [右键-链接另保存-贪吃蛇](https://gitee.com/to4698/ND_tools/raw/master/snake/snake_v2.1.ms "贪吃蛇")

![](https://gitee.com/to4698/ND_tools/raw/master/snake/G6CFDLL{DARPQAG[8ORCX9N.png)

### AWSD 控制，每得10分，速度增加5.

蛇身体是用数组法实现的，每帧在前面创建一个BOX，在后面删掉一个BOX。

画面刷新用了一个计时器 timer。

吃食物，就是简单的判断食物和蛇头的距离，小于或等于食物大小时，删掉一个食物，蛇长加一个。

咬自己也用同样的方法。（实现的不太好，蛇长 小于6之前，是可以回头走的，超过6回头走会咬死自己。

地图就是一个BOX（开启了方框显示），蛇活动范围就是BOX的长宽积。