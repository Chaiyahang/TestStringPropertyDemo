# TestStringPropertyDemo
我们在声明一个NSString属性时，对于其内存相关特性，通常有两种选择(基于ARC环境)：strong与copy。那这两者有什么区别呢？什么时候该用strong，什么时候该用copy呢

下边我们来做个实验：【运行 Demo 后，请横屏看结果。】

#### 第一步：

ARC 下,其输出结果为⤵️：

![](https://ww3.sinaimg.cn/large/006tKfTcly1fdpzrxkjkkj31120kuq38.jpg)



ARC 下，我们可以看到，不管是strong还是copy属性的对象，其指向的地址都是同一个，即为string指向的地址。

如果我们换作MRC环境，打印string的引用计数的话，会看到其引用计数值是3，即strong操作和copy操作都使原字符串对象的引用计数值加了1。



#### 第二步：

我们把string由不可变改为可变对象，看看会是什么结果。即将下面这一句

> NSString *string = [NSString stringWithFormat:@"Chaiyh"];

改成：

> NSMutableString *string = [NSMutableString stringWithFormat:@"Chaiyh"];

输出结果是：

![](https://ww2.sinaimg.cn/large/006tKfTcly1fdpztwitdlj31120kuweq.jpg)

可以发现，此时copy属性字符串已不再指向string字符串对象，而是深拷贝了string字符串，并让_copyedString对象指向这个字符串。在MRC环境下，打印两者的引用计数，可以看到string对象的引用计数是2，而_copyedString对象的引用计数是1。

此时，我们如果去修改string字符串的话，可以看到：因为_strongString与string是指向同一对象，所以_strongString的值也会跟随着改变(需要注意的是，此时_strongString的类型实际上是NSMutableString，而不是NSString)；而_copyedString是指向另一个对象的，所以并不会改变。



### 结论：

​	1、由于NSMutableString是NSString的子类，所以一个NSString指针可以指向NSMutableString对象，让我们的strongString指针指向一个可变字符串是OK的。

​	而上面的例子可以看出，当源字符串是NSString时，由于字符串是不可变的，所以，不管是strong还是copy属性的对象，都是指向源对象，copy操作只是做了次浅拷贝。

​	2、当源字符串是NSMutableString时，strong属性只是增加了源字符串的引用计数，而copy属性则是对源字符串做了次深拷贝，产生一个新的对象，且copy属性对象指向这个新的对象。另外需要注意的是，这个copy属性对象的类型始终是NSString，而不是NSMutableString，因此其是不可变的。

​	这里还有一个性能问题，即在源字符串是NSMutableString时候，strong是单纯的增加对象的引用计数，而copy操作是执行了一次深拷贝，所以性能上会有所差异。而如果源字符串是NSString时，则没有这个问题。

所以，在声明NSString属性时，到底是选择strong还是copy，可以根据实际情况来定。不过，一般我们将对象声明为NSString时，都不希望它改变，所以大多数情况下，我们建议用copy，以免因可变字符串的修改导致的一些非预期问题。