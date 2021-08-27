### 关于程序的编译和链接

​	在此，我想多说关于程序编译的一些规则和方法，一般来说，无论是C,C++,还是pas，首先要把源文件编译成**中间代码文件**
在windows下也就是.obj文件，UNIX下是.o文件，即Object file，这个过程叫做编译，然后再把大量的object file合成执行文件，这个过程叫做链接。

#### 编译

​	编译时，编译器需要的是语法的正确，函数与变量的声明的正确。对于后者，通常是你需要告诉编译器头文件的 所在位置，只要所有的语法正确，编译器就可以编译出中间目标文件。一般来说，每个源文件都应该对应一个中间目标文件（o文件或者是obj文件）。

#### 链接

链接时，主要时链接函数和全局变量，所以我们可以使用这些中间目标文件来链接我们的应用程序。链接器并不管函数所在的源文件，只管函数的中间目标文件，在大多数时候，由于源文件太多，编译生成的中间目标文件太多，而在链接时需要明显地指出中间目标文件名，这对于编译很不方便，所以，我们要给中间目标文件打个包，在windows下这种包叫“**库文件（Library File）**”，也就是lib文件，在UNIX下，时Archive File，也就是.a文件。

总结一下，源文件首先会生成中间目标文件，再由中间目标文件生成可执行文件。在编译时，编译器只检测程序语法、函数和变量是否声明。如果函数未被声明，编译器就会给出一个警告，但是可以生成object file，而在链接程序时，链接器会在所有的object file中找寻函数的实现，如果找不到，那就会报链接错误码，在vc下，这种错误一般是Link 2001错误，意思是说，链接器未能找到函数的实现，你需要指定函数的object file。



 Makefile 的一般规则为：

target....: prerequisites ...
	command
	...

target也就是一个目标文件，可以是object file，也可以是执行文件。还可以是一个标签（label）。
prerequisites就是要生成target所需要的文件或者是目标。
command也就是make需要执行的命令。（任意的shell命令）

​	在定义好依赖关系后，后续的那一行定义了如何生成目标文件的**操作系统命令**，**一定要以一个Tab键作为开头**，记住，**make并不管命令是怎么工作的，它只管执行所定义的命令**。

``` makefile
clean:
	cd src && $(MAKE) $@
	cd test && $(MAKE) $@
	cd doc && $(MAKE) $@
	rm -f TAGS
```

​	这里要说明的一点是，clean不是一个文件，它只不过是一个动作的名字，有点像C语言中的lable一样，冒号后面你什么也没有，那么，make就不会自动去找文件的依赖性，也就不会自动执行其后所定义的命令。要执行其后的命令，就要在make命令后明显得指出这个lable的名字。这样的方法非常的有用，我们可以在makefile中定义不用编译或者是和编译无关的命令，比如程序的打包、程序的备份等等。

这里我使用一个示例：

```makefile
edit : main.o kbd.o command.o display.o \
          insert.o search.o files.o utils.o
           cc -o edit main.o kbd.o command.o display.o \
                      insert.o search.o files.o utils.o

   main.o : main.c defs.h
           cc -c main.c
   kbd.o : kbd.c defs.h command.h
           cc -c kbd.c
   command.o : command.c defs.h command.h
           cc -c command.c
   display.o : display.c defs.h buffer.h
           cc -c display.c
   insert.o : insert.c defs.h buffer.h
           cc -c insert.c
   search.o : search.c defs.h buffer.h
           cc -c search.c
   files.o : files.c defs.h buffer.h command.h
           cc -c files.c
   utils.o : utils.c defs.h
           cc -c utils.c
   clean :
           rm edit main.o kbd.o command.o display.o \
              insert.o search.o files.o utils.o
```



### make是如何工作的

在默认的方式下，也就是我们只输入make命令，那么：

1. make会在当前目录下找名字叫“Makefile” 或者“makefile”的文件。
2. 如果找到了，它会找文件中的第一个依赖文件（target），在上面的例子中，它会找到“edit”这个文件，并把这个文件作为最终的目标文件。
3. 如果edit文件不存在，或者是edit所依赖的.o文件的文件修改时间要比edit这个文件新，那么它就会执行后面所定义的命令来生成edit这个文件。
4. 如果edit所依赖的.o文件也存在，那么make会在当前文件中找目标为.o文件的依赖，如果找到就再根据那一个规则生成.o文件。
5. 当然，你的C文件和H文件是存在的，于是make会生成.o文件，然后再用.o文件声明make的终极任务，也就是执行文件edit了。

​       这就是整个make的依赖性，make会一层又一层地去找文件的依赖关系，直到最终编译出第一个目标文件。在找寻的过程中，如果出现错误，比如最后被依赖的文件找不到，那么make就会直接退出，并报错，而对于所定义的命令的错误，或是编译不成功，make根本不理。make只管文件的依赖性，即，如果在我找了依赖关系之后，冒号后面的文件还是不在，那么对不起，我就不工作啦。

### makefile中使用变量

在上面的例子中，先让我们看一下edit的规则：

```makefile
 edit : main.o kbd.o command.o display.o \
                 insert.o search.o files.o utils.o
           cc -o edit main.o kbd.o command.o display.o \
                      insert.o search.o files.o utils.o
```

我们可以看到.o文件的字符串被重复了两次，如果我们的工程需要加入一个新的.o文件，那么我们需要在两个地方加。当然我们的makefile并不复杂，所以在两个地方加上也不麻烦，但是如果makefile变得复杂了，那么我们就有可能会忘掉一个需要加入的地方，而导致编译失败。所以为了makefile的易维护，在makefile中我们可以使用变量，makefile中的变量也就是一个字符串，理解成c语言中的宏可能更好。

比如我们可以这样定义：

``` makefile
objects = main.o kbd.o command.o display.o \
             insert.osearch.o files.o utils.o 
   edit : $(objects)
           cc -o edit $(objects)
```

这样的话，如果有新的.o文件加进来，我们只需要简单的修改一下object就可以了。



### make的自动推导

GNU的make很强大，它可以自动推导文件以及文件依赖关系后面的命令，于是我们就没必要去在每一个[.o]文件后都写上类似的命令，因为，我们的make会自动识别，并自己推导命令。

  只要make看到一个[.o]文件，它就会自动的把[.c]文件加在依赖关系中，如果make找到一个whatever.o，那么whatever.c，就会是whatever.o的依赖文件。并且 cc -c whatever.c 也会被推导出来，于是，我们的makefile再也不用写得这么复杂。我们的是新的makefile又出炉了

``` makefile
objects = main.o kbd.o command.o display.o \
             insert.o search.o files.o utils.o
   edit : $(objects)
           cc -o edit $(objects)
   main.o : defs.h
   kbd.o : defs.h command.h
   command.o : defs.h command.h
   display.o : defs.h buffer.h
   insert.o : defs.h buffer.h
   search.o : defs.h buffer.h
   files.o : defs.h buffer.h command.h
   utils.o : defs.h
 
   .PHONY : clean
   clean :
           rm edit $(objects)
```

这种方法，也就是make的“隐晦规则”。上面文件内容中，“.PHONY”表示，clean是个伪目标文件。phony

### 另类风格的makefile

​		即然我们的make可以自动推导命令，那么我看到那堆[.o]和[.h]的依赖就有点不爽，那么多的重复的[.h]，能不能把其收拢起来，好吧，没有问题，这个对于make来说很容易，谁叫它提供了自动推导命令和文件的功能呢？来看看最新风格的makefile吧。

``` makefile
objects = main.o kbd.o command.o display.o \
             insert.o search.o files.o utils.o
 
   edit : $(objects)
           cc -o edit $(objects)
 
   $(objects) : defs.h
   kbd.o command.o files.o : command.h
   display.o insert.o search.o files.o : buffer.h
 
   .PHONY : clean
   clean :
           rm edit $(objects)
```

这种风格，让我们的makefile变得很简单，但我们的文件依赖关系就显得有点凌乱了。鱼和熊掌不可兼得。还看你的喜好了。我是不喜欢这种风格的，一是文件的依赖关系看不清楚，二是如果文件一多，要加入几个新的.o文件，那就理不清楚了。

### 清空目标文件的规则

每个makefile中都应该写一个清空目标文件（.o和执行文件）的规则，这不仅便于重编译，也利于保持文件的清洁，这是一个修养，一般的风格都是：

``` makefile
clean:
	rm edit $(objects)
```

更为稳健的做法是：

``` makefile
.PHONY : clean
	clean :
		-rm edit $(objects)
```

前面说过，.PHONY意思表示clean是一个“伪目标”，。而在rm命令前面加了一个小减号的意思就是，也许某些文件出现问题，但不要管，继续做后面的事。当然，clean的规则不要放在文件的开头，不然，这就会变成make的默认目标，相信谁也不愿意这样。不成文的规矩是——“clean从来都是放在文件的最后”。

上面就是一个makefile的概貌，也是makefile的基础，下面还有很多makefile的相关细节，准备好了吗？准备好了就来。



## Makefile综述

### Makefile里面有什么？

makefile里主要包含了五个东西：显示规则、隐晦规则、变量定义、文件指示和注释。

- **显示规则**。显示规则说明了，如何生成一个或多的目标文件。这是由makefile的书写着明显指出，要生成的文件，文件的依赖文件，生成的命令。
- **隐晦规则**。由于我们的make有自动推到的功能，所以隐晦的规则可以让我们比较粗糙地简略地书写Makefile，这是由make所支持的。
- **变量的定义**。在Makefile中，我们要定义一系列的变量，变量一般都是字符串，这个有点像C语言中的宏，当Makefile被执行时，其中的变量都会被扩展到相应的应用位置上。
- **文件指示**。其包含了三个部分，一个是在一个Makefile中引用了另一个Makefile就像C语言中的include一样；另一个是指根据某些情况指定Makefile中的有效部分，就像C语言中的预编译#if一样；还有就是定义一个多行的命令，
- **注释**，Makefile中只有行注释，和UNIX的shell脚本一样，其注释使用#字符，这个就像C/C++中的“//”一样。如果你要在你的Makefile中使用“#”字符，可以用反斜框进行转义，如：“\#”。

最后，还值得一提的是，在Makefile中的命令，**必须要以[Tab]键开始。**



### Makefile的文件名

​		默认的情况下，make命令会在当前目录下按顺序找寻文件名为**“GNUmakefile”、“makefile”、“Makefile”**的文件，找到了解释这个文件。在这三个文件名中，最好使用“Makefile”这个文件名，因为，这个文件名第一个字符为大写，这样有一种显目的感觉。最好不要用“GNUmakefile”，这个文件是GNU的make识别的。有另外一些make只对全小写的“makefile”文件名敏感，但是基本上来说，大多数的make都支持“**makefile”和“Makefile”**这两种默认文件名。

   当然，你可以使用别的文件名来书写Makefile，比如：“Make.Linux”，“Make.Solaris”，“Make.AIX”等，如果要**指定特定的Makefile，你可以使用make的“-f”和“--file”参数**，如：make -f Make.Linux或make --file Make.AIX



### 引用其他的Makefile



在Makefile使用include关键字可以把别的Makefile包含进来，这很像C语言的#include，被包含的文件会原模原样的放在当前文件的包含位置。include的语法是：

```
    include<filename>filename可以是当前操作系统Shell的文件模式（可以保含路径和通配符）
```

​		**在include前面可以有一些空字符，但是绝不能是[Tab]键开始。include和可以用一个或多个空格隔开。**举个例子，你有这样几个Makefile：a.mk、b.mk、c.mk，还有一个文件叫foo.make，以及一个变量$(bar)，其包含了e.mk和f.mk，那么，下面的语句：

  include foo.make *.mk $(bar)

等价于：

  include foo.make a.mk b.mk c.mk e.mk f.mk

​		make命令开始时，会把找寻include所指出的其它Makefile，并把其内容安置在当前的位置。就好像C/C++的#include指令一样。如果文件都没有指定绝对路径或是相对路径的话，make会在当前目录下首先寻找，如果当前目录下没有找到，那么，make还会在下面的几个目录下找：

1.如果make执行时，有“-I”或“--include-dir”参数，那么make就会在这个参数所指定的目录下去寻找。

2.如果目录/include（一般是：/usr/local/bin或/usr/include）存在的话，make也会去找。

 如果有文件没有找到的话，make会生成一条警告信息，但不会马上出现致命错误。它会继续载入其它的文件，一旦完成makefile的读取，make会再重试这些没有找到，或是不能读取的文件，如果还是不行，make才会出现一条致命信息。如果你想让make不理那些无法读取的文件，而继续执行，你可以在include前加一个减号“-”。如：

-include<filename>

其表示，无论include过程中出现什么错误，都不要报错继续执行。和其它版本make兼容的相关命令是sinclude，其作用和这一个是一样的。



### 环境变量 MAKEFILES

​		如果你的当前环境中定义了环境变量MAKEFILES，那么，make会把这个变量中的值做一个类似于include的动作。这个变量中的值是其它的Makefile，用空格分隔。只是，它和include不同的是，从这个环境变中引入的Makefile的“目标”不会起作用，如果环境变量中定义的文件发现错误，make也会不理。

​		但是在这里我还是建议不要使用这个环境变量，因为只要这个变量一被定义，那么当你使用make时，所有的Makefile都会受到它的影响，这绝不是你想看到的。在这里提这个事，只是为了告诉大家，也许有时候你的Makefile出现了怪事，那么你可以看看当前环境中有没有定义这个变量。

### make的工作方式

GNU的make工作时的执行步骤如下：

1. 读入所有的Makefile。
2. 读入被include的其它Makefile。
3. 初始化文件中的变量。
4. 推到隐晦规则，并分析所有规则。
5. 为所有的目标文件创建依赖关系链。
6. 根据依赖关系，决定哪些目标要重新生成的。
7. 执行生成命令。

1-5步为第一个阶段，6-7为第二个阶段。第一个阶段中，如果定义的变量被使用了，那么，make会把其展开在使用的位置。但make并不会完全马上展开，make使用的是拖延战术，如果变量出现在依赖关系的规则中，那么仅当这条依赖被决定要使用了，变量才会在其内部展开。

当然，这个工作方式你不一定要清楚，但是知道这个方式你也会对make更为熟悉。有了这个基础，后续部分也就容易看懂了。





## Makefile书写规则

规则包含两个部分，一个是依赖关系，一个是生成目标的方法。

​		在Makefile中，规则的顺序是很重要的，因为Makefile中应该有一个最终目标，其它的目标都是被这个目标所连带出来的，所以一定要让make知道你的最终目标是什么，一般来说，定义在Makefile中的目标可能会有很多，但是第一条规则中的目标将确立为最终的目标，如果第一条规则中的目标有很多个，那么第一个目标会成为最终的目。make所完成的也就是这个目标。



### 规则的语法

``` makefile
targets : prerequisites
       command
       ...
#或者是这样的：
targets : prerequisites ; command
           command
           ...
```

​	targets是文件名，以空格分开，可以使用通配符。一般来说，我们的目标基本上是一个文件，但也有可能是多个文件。
command是命令行，如果其不与“target:prerequisites”在一行，那么，必须以[Tab键]开头，如果和prerequisites在一行，那么可以用分号做为分隔。（见上）

​	prerequisites也就是目标所依赖的文件（或依赖目标）。如果其中的某个文件要比目标文件要新，那么，目标就被认为是“过时的”，被认为是需要重生成的。这个在前面已经讲过了。

​	如果命令太长，你可以使用反斜框（‘\’）作为换行符。make对一行上有多少个字符没有限制。规则告诉make两件事，文件的依赖关系和如何成成目标文件。
一般来说，make会以UNIX的标准Shell，也就是/bin/sh来执行命令。



### 在规则中使用通配符

如果我们想要定义一系列比较类似的文件，我们很自然地就想起使用通配符。make支持三各通配符：" * "," ? "," [...] "。这是和UNIX的bshell是相同的。

**" ~ "**

波浪号（“~”）字符在文件名中也有比较特殊的用途。如果是“~/test”，这就表示当前用户的$HOME目录下的test目录。而“~hchen/test”则表示用户hchen的宿主目录下的test目录。（这些都是Unix下的小知识了，make也支持）而在Windows或是MS-DOS下，用户没有宿主目录，那么波浪号所指的目录则根据环境变量“HOME”而定。

**" \* "**
通配符代替了你一系列的文件，如“*.c”表示所以后缀为c的文件。一个需要我们注意的是，如果我们的文件名中有通配符，如：“*”，那么可以用转义字符“\”，如“\*”来表示真实的“*”字符，而不是任意长度的字符串。



### 文件搜寻

 	在一些大的工程中，有大量的源文件，我们通常的做法是把这许多的源文件分类，并存放在不同的目录中。所以，当make需要去找寻文件的依赖关系时，你可以在文件前加上路径，但最好的方法是把一个路径告诉make，让make在自动去找。

​	Makefile文件中的特殊变量“VPATH”就是完成这个功能的，如果没有指明这个变量，make只会在当前的目录中去找寻依赖文件和目标文件。如果定义了这个变量，那么，make就会在当当前目录找不到的情况下，到所指定的目录中去找寻文件了。

``` makefile
VPATH = src:../headers
```

上面的的定义指定两个目录，“src”和“../headers”，make会按照这个顺序进行搜索。目录由“冒号”分隔。（当然，当前目录永远是最高优先搜索的地方）

另一个设置文件搜索路径的方法是使用make的“vpath”关键字（注意，它是全小写的），这不是变量，这是一个make的关键字，这和上面提到的那个VPATH变量很类似，但是它更为灵活。它可以指定不同的文件在不同的搜索目录中。这是一个很灵活的功能。它的使用方法有三种：

``` makefile
1.vpath < pattern> < directories>    #为符合模式< pattern>的文件指定搜索目录<directories>。
2.vpath < pattern>                   #清除符合模式< pattern>的文件的搜索目录。
3.vpath                              #清除所有已被设置好了的文件搜索目录。
```

vapth使用方法中的< pattern>需要包含“%”字符。“%”的意思是匹配零或若干字符，例如，“%.h”表示所有以“.h”结尾的文件。< pattern>指定了要搜索的文件集，而< directories>则指定了的文件集的搜索的目录。例如：

``` makefile
vpath %.h ../headers
```

该语句表示，要求make在“../headers”目录下搜索所有以“.h”结尾的文件。（如果某文件在当前目录没有找到的话）

我们可以连续地使用vpath语句，以指定不同搜索策略。如果连续的vpath语句中出现了相同的< pattern>，或是被重复了的< pattern>，那么，make会按照vpath语句的先后顺序来执行搜索。如：

``` makefile
vpath %.c foo
vpath %  blish
vpath %.c bar
```

其表示“.c”结尾的文件，先在“foo”目录，然后是“blish”，最后是“bar”目录。

``` makefile
vpath %.c foo:bar
vpath %   blish
```

而上面的语句则表示“.c”结尾的文件，先在“foo”目录，然后是“bar”目录，最后才是“blish”目录。







### configure 、make 、 make install背后的原理

```shell
./configure 
make
make install
```

1. 配置

   configure脚本负责在你使用的系统上准备好构建的环境。确保接下来的构建和安装过程所需要的依赖准备好，并搞清楚使用这些依赖需要的东西。

2. 构建

   但configure配置完毕后，可以使用make执行构建，这个过程会执行在makefile文件中定义的一系列任务将软件源代码编译成可执行文件。

   一般下载的源码包是没有一个最终的makefile文件，一般是一个模板文件makefile.in文件，然后configure根据系统的参数生成一个定制化的Makefile文件。

3. 安装

   ​		现在软件已经被构建好了并且可以执行，接下来要做的就是将可执行文件**复制到最终的路径**。make install命令就是将可执行文件、第三方依赖包和文档复制到正确的路径。如果没有指定路径的话，默认是在这个路径下**(/usr/local)**。

   ​		这通常意味着，可执行文件被复制到某个path包含的路径，程序的调用文档被复制到某个MANPATH包含的路径，还有程序依赖的文件也会被存放在合适的路径。

   ​		因为安装这一步也是被定义在Makefile中，所以程序安装的路径可以通过configure命令的参数指定，或者configure通过系统参数决定。

   ​		如果要将可执行文件安装在系统路径，执行这步需要赋予相应的权限，一般都是通过sudo



这些脚本是怎么产生的呢

​		安装过程简单的说就是configure脚本根据系统信息将Makefile.in模板文件转化为Makefile文件，但是configure和Makefile.in模板文件转换为Makefile文件。

​		详细过程可以看这个链接https://zhuanlan.zhihu.com/p/77813702

下面分别展示下软件发布和安装的命令：

#### 发布命令：

```shell
aclocal #设置m4环境
autoconf  #生成configure脚本
automake   --add-missing   #生成Makefile.in脚本
./configure  #生成Makfile脚本
make distcheck    #使用Makefile构建一个发布软件并测试
```

#### 安装

```shell
./configure  # 生成 Makefile 脚本 和 测试环境
make #构建软件
make install  #使用Makefile 安装软件
```



再来一张图

![image-20210805095920337](C:\Users\wsrnd\AppData\Roaming\Typora\typora-user-images\image-20210805095920337.png)

