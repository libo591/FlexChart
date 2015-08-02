# FlexChart

## 如何查看效果

拷贝 chartapp1/bin/ 下面的文件，到服务器（如tomcat）的某个应用的子目录下，然后访问bobochart.html即可

## 文件简介

### BasicLib

一个基础的lib项目，提供了工具类等供其他项目使用

### chartslib1

chart的核心库项目，实际使用时，使用此类库编译出来的swc文件，来使用chart

### chartapp1

chart的应用示例项目，简单展示了使用chart的过程

## 代码示例
（1）首先，由于使用了MornUILib，你需要初始加载一些基础的swf，以便MornUILib能正常工作
```
//初始化组件
App.init(this);
//加载资源			
App.loader.loadAssets(["assets/comp.swf"],new Handler(loadComplete));
```
（2）其次，得到xml的配置文件，并调用相关api展现此配置文件
- 其中ChartDataLoader.loadData(data,this,w,h);的四个参数的含义为：
- @param data  xml配置信息
- @param this 指定要加载chart的父容器
- @param w 指定chart显示的宽度
- @param h 指定chart显示的高度

```
//加载得到配置xml信息
var data:XML = ...;
//加载chart
ChartDataLoader.loadData(data,this,w,h);
```

## xml配置示例
chart展现所需的各种类型的配置文件，具体可参考chartapp1/xml下面的文件及说明
## 使用源码编译
- （1）首先编译BasicLib，得到BasicLib.swc
- （2）将BasicLib.swc放到 chartslib1/libs目录下，并编译chartslib1项目，得到chartslib1.swc
- （3）将chartslib1.swc放到你的应用的libs目录下，使用即可

## 感谢

- MonsterDebugger.swc
- MornUILib.swc
- as3corelib.swc
- tweener.swc
