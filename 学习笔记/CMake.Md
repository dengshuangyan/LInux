cmake中的add_library target_link_libraries  link_directories

## **add_library**

​		该指令的主要作用是将指定的源文件生成链接文件，然后添加到工程中去。

## **link_directories**

​		该指令的作用主要是指定要链接的库文件的路径。该指令有时候不一定需要 。

## **target_link_libraries**

​		该指令的作用为将目标文件与库文件进行链接。该指令的语法如下：

​		target_link_libraries(<target> [item1] [item2] [...]
​          			[[debug|optimized|general] <item>] ...)

​	上述指令中的<target>是指通过add_executable() 和 add_library()指令生成的已经创建的目标文件。而[item]表示库文件没有后缀的名字，默认情况下，库依赖项是传递的。当这个目标链接到另一个目标时，链接到这个目标的库也会出现在另一个目标的链接线上。这个传递的接口储存再interface_link_libraries的目标属性中，可以通过设置该属性值直接重写传递接口。





## find_package

使用背景：当编译需要使用第三方的软件时，也就是编译软件使用了外部库，事先不知道它的头文件和链接库的位置，所以需要在编译命令中加上它们的查找命令。Cmake使用了find_package命令来解决这个问题





# BASE

在知乎上看到了new baby怎么学习cmake，跟着大佬的步伐来到了GitHub的一个仓库。现在已经获得了6k个star，

https://github.com/ttroy50/cmake-examples/tree/master  就是这个。

## A-hello-cmake

好了，要开始学习了，从这个hello cmake开始。

```cmake
cmake_minmum_required(VERSION 3.0)
#When creating a project using CMake, you can specify the minimum version of CMake that is supported.
```

使用CMake创建项目时，可以指定支持的CMake的最低版本



```cmake
project(hello_cmake)
#A CMake build can include a project name to make referencing certain variables easier when using #multiple projects.
```

CMake构建可以包含项目名称，以便在使用多个项目时更容易引用某些变量



```cmake
add_executable(hello_cmake main.cpp)
#The add_executable() command specifies that an executable should be build from the specified source #files, in this example main.cpp. The first argument to the add_executable() function is the name of the #executable to be built, and the second argument is the list of source files to compile.
```

add_executable（）命令==指定应从指定的源文件生成可执行文件==，在本例中为main.cpp。add_executable（）函数的第一个参数是要生成的可执行文件的名称，第二个参数是要编译的==源文件列表==。

Binary Directory

The root or top level folder that you run the cmake command from is known as your CMAKE_BINARY_DIR and is the root folder for all your binary files. CMake supports building and generating your binary files both in-place and also out-of-source.

​		运行cmake命令的根文件夹或顶级文件夹称为cmake_BINARY_DIR，是所有二进制文件的根文件夹。CMake支持就地和异地构建和生成二进制文件。

In-place builds generate all temporary build files in the same directory structure as the source code. This means that all Makefiles and object files are interspersed with your normal code. To create an in-place build target run the cmake command in your root directory. 

​		就地生成在与源代码相同的目录结构中生成所有临时生成文件。这意味着所有的makefile和object文件都散布在普通代码中。要创建就地生成目标，请在根目录中运行cmake命令

Out-of-source builds allow you to create a single build folder that can be anywhere on your file system. All temporary build and object files are located in this directory keeping your source tree clean. To create an out-of-source build run the cmake command in the build folder and point it to the directory with your root CMakeLists.txt file. Using out-of-source builds if you want to recreate your cmake environment from scratch, you only need to delete your build directory and then rerun cmake.

​		源代码外生成允许您创建单个生成文件夹，该文件夹可以位于文件系统的任何位置。所有临时生成和对象文件都位于该目录中，以保持源代码树的干净。要创建源代码外构建，请在build文件夹中运行cmake命令，并将其指向根CMakeLists.txt文件所在的目录。如果您想从头开始重新创建cmake环境，则只需删除生成目录，然后重新运行cmake即可。







## B-hello-headers



CMake语法指定了许多变量，可用于帮助在项目或源代码树中查找有用的目录。其中包括:

| 变量                     | 表示                                                         |
| ------------------------ | ------------------------------------------------------------ |
| CMAKE_SOURCE_DIR         | the root source directory                                    |
| CMAKE_CURRENT_SOURCE_DIR | 当前源目录（如果使用子项目和目录）                           |
| PROJECT_SOURCE_DIR       | The source directory of the current cmake project.当前cmake项目的源目录 |
| CMAKE_BINARY_DIR         | The root binary / build directory. This is the directory where you ran the cmake command. |
| CMAKE_CURRENT_BINARY_DIR | The build directory you are currently in.您当前所在的生成目录。 |
| PROJECT_BINARY_DIR       | The build directory for the current project.当前项目的生成目录 |



Creating a variable which includes the source files allows you to be clearer about these files and easily add them to multiple commands, for example, the add_executable() function.

通过创建包含源文件的变量，可以更清楚地了解这些文件，并轻松地将它们添加到多个命令中，例如，add_executable（）函数。

```cmake
set(SOURCES
	src/Hello.cpp
	src/main.cpp
)

add_executable(${PROJECT_NAME} %{SOURCES})
```



When you have different include folders, you can make your compiler aware of them using the target_include_directories() [function](https://cmake.org/cmake/help/v3.0/command/target_include_directories.html). When compiling this target this will add these directories to the compiler with the -I flag e.g. `-I/directory/path`
	当您有不同的包含文件夹时，可以使用target_include_directories（）函数使编译器知道它们。编译此目标时，这将使用-I标志将这些目录添加到编译器中，例如-I/directory/path

```cmake
target_include_directories(target 
	PRIVATE
		${PROJECT_SOURCE_DIR}/include
)
```

==将指定编译给定目标时要使用的包含目录==.  这里是加入了头文件

在前面的示例中，当运行make命令时，输出仅显示生成的状态。要查看完整输出以进行调试，可以在运行make时添加==VERBOSE=1==标志。







## C-static-library

The add_library() function is used to create a library from some source files. This is called as follows:
add_library（）函数用于从一些源文件创建库.

```cmake
add_library(hello_library STATIC
	src/Hello.cpp
)
#This will be used to create a static library with the name libhello_library.a with the sources in the add_library call.
```

In this example, we include directories in the library using the target_include_directories() function with the scope set to PUBLIC.
在本例中，我们使用target_include_directories（）函数将目录包含在库中，其作用域设置为PUBLIC

```cmake
target_include_directories(hello_library
	PUBLIC
		${PROJECT_SOURCE_DIR}/include
)
```

This will cause the included directory used in the following places:  这将导致在以下位置使用包含的目录

- When compiling the library   在编译库时
- When compiling any additional target that links the library.    编译链接库的任何其他目标时

The meaning of scopes are:        作用域的含义是

- PRIVATE - the directory is added to this target’s include directories   该目录将添加到此目标的包含目录中
- INTERFACE - the directory is added to the include directories for any targets that link this library.该目录将添加到链接此库的任何目标的包含目录中。
- PUBLIC - As above, it is included in this library and also any targets that link this library.如上所述，它包括在此库中，也包括链接此库的任何目标。





When creating an executable that will use your library you must tell the compiler about the library. This can be done using the target_link_libraries() function.
创建将使用库的可执行文件时，必须向编译器说明库的相关信息。这可以使用target_link_libraries（）函数完成。

```cmake
add_executable(hello_library
	src/main.cpp
)

target_link_libraries(
	PRIVATE
		hello_library
)

```

This tells CMake to link the hello_library against the hello_binary executable during link time. It will also propagate any include directories with PUBLIC or INTERFACE scope from the linked library target.
		这会告诉CMake在链接期间将hello_库链接到hello_二进制可执行文件。它还将从链接库目标传播任何具有公共或接口作用域的include目录

```cmake
add_library() #将代码转换为库文件，
target_link_libraries() #将target和库链接起来。
```









## D-shared-library

​	这一节跟上一节类似，只不过这次用add_library()生成的是动态库，

​	只不过这一节加了一个alias Target  
​		As the name suggests an [alias target](https://cmake.org/cmake/help/v3.0/manual/cmake-buildsystem.7.html#alias-targets) is an alternative name for a target that can be used instead of the real target name in read-only contexts.
​	值得注意的是，这里是给target设置别名，而且是以==只读内容==的方式。

所以有一些命令是不能用别名的，比如tartget_include_directories就不能用别名。

```cmake
add_library(hello::library ALIAS hello_library) #给hello_library设置别名。

target_link_libraries(hello_binary
	PRIVATE
		hello::library
)
```





## E-hello-installing

这一节主要讲了怎么使用install()命令来安装目标

CMake offers the ability to add a `make install` target to allow a user to install binaries, libraries and other files. The base install location is controlled by the variable CMAKE_INSTALL_PREFIX which can be set using ccmake or by calling cmake with `cmake .. -DCMAKE_INSTALL_PREFIX=/install/location`
		CMake提供了添加make安装目标的功能，允许用户安装二进制文件、库和其他文件。基本安装位置由变量CMAKE_install_PREFIX控制，该前缀可以使用ccmake或使用CMAKE调用CMAKE进行设置-DCMAKE_INSTALL_PREFIX=/INSTALL/location

```cmake
install(TARGETS 自定义目标名
	DESTINTION bin)
```

Install the binary generated from the target cmake_examples_inst_bin target to the destination ${CMAKE_INSTALL_PREFIX}/bin
上面是将从目标cmake_examples_inst_bin目标生成的二进制文件安装到目标${cmake_Install_PREFIX}/bin

```cmake
install(TARGETS	自定义目标文件
	LIBRARY DESTINATION lib)
#Install the shared library generated from the target cmake_examples_inst target to the destination #${CMAKE_INSTALL_PREFIX}/lib
#将从目标cmake_examples_inst目标生成的共享库安装到目标${cmake_Install_PREFIX}/lib
```

还有一些install的参数没有一一列出，在写好了install命令之后就可以make install 了，默认路径下，安装在/usr/local目录下。



## F-build-type

		CMake 具有许多内置的构建配置，可用于编译工程。这些配置指定了代码优化的级别，以及调试信息是否包含在二进制文件中，


在编译器中使用命令： 

- Release —— 不可以打断点调试，程序开发完成后发行使用的版本，占的体积小。 它对代码做了优化，因此速度会非常快，-O3 -DNDEBUG 可选择此版本。

- Debug ——调试的版本，体积大。在编译器中使用命令： -g 可选择此版本。

- MinSizeRel—— 最小体积版本，在编译器中使用命令：-Os -DNDEBUG可选择此版本。

- RelWithDebInfo—— 既优化又能调试。在编译器中使用命令：-O2 -g -DNDEBUG可选择此版本。

CMake提供的默认构建类型是不进行优化的构建级别。独有某些项目，需要自己设置默认的构建类型，一遍不必记住进行设置。

### ==set命令== 

set()该命令可以为普通变量、缓存变量、环境变量赋值

1. 正常变量：设置的变量值 作用域属于整个CMakeLists.txt,当这个语句中加入了PARENT_SCOPE后，表示要设置的变量是父目录中的CMakeLists.txt设置的变量。

2. 缓存变量：在运行cmake的时候，变量的值可能会被缓存到一份文件里即build命令下的CMakeCache.txt，当你重新运行cmake的时候那些变量就会默认使用这个缓存里的值。这个变量是全局变量，整个cmake工程都可以使用该变量。

   ```cmake
   set(<variable> <value>... CACHE <type> <docstring> [FORCE])
   ```

   ​		在这个文件中，如果设置set(CMAKE_INSTALL_PREFIX "/usr")虽然CACHE缓存文件里面还有这个CMAKE_INSTALL_PREFIX变量，但是因为我们显式的设置了一个名为CMAKE_INSTALL_PREFIX的正常变量，之后使用CMAKE_INSTALL_PREFIX,值是我们设置的正常变量的值。

   ​		如果加上CACHE关键字，则设置这个变量会被写入缓存文件中（但是如果本身缓存文件中有这个变量，则不会覆盖缓存中的变量）。只有加上FORCE关键字，这个被写入文件的值就会覆盖之前的文件中存在的同名变量。

   ​		加上CACHE关键字，<type> 和 <decstring> 是必须的。

   

被 CMake GUI 用来选择一个窗口，让用户设置值。可以有5种选项。其中一个是STRING ，弹出提示消息。

- 为BOOL，则为布尔`ON/OFF`值。 [`cmake-gui(1)`](https://cmake.org/cmake/help/latest/manual/cmake-gui.1.html#manual:cmake-gui(1)) 提供一个复选框。
- 为FILEPATH，则为磁盘上文件的路径。 [`cmake-gui(1)`](https://cmake.org/cmake/help/latest/manual/cmake-gui.1.html#manual:cmake-gui(1)) 提供一个文件对话框。
- 为 PATH ，则为磁盘上目录的路径。 [`cmake-gui(1)`](https://cmake.org/cmake/help/latest/manual/cmake-gui.1.html#manual:cmake-gui(1)) 提供一个文件对话框。
- 为 STRING ，则为一行文字。 [`cmake-gui(1)`](https://cmake.org/cmake/help/latest/manual/cmake-gui.1.html#manual:cmake-gui(1)) 提供文本字段或下拉选择（如果 [`STRINGS`](https://cmake.org/cmake/help/latest/prop_cache/STRINGS.html#prop_cache:STRINGS) 设置了缓存条目属性。）
- 为 INTERNAL ，则为一行文字。 [`cmake-gui(1)`](https://cmake.org/cmake/help/latest/manual/cmake-gui.1.html#manual:cmake-gui(1))不显示内部条目。它们可用于在运行之间持久存储变量。使用此类型暗含`FORCE`

就如这个文件中的

```cmake
set(CMAKE_BUILD_TYPE RelWithDebInfo CACHE STRING "Choose the type of build." FORCE)

 set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Release"
    "MinSizeRel" "RelWithDebInfo")
```

由CACHE关键字可以看出set命令在设置一个缓存变量，将这个变量设置为RelWithDebInfo，因为用了FORCE所以我们是知道，这是强制覆盖了缓存中的CMAKE_BUILD_TYPE的值，而`STRING "Choose the type of build."`参数在使用cmake-gui的时候起作用，在界面上会出现一个下拉框供给用户选择来设置CMAKE_BUILD_TYPE变量。里的一行文字作为提示。

但是这个下拉框里的内容，需要使用随后的set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Release" "MinSizeRel" "RelWithDebInfo")这个命令来设置。也就是所谓的设置string缓存条目属性。



3. ```cmake
   set(ENV{<variable>} [<value>])
   #设置一个Environment Variable 到给定值，随后的调用$ENV{<varible>}将返回此值 
   #此命令仅影响当前的CMake进程，不影响调用CMake的进程，也不影响整个系统环境，也不影响后续构建或测试过程的环##境。
   
   #如果在空字符串之后ENV{}或如果没有参数``，则此命令将清除环境变量的任何现有值。之后``的参数将被忽略。如果发#现其他参数，则会发出作者警告。
   
   ```

   





## G-compile-flags

CMake supports setting compile flags in a number of different ways:    CMAKE支持一多种不同的方式设置编译标志。

- using target_compile_definitions() function
- using the CMAKE_C_FLAGS and CMAKE_CXX_FLAGS variables.

在现代CMAKE中设置C++标志的推荐方法是使用可以通过==target_compile_definitions==,This will populate the [INTERFACE_COMPILE_DEFINITIONS](https://cmake.org/cmake/help/v3.0/prop_tgt/INTERFACE_COMPILE_DEFINITIONS.html#prop_tgt:INTERFACE_COMPILE_DEFINITIONS) for the library and push the definition to the linked target depending on the scope.

```cmake
target_compile_definitions(target 
	PRIVATE EX3
	)
```

This will cause the compiler to add the definition -DEX3 when compiling the target.  这将导致编译器在编译目标时添加定义-DEX3。

If the target was a library and the scope PUBLIC or INTERFACE has been chosen the definition would also be included in any executables that link this target.
如果目标是一个库，并且选择了范围公共或接口，那么定义也将包含在链接此目标的任何可执行文件中。

For compiler options you can also use the target_compile_options() [function](https://cmake.org/cmake/help/v3.0/command/target_compile_options.html).对于编译器选项，还可以使用target_compile_options（）函数。





The default `CMAKE_CXX_FLAGS` is either empty or contains the appropriate flags for the build type.默认的CMAKE_CXX_标志为空或包含生成类型的相应标志。

To set additional default compile flags you can add the following to your top level CMakeLists.txt 要设置其他默认编译标志，可以将以下内容添加到顶级CMakeLists.txt

```cmake
set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DEX2" CACHE STRING "Set C++ Compiler Flags" FORCE)
```

与CMAKE_CXX_标志类似，其他选项包括：

- Setting C compiler flags using CMAKE_C_FLAGS
- Setting linker flags using CMAKE_LINKER_FLAGS.

Once set the CMAKE_C_FLAGS and CMAKE_CXX_FLAGS will set a compiler flag / definition globally for all targets in this directory or any included sub-directories. This method is not recommended for general usage now and the target_compile_definitions function is preferred.
设置CMAKE_C_标志和CMAKE_CXX_标志后，将为该目录或任何包含的子目录中的所有目标全局设置编译器标志/定义。现在不建议将此方法用于一般用途，最好使用target_compile_definitions函数。

```cmake
cmake_minimum_required(VERSION 3.5)

# Set a default C++ compile flag
set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DEX2" CACHE STRING "Set C++ Compiler Flags" FORCE)

# Set the project name
project (compile_flags)

# Add an executable
add_executable(cmake_examples_compile_flags main.cpp)

target_compile_definitions(cmake_examples_compile_flags 
    PRIVATE EX3
)
```

简单的讲，就是使用cmake定义宏。





## H-third-party-library

Nearly all non-trivial projects will have a requirement for including third party libraries, headers, or programs. CMake has support for finding the path to these tools using the `find_package()` function. This will search for CMake modules in the format "FindXXX.cmake" from the list of folders in `CMAKE_MODULE_PATH`. On linux the default search path will include `/usr/share/cmake/Modules`.
		几乎所有非平凡的项目都需要包含第三方库、头或程序。CMake支持使用find_package（）函数查找这些工具的路径。这将从CMake_模块_路径中的文件夹列表中搜索格式为“FindXXX.CMake”的CMake模块。在linux上，默认搜索路径将包括/usr/share/cmake/Modules。

As mentioned above the `find_package()` function will search for CMake modules in the formant "FindXXX.cmake" from the list of folders in `CMAKE_MODULE_PATH`. The exact format of the arguments to `find_package` will depend on the module you are looking for. This is typically documented at the top of the `FindXXX.cmake` file.

A basic example of finding boost is below:

```cmake
find_package(Boost 1.46.1 REQUIRED COMPONENTS filesystem system)
```

The arguments are:

- Boost - Name of the library. This is part of used to find the module file FindBoost.cmake  库的名称。这是用于查找模块文件FindBoost.cmake的部分
- 1.46.1 - The minimum version of boost to find    要查找的boost的最低版本
- REQUIRED - Tells the module that this is required and to fail it it cannot be found   告诉模块这是必需的，如果失败，则无法找到
- COMPONENTS - The list of libraries to find.

Boost includes can take more arguments and also make use of other variables. More complex setups are provided in later examples.







**checking if the package is found**

​    Most included packages will set a variable `XXX_FOUND`, which can be used to check if the package is available on the system.
In this example the variable is `Boost_FOUND`:

```cmake
if (Boost_FOUND)
	message ("boost found")
	include_directories(${Boost_INCLUDE_DIRS})	
else()
	message(FAIAL_ERROR "Cannot find boost")
endif()
```



After a package is found it will often export variables which can inform the user where to find the library, header, or executable files. Similar to the `XXX_FOUND` variable, these are package specific and are typically documented at the top of the `FindXXX.cmake` file.

The variables exported in this example include:

- `Boost_INCLUDE_DIRS` - The path to the boost header files.

In some cases you can also check these variables by examining the cache using ccmake or cmake-gui.





Most modern CMake libraries [export](https://cmake.org/cmake/help/v3.6/prop_tgt/IMPORTED.html#prop_tgt:IMPORTED) ALIAS targets in their module files. The benefit of imported targets are that they can also populate include directories and linked libraries.

For example, starting from v3.5+ of CMake, the Boost module supports this. Similar to using your own ALIAS target for libraires, an ALIAS in a module can make referencing found targets easier.

In the case of Boost, all targets are exported using the `Boost::` identifier and then the name of the subsystem. For example you can use:

- `Boost::boost` for header only libraries
- `Boost::system` for the boost system library.
- `Boost::filesystem` for filesystem library.

As with your own targets, these targets include their dependencies, so linking against `Boost::filesystem` will automatically add `Boost::boost` and `Boost::system` dependencies.

To link against an imported target you can use the following:

```cmake
target_link_libraries(third_party_include 
	PRIVATE
		Boost::filesystem
)
```



While most modern libraries use imported targets, not all modules have been updated. In the case where a library hasn’t been updated you will often find the following variables available:

- xxx_INCLUDE_DIRS - A variable pointing to the include directory for the library.
- xxx_LIBRARY - A variable pointing to the library path.

These can then be added to your target_include_directories and target_link_libraries as:

```cmake
# Include the boost headers
target_include_directories( third_party_include
    PRIVATE ${Boost_INCLUDE_DIRS}
)

# link against the boost libraries
target_link_libraries( third_party_include
    PRIVATE
    ${Boost_SYSTEM_LIBRARY}
    ${Boost_FILESYSTEM_LIBRARY}
)
```



在这一节使用了find_package来用来查找依赖包的，一句find_package()把一整个依赖包的头文件包含路径、库库路径、库名字和版本号都获取到。

cmake本身不提供任何关于搜索库的便捷方法，也不会对库本身的环境变量进行设置。它仅仅是按照优先级顺序在指定的搜索路径进行查找Findxxx.cmake文件和xxxConfig.cmake文件(其中xxx代表库的名字，特别注意的是有大小写之分)，这两个文件大体上是没有区别的，cmake能够找到这两个文件中的任何一个，我们都能成功使用该库，也就是我们可以用库的内置好了Cmake变量。包含了库的头文件和库文件的路径信息，虽然库的作者一般会提供这两个文件，但是也会遇到安装完毕后找不到的情况。当我们在cmake..命令之后，Cmake 会读取执行CMakeLists.txt中的代码，当执行find_package()这条命令后,Cmake 就会从某些路径中找这Findxxx.cmake文件或者xxxConfig.cmake文件，Cmake找到任意一个之后就会执行这个文件，然后这个文件执行后就会设置好一些Cmake变量。

一般常用的就是xxx_FOUND 、xxx_INCLUDE_DIRS、xxx_LIBS，分别代表是否找到库的标志、库的头文件路径、库文件路径。

find_package()有两种模式:Module模式和Config模式，分别对应上面的Findxxx.cmake 和xxxConfig.cmake两个文件。cmake默认优先Module模式，而Config模式是备选项。

