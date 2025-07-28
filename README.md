在`Lua 5.5.0`中实现了类似`C#`的`?.`语法，修改了一些`Lua`底层实现，已跑通部分`Lua`提供的测试用例。

博客指路 - [Lua实现类似C#的?.(Null条件运算符)语法 - lhh2001的博客](https://lhh2001.github.io/2025/07/25/Lua实现类似C-的-Null条件运算符-语法/)

博客中比较不同方法性能的代码 - [luatoy/benchmark/benchmark.lua](https://github.com/lhh2001/luatoy/blob/github/nilcondindex/benchmark/benchmark.lua)