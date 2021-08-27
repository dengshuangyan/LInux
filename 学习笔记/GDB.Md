## Gdb调试使用

### 1.当内存访问越界

发生错误时，可以使用breakstrace（bt）来显示程序出错的位置，从而帮助定位程序错误，配合frame使用。

### 2.断点调试命令 break 

### 3.查看命令print   display

display常用命令,使用时不用加<>

![image-20210710110812553](C:\Users\wsrnd\AppData\Roaming\Typora\typora-user-images\image-20210710110812553.png)

display 是设置了要显示的变量后，在运行过程中如果遇到了这个变量就会自动打印出来。

print是直接显示当前设置变量的值，需要主要的是，break值显示当前停止内容的变量。

### 4.查看源程序命令

list常用命令：list用来查看源代码

![image-20210710114657656](C:\Users\wsrnd\AppData\Roaming\Typora\typora-user-images\image-20210710114657656.png)

info line 命令用来查看源代码在内存中地址

disassemble查看源程序的当前执行时的机器码。

### 5.改变程序的执行

		#### 		5.1修改变量值

​				使用print命令，如print x = 8;将x的值修改为8。

		 ####         5.2跳转执行

​			jump <linespec>  or  <address>  修改程序执行的顺序，可以让程序执行随意跳跃。制定下一条语句的运行点。

		#### 		5.3产生信号量

​			sigal命令可以产生一个信号量给被调试的程序。语法为sigal <sigal> linux的系统信号量通常从1到15，所以<singal>的取值也在这个范围。
​			sigal命令和shell的kill命令不同，系统的kill命令发信号给被调试程序时，是由gdb获取的，而signal命令所发出的信号则是直接发给被调试程序的。

####        5.4强制函数返回

​				如果调试断点在某个函数中，还有语句没有执行完，可以使用return命令强制函数忽略还没有执行的语句并返回。return  <expression> 使用了return命令取消当前函数的执行，并立即返回，如果指定了<expression>，那么表达式的值就会被当做函数的返回值。

	####          5.5强制调用函数

​				强制调用函数使用call命令，格式如下 call <expression> 

​				表达式中也可以是函数，以达到强制调用函数的目的，并且显示函数的返回值，如果函数返回值时void，那么就不显示。

​			另一个相似的命令也可以完成这一功能，那就是之前学习过的print了，print后面可以跟函数。print与call不同之处是，如果函数返回值为void，call不显示，而print则显示函数返回值，并且把该值存入历史数据中。