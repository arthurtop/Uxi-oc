# Uxi-oc
项目OC版 
=====

README文件后缀名为md。md是markdown的缩写，markdown是一种编辑博客的语言。
-------

关于标题
在文本下面加上 等于号 = ，那么上方的文本就变成了大标题。等于号的个数无限制，但一定要大于0个哦。。
比大标题低一级的是中标题，也就是显示出来比大标题小点。

在文本下面加上 下划线 - ，那么上方的文本就变成了中标题，同样的 下划线个数无限制。
除此之外，你也会发现大，中标题下面都有一条横线，没错这就是 = 和 - 的显示结果。
如果你只输入了等于号=，但其上方无文字，那么就只会显示一条直线。如果上方有了文字，但你又只想显示一条横线，而不想把上方的文字转义成大标题的话，那么你就要在等于号=和文字直接补一个空行。
补空行：是很常用的用法，当你不想上下两个不同的布局方式交错到一起的时候，就要在两种布局之间补一个空行。
如果你只输入了短横线（减号）-，其上方无文字，那么要显示直线，必须要写三个减号以上。不过与等于号的显示效果不同，它显示出来时虚线而不是实线。同减号作用相同的还有星号*和下划线_，同样的这两者符号也要写三个以上才能显示一条虚横线。

等级标题
关于标题还有等级表示法，分为六个等级，显示的文本大小依次减小。不同等级之间是以井号  #  的个数来标识的。一级标题有一个 #，二级标题有两个# 
#一级标题
##二级标题
###三级标题
####四级标题
#####五级标题
######六级标题


普通文本
直接输入的文字就是普通文本。需要注意的是要换行的时候不能直接通过回车来换行，需要使用<br>(或者<br/>)。也就是html里面的标签。事实上，markdown支持一些html标签，你可以试试

单行文本
使用两个Tab符实现单行文本。

多行文本
多行文本和单行文本异曲同工，只要在每行行首加两个Tab

Thank `you`. Please `call` me and `email` 

[博客](https://github.com/arthurtop "悬停显示")

![](http://www.baidu.com/img/bdlogo.gif)

![baidu](http://www.baidu.com/img/bdlogo.gif "百度")

GitHub仓库里的图片
有时候我们想显示一个GitHub仓库(或者说项目)里的图片而不是一张其他来源网络图片，因为其他来源的URL很可能会失效。那么如何显示一个GitHub项目里的图片呢？
其实与上面的格式基本一致的，所不同的就是括号里的URL该怎么写。
    https://github.com/ 你的用户名 / 你的项目名 / raw / 分支名 / 存放图片的文件夹 / 该文件夹下的图片
我在GitHub上的用户名guodongxiaren；有一个项目ImageCache；raw表示原数据的意思吧，不用管它；主分支master；项目里有一个文件夹Logo；Logo文件夹下有一张图片foryou.gif


给图片加上超链接
如果你想使图片带有超链接的功能，即点击一个图片进入一个指定的网页。
[![baidu]](http://baidu.com)
[baidu]:http://www.baidu.com/img/bdlogo.gif "百度"


插入代码片段
我们需要在代码的上一行和下一行用` `` 标记。``` 不是三个单引号，而是数字1左边，Tab键上面的键。要实现语法高亮那么只要在 ``` 之后加上你的编程语言即可（忽略大小写）
```Object C
NetworkManager *netManager = [NetworkManager shareManage];
    [netManager get:urlStr parameters:nil success:^(NSDictionary *dict) {
        
        NSLog(@"data:%@",dict);
        
        if ([dict[@"msg"] isEqualToString:@"ok"] && dict[@"msg"] != nil) {
            
            self.tlPayDataStr = [self tongLPayDataDict:dict];
            
            [self tongLPayDataSDK:self.tlPayDataStr viewCtl:viewCtl];
        }
    }];
















