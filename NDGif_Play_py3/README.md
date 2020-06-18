# 1.0  ND GifPlay - gif播放器

![](https://gitee.com/to4698/ND_tools/raw/master/img/005/003-1588475805061.png)

-----

### 下载

~~链接：https://pan.baidu.com/s/1Y4au1zq5fddIUaHOdio9ig~~
~~提取码：tlyy~~

链接：https://pan.baidu.com/s/1oWHR8booNdJluzJu0jKn-g
提取码：zkt7


## 【2.0 更新】：
- 添加拖拽进视频文件之后的视频信息打印，可以看到视频时长，是简单的秒数加帧数，FPS：视频帧率，视频画面宽和高

-----
## 安装：

绿色软件无需安装，下载压缩包，解压到D盘或是任意文件夹。打开 NDGif_Play_py3.exe 即可使用。

如解压到下图位置

![](https://gitee.com/to4698/ND_tools/raw/master/img/005/003-1588477021119.png)

## 使用

*   打开文件 ：将gif 图片 拖拽进播放器窗口，即可播放.

*   键盘控制： 空格键 暂停、播放 ，左右方向键上一帧下一帧。

*   鼠标控制： 直接在播放窗口拖拽画面，往左移动是上一帧，往右移动是下一帧，单击画面可暂停播放






-----



## 并联文件类型 ：快速打开 GIF文件

*    选中一个gif文件，右键 -> 打开方式 -> 选中其他应用 -> 设置为 NDGif_Play_py3.exe 始终打开 .gif 文件

具体操作如不懂请百度 并联文件类型


## 添加右键菜单 ： 快速打开 GIF文件

*   使用 NDGifPlay_加入右键菜单.bat 将 NDGifPlay 添加到右键菜单。

![](https://gitee.com/to4698/ND_tools/raw/master/img/005/003-1588476635831.png)

![](https://gitee.com/to4698/ND_tools/raw/master/img/005/003-1588476725987.png)

-------

因为是使用python 写的，然后打包成独立应用，包含了各种所需的环境依赖，所以文件比较多，包体比较大。

-------

# 2.0 MP4 截取 GIF

![](https://gitee.com/to4698/ND_tools/raw/master/img/005/003-1588477358035.png)



### 下载

~~链接：https://pan.baidu.com/s/1gJfguoFGlpYAiZEkbgXQsQ~~
~~提取码：o2pr~~

链接：https://pan.baidu.com/s/1oWHR8booNdJluzJu0jKn-g
提取码：zkt7

## 【2.0 更新】：

- 添加拖拽进视频文件之后的视频信息打印，可以看到视频时长，是简单的秒数加帧数，FPS：视频帧率，视频画面宽和高



## 安装：

*   绿色软件无需安装，下载压缩包，解压到D盘或是任意文件夹。打开 video_to_gif_ui.exe 即可使用

*   ND GifPlay 与 video_to_gif_ui 两个文件夹是可以合并的。

如下图：

![](https://gitee.com/to4698/ND_tools/raw/master/img/005/003-1590034025801.png)

## 使用:

*   把Mp4 格式的视频文件拖拽进来，然后填上要保存的gif 文件名。截取的 开始时间 和 结束时间，即可截取gif



-----

# 其他说明

* 时间格式
* 尺寸 和 帧率

### 1. 时间格式

    00:00:01:14 以冒号为分割，第一个两位数是 小时，第二个是分钟，第三个秒时，第四个帧数

帧数主要是根据 视频文件的帧率来决定的。如果一个视频文件的帧率是每秒 30 帧。 意思为每30帧，为一秒，1.5秒长的视频只好用 01:15 (一秒外加15帧即视频总长为 45 帧) 来精确表示。

案例1： 视频帧率30
起始时间 00:00:01:14 即视频的第45帧位置。
终点时间 00:00:03:00 即视频的3*30 第90帧位置。
截取下来的gif 总帧数为 90 - 45 + 1 = 46 帧

所以设置时间之前，你需要知道你视频的帧率，等信息，不然无法做到精确截取。

然而大多数常见的视频播放器并不能显示当前画面是第几帧。




### 这里推荐一个优秀播放器 Keyframe

### 下载

链接：https://pan.baidu.com/s/1aC2vwQEbLyD9PykiR38n2g
提取码：5ty5



![](https://gitee.com/to4698/ND_tools/raw/master/img/005/003-1588479322373.png)

这播放进度条上右键可以选择多种进度显示方式，有按帧显示，有按时间显示，建议设置为 time code 模式。

time code 模式下 最后两位 为帧数，前面为时间数。

----
### 2. 尺寸 和 帧率

尺寸 ： 保存出来的 gif 画面大小 等比例的 只设一个画面宽，自动按等比例设置高度

帧率 ： 保存GIF的帧率。


------

Python : MoviePy1.0.2
