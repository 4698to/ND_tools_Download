

# 动画镜像工具v.3.2 - 2020-05-22 

![](https://gitee.com/to4698/ND_tools/raw/master/img/004/22-1587651104652.png)

#### 本地下载

#### [右键-链接另保存-动画镜像工具v.3.2](https://gitee.com/to4698/ND_tools/raw/master/Anim_Mirror/Anim_mirror_v_3.2.mse "动画镜像工具v.3.2")

### 使用

- 镜像轴 ：一般常用的正面镜像是X轴。
- 翻转 : 正常的左右镜像保持默认设置即可。
- 动画-姿势 ： 镜像完整动画还是镜像一帧一个pose 
- 对称轴对象 ： 不设置为原点镜像。
- 复制 ：复制选中对象动画。
- 黏贴 ：镜像黏贴复制动画到选中对象。
- 自我镜像 ： 即复制自己的动画然后又镜像黏贴给自己的快捷操作。

### 注意

- 镜像是以对称轴对象的坐标系为准的，不设置默认为世界坐标系
- 选中对象时的顺序。复制选中的顺序和黏贴选中的顺序要一一对应。
- 先从骨骼链的上层开始操作。如果先从骨骼链下层开始镜像，镜像动画会不对(因为下层骨骼动画受上层骨骼动画影响)
- 镜像从biped骨骼复制的动画时可以试下降翻转轴设置为 Y 轴

如果发现黏贴无效，请将复制对象 K上位移帧 (红色帧)

如发现黏贴之后效果出乎意料，请删除黏黏对象动画之后重试

如果觉的工具好用，欢迎捐赠以示支持，让洒家有动力更新啊

![](https://gitee.com/to4698/ND_tools/raw/master/img/10RMB.jpg)

联系 99U：199505  E-mail:738746223@qq.com






