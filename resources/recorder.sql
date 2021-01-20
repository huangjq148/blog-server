/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80019
 Source Host           : localhost:3306
 Source Schema         : recorder

 Target Server Type    : MySQL
 Target Server Version : 80019
 File Encoding         : 65001

 Date: 20/01/2021 23:12:33
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_article
-- ----------------------------
DROP TABLE IF EXISTS `t_article`;
CREATE TABLE `t_article`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `type` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `content` longtext CHARACTER SET utf8 COLLATE utf8_general_ci,
  `photoPath` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `contentText` longtext CHARACTER SET utf8 COLLATE utf8_general_ci,
  `clickCount` int(0) DEFAULT NULL,
  `sortNo` int(0) DEFAULT NULL,
  `createUser` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `createTime` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `updateTime` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_article
-- ----------------------------
INSERT INTO `t_article` VALUES ('0448d7c08b6211ea973e650c8a2f6d43', '使用proxy实现简易响应式asca', 't3', 'dqwdqwd', NULL, '//立即执行函数\n//!的作用是告诉javascript引擎这是一个函数表达式，不是函数声明，()、！、+、-等运算符都能实现这个作用，不过()是最安全的\n//在!function(){}后面加上()会立即调用这个函数\n//这样做可以模仿一个私有作用域，这样html文件引用多个js文件时便不会造成变量冲突\n!\nfunction() {\n    //canvas元素相关\n    //创建canvas元素，并设置canvas元素的id\n    var canvas = document.createElement(\"canvas\"),\n    context = canvas.getContext(\"2d\"),\n    attr = getAttr();\n    //设置创建的canvas的相关属性\n    canvas.id = \"c_n\" + attr.length;\n    canvas.style.cssText = \"position:fixed;top:0;left:0;z-index:\" + attr.z + \";opacity:\" + attr.opacity;\n    //将canvas元素添加到body元素中\n    document.getElementsByTagName(\"body\")[0].appendChild(canvas);\n    //该函数设置了canvas元素的width属性和height属性\n    getWindowWH();\n    //onresize 事件会在窗口或框架被调整大小时发生\n    //此处即为当窗口大小改变时，重新获取窗口的宽高和设置canvas元素的宽高\n    window.onresize = getWindowWH;\n    //该函数会得到引用了本文件的script元素，\n    //因为本文件中在赋值时执行了一次getScript函数，html文件引用本文件时，本文件之后的script标签还没有被浏览器解释，\n    //所以得到的script数组中，引用了本文的script元素在该数组的末尾\n    //该函数的用意为使开发者能直接修改在html中引入该文件的script元素的属性来修改画布的一些属性，画布的z-index，透明度和小方块数量，颜色\n    //与前面往body元素添加canvas元素的代码配合，当开发者想要使用该特效作为背景时，只需在html文件中添加script元素并引用本文件即可\n    function getAttr() {\n        let scripts = document.getElementsByTagName(\"script\"),\n        len = scripts.length,\n        script = scripts[len - 1]; //v为最后一个script元素，即引用了本文件的script元素\n        return {\n            length: len,\n            z: script.getAttribute(\"zIndex\") || -1,\n            opacity: script.getAttribute(\"opacity\") || 0.5,\n            color: script.getAttribute(\"color\") || \"0,0,0\",\n            count: script.getAttribute(\"count\") || 99\n        }\n    }\n    //获得窗口宽高，并设置canvas元素宽高\n    function getWindowWH() {\n        W = canvas.width = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth,\n        H = canvas.height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight\n    }\n    //生成随机位置的小方块\n    var random = Math.random,\n    squares = []; //存放小方块\n    //往squares[]数组放小方块\n    for (let p = 0; p < attr.count; p++) {\n        var square_x = random() * W,\n        //横坐标\n        square_y = random() * H,\n        //纵坐标\n        square_xa = 2 * random() - 1,\n        //x轴位移 -1,1\n        square_ya = 2 * random() - 1; //y轴位移\n        squares.push({\n            x: square_x,\n            y: square_y,\n            xa: square_xa,\n            ya: square_ya,\n            max: 6000\n        })\n    }\n    //生成鼠标小方块\n    var mouse = {\n        x: null,\n        y: null,\n        max: 20000\n    };\n    //获取鼠标所在坐标\n    window.onmousemove = function(i) {\n        //i为W3C DOM，window.event 为 IE DOM，以实现兼容IE\n        //不过目前似乎IE已经支持W3C DOM，我用的是IE11，我注释掉下一句代码也能实现鼠标交互效果，\n        //网上说7/8/9是不支持的，本人没有试验，\n        //当然加上是没有错的\n        i = i || window.event;\n        mouse.x = i.clientX;\n        mouse.y = i.clientY;\n    }\n    //鼠标移出窗口后，消除鼠标小方块\n    window.onmouseout = function() {\n        mouse.x = null;\n        mouse.y = null;\n    }\n    //绘制小方块，小方块移动(碰到边界反向移动)，小方块受鼠标束缚\n    var animation = window.requestAnimationFrame || window.webkitRequestAnimationFrame || window.mozRequestAnimationFrame || window.oRequestAnimationFrame || window.msRequestAnimationFrame ||\n    function(i) {\n        window.setTimeout(i, 1000 / 45)\n    }; //各个浏览器支持的requestAnimationFrame有所不同，兼容各个浏览器\n    function draw() {\n        //清除画布\n        context.clearRect(0, 0, W, H);\n        var w = [mouse].concat(squares); //连接(合并)鼠标小方块数组和其他小方块数组\n        var x, v, A, B, z, y;\n        //square属性表：x，y，xa，ya，max\n        squares.forEach(function(i) {\n            //实现小方块定向移动\n            i.x += i.xa;\n            i.y += i.ya;\n            // 控制小方块移动方向\n            // 当小方块达到窗口边界时，反向移动\n            i.xa = i.xa * (i.x > W || i.x < 0 ? -1 : 1);\n            i.ya = i.ya * (i.y > H || i.y < 0 ? -1 : 1);\n            //fillRect前两个参数为矩形左上角的x，y坐标，后两个分别为宽度和高度\n            //绘制小方块\n            context.fillRect(i.x - 0.5, i.y - 0.5, 1, 1);\n            //遍历w中所有元素\n            for (let n = 0; n < w.length; n++) {\n                x = w[n];\n                //如果x与i不是同一个对象实例且x的xy坐标存在\n                if (i !== x && null !== x.x && null !== x.y) {\n                    x_diff = i.x - x.x; //i和x的x坐标差\n                    y_diff = i.y - x.y; //i和x的y坐标差\n                    distance = x_diff * x_diff + y_diff * y_diff; //斜边平方\n                    if (distance < x.max) {\n                        //使i小方块受鼠标小方块束缚，即如果i小方块与鼠标小方块距离过大，i小方块会被鼠标小方块束缚,\n                        //造成 多个小方块以鼠标为圆心，mouse.max/2为半径绕成一圈\n                        if (x === mouse && distance > x.max / 2) {\n                            i.x = i.x - 0.03 * x_diff;\n                            i.y = i.y - 0.03 * y_diff;\n                        }\n                        A = (x.max - distance) / x.max;\n                        context.beginPath();\n                        //设置画笔的画线的粗细与两个小方块的距离相关，范围0-0.5，两个小方块距离越远画线越细，达到max时画线消失\n                        context.lineWidth = A / 2;\n                        //设置画笔的画线颜色为s.c即画布颜色，透明度为(A+0.2)即两个小方块距离越远画线越淡\n                        context.strokeStyle = \"rgba(\" + attr.color + \",\" + (A + 0.2) + \")\";\n                        //设置画笔的笔触为i小方块\n                        context.moveTo(i.x, i.y);\n                        //使画笔的笔触移动到x小方块\n                        context.lineTo(x.x, x.y);\n                        //完成画线的绘制，即绘制连接小方块的线\n                        context.stroke();\n                    }\n                }\n            }\n            //把i小方块从w数组中去掉\n            //防止两个小方块重复连线\n            w.splice(w.indexOf(i), 1);\n        });\n        //window.requestAnimationFrame与setTimeout相似，形成递归调用，\n        //不过window.requestAnimationFrame采用系统时间间隔，保持最佳绘制效率,提供了更好地优化，使动画更流畅\n        //经过浏览器优化，动画更流畅；\n        //窗口没激活时，动画将停止，省计算资源;\n        animation(draw);\n    }\n    //此处是等待0.1秒后，执行一次draw()，真正的动画效果是用window.requestAnimationFrame实现的\n    setTimeout(function() {\n        draw();\n    },\n    100)\n} ();', 0, NULL, '1', '2020-05-01 12:12:48', '2020-11-07 00:00:48');
INSERT INTO `t_article` VALUES ('2c21dbf07b2e11eaae4b77d51fd26c8b', '使用proxy实现简易响应式asca', 't3', 'dqwdqwd', NULL, '转Number类型\n\nString转化为Number；日期输出时间戳。\n\n \n\n会自动转化为Number类型的。日期取时间戳不用new Date().getTime()。、\n\n+\'45\'//45 \n\n+new Date() //自动转为13位的时间戳\n\n\n\n\n单行写一个评级组件\n\nlet rate = 3; \n\n\"★★★★★☆☆☆☆☆\".slice(5 - rate, 10 - rate);//\"★★★☆☆\"  \n\n\n\n\n数组去重\nlet array=[1, \"1\", 2, 1, 1, 3];\n//拓展运算符(...)内部使用for...of循环\n[...new Set(array)];//[1, \"1\", 2, 3]\n//利用Array.from将Set结构转换成数组\nArray.from(new Set(array));//[1, \"1\", 2, 3]\n\n\n', 0, NULL, NULL, '2020-04-10 21:21:22', '2020-11-07 00:00:48');
INSERT INTO `t_article` VALUES ('2e218de0896311ea89e8bd0b8d90be65', '使用proxy实现简易响应式asca', 't3', 'dqwdqwd', '/file/download/660101d97c5c48e6a2d0dacfb7e40bd3.jpg', '2020028，打卡第一天\n\n调整了表格的参数\n\n调整了后端文章相关的接口名称', 0, NULL, '1', '2020-04-28 23:16:05', '2020-11-07 00:00:48');
INSERT INTO `t_article` VALUES ('4213f240be8611ea9d1005c233e69009', 'js实现背景线条', 't3', '```javascript\n//立即执行函数\n//!的作用是告诉javascript引擎这是一个函数表达式，不是函数声明，()、！、+、-等运算符都能实现这个作用，不过()是最安全的\n//在!function(){}后面加上()会立即调用这个函数\n//这样做可以模仿一个私有作用域，这样html文件引用多个js文件时便不会造成变量冲突\n!\nfunction() {\n    //canvas元素相关\n    //创建canvas元素，并设置canvas元素的id\n    var canvas = document.createElement(\"canvas\"),\n    context = canvas.getContext(\"2d\"),\n    attr = getAttr();\n    //设置创建的canvas的相关属性\n    canvas.id = \"c_n\" + attr.length;\n    canvas.style.cssText = \"position:fixed;top:0;left:0;z-index:\" + attr.z + \";opacity:\" + attr.opacity;\n    //将canvas元素添加到body元素中\n    document.getElementsByTagName(\"body\")[0].appendChild(canvas);\n    //该函数设置了canvas元素的width属性和height属性\n    getWindowWH();\n    //onresize 事件会在窗口或框架被调整大小时发生\n    //此处即为当窗口大小改变时，重新获取窗口的宽高和设置canvas元素的宽高\n    window.onresize = getWindowWH;\n    //该函数会得到引用了本文件的script元素，\n    //因为本文件中在赋值时执行了一次getScript函数，html文件引用本文件时，本文件之后的script标签还没有被浏览器解释，\n    //所以得到的script数组中，引用了本文的script元素在该数组的末尾\n    //该函数的用意为使开发者能直接修改在html中引入该文件的script元素的属性来修改画布的一些属性，画布的z-index，透明度和小方块数量，颜色\n    //与前面往body元素添加canvas元素的代码配合，当开发者想要使用该特效作为背景时，只需在html文件中添加script元素并引用本文件即可\n    function getAttr() {\n        let scripts = document.getElementsByTagName(\"script\"),\n        len = scripts.length,\n        script = scripts[len - 1]; //v为最后一个script元素，即引用了本文件的script元素\n        return {\n            length: len,\n            z: script.getAttribute(\"zIndex\") || -1,\n            opacity: script.getAttribute(\"opacity\") || 0.5,\n            color: script.getAttribute(\"color\") || \"0,0,0\",\n            count: script.getAttribute(\"count\") || 99\n        }\n    }\n    //获得窗口宽高，并设置canvas元素宽高\n    function getWindowWH() {\n        W = canvas.width = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth,\n        H = canvas.height = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight\n    }\n    //生成随机位置的小方块\n    var random = Math.random,\n    squares = []; //存放小方块\n    //往squares[]数组放小方块\n    for (let p = 0; p < attr.count; p++) {\n        var square_x = random() * W,\n        //横坐标\n        square_y = random() * H,\n        //纵坐标\n        square_xa = 2 * random() - 1,\n        //x轴位移 -1,1\n        square_ya = 2 * random() - 1; //y轴位移\n        squares.push({\n            x: square_x,\n            y: square_y,\n            xa: square_xa,\n            ya: square_ya,\n            max: 6000\n        })\n    }\n    //生成鼠标小方块\n    var mouse = {\n        x: null,\n        y: null,\n        max: 20000\n    };\n    //获取鼠标所在坐标\n    window.onmousemove = function(i) {\n        //i为W3C DOM，window.event 为 IE DOM，以实现兼容IE\n        //不过目前似乎IE已经支持W3C DOM，我用的是IE11，我注释掉下一句代码也能实现鼠标交互效果，\n        //网上说7/8/9是不支持的，本人没有试验，\n        //当然加上是没有错的\n        i = i || window.event;\n        mouse.x = i.clientX;\n        mouse.y = i.clientY;\n    }\n    //鼠标移出窗口后，消除鼠标小方块\n    window.onmouseout = function() {\n        mouse.x = null;\n        mouse.y = null;\n    }\n    //绘制小方块，小方块移动(碰到边界反向移动)，小方块受鼠标束缚\n    var animation = window.requestAnimationFrame || window.webkitRequestAnimationFrame || window.mozRequestAnimationFrame || window.oRequestAnimationFrame || window.msRequestAnimationFrame ||\n    function(i) {\n        window.setTimeout(i, 1000 / 45)\n    }; //各个浏览器支持的requestAnimationFrame有所不同，兼容各个浏览器\n    function draw() {\n        //清除画布\n        context.clearRect(0, 0, W, H);\n        var w = [mouse].concat(squares); //连接(合并)鼠标小方块数组和其他小方块数组\n        var x, v, A, B, z, y;\n        //square属性表：x，y，xa，ya，max\n        squares.forEach(function(i) {\n            //实现小方块定向移动\n            i.x += i.xa;\n            i.y += i.ya;\n            // 控制小方块移动方向\n            // 当小方块达到窗口边界时，反向移动\n            i.xa = i.xa * (i.x > W || i.x < 0 ? -1 : 1);\n            i.ya = i.ya * (i.y > H || i.y < 0 ? -1 : 1);\n            //fillRect前两个参数为矩形左上角的x，y坐标，后两个分别为宽度和高度\n            //绘制小方块\n            context.fillRect(i.x - 0.5, i.y - 0.5, 1, 1);\n            //遍历w中所有元素\n            for (let n = 0; n < w.length; n++) {\n                x = w[n];\n                //如果x与i不是同一个对象实例且x的xy坐标存在\n                if (i !== x && null !== x.x && null !== x.y) {\n                    x_diff = i.x - x.x; //i和x的x坐标差\n                    y_diff = i.y - x.y; //i和x的y坐标差\n                    distance = x_diff * x_diff + y_diff * y_diff; //斜边平方\n                    if (distance < x.max) {\n                        //使i小方块受鼠标小方块束缚，即如果i小方块与鼠标小方块距离过大，i小方块会被鼠标小方块束缚,\n                        //造成 多个小方块以鼠标为圆心，mouse.max/2为半径绕成一圈\n                        if (x === mouse && distance > x.max / 2) {\n                            i.x = i.x - 0.03 * x_diff;\n                            i.y = i.y - 0.03 * y_diff;\n                        }\n                        A = (x.max - distance) / x.max;\n                        context.beginPath();\n                        //设置画笔的画线的粗细与两个小方块的距离相关，范围0-0.5，两个小方块距离越远画线越细，达到max时画线消失\n                        context.lineWidth = A / 2;\n                        //设置画笔的画线颜色为s.c即画布颜色，透明度为(A+0.2)即两个小方块距离越远画线越淡\n                        context.strokeStyle = \"rgba(\" + attr.color + \",\" + (A + 0.2) + \")\";\n                        //设置画笔的笔触为i小方块\n                        context.moveTo(i.x, i.y);\n                        //使画笔的笔触移动到x小方块\n                        context.lineTo(x.x, x.y);\n                        //完成画线的绘制，即绘制连接小方块的线\n                        context.stroke();\n                    }\n                }\n            }\n            //把i小方块从w数组中去掉\n            //防止两个小方块重复连线\n            w.splice(w.indexOf(i), 1);\n        });\n        //window.requestAnimationFrame与setTimeout相似，形成递归调用，\n        //不过window.requestAnimationFrame采用系统时间间隔，保持最佳绘制效率,提供了更好地优化，使动画更流畅\n        //经过浏览器优化，动画更流畅；\n        //窗口没激活时，动画将停止，省计算资源;\n        animation(draw);\n    }\n    //此处是等待0.1秒后，执行一次draw()，真正的动画效果是用window.requestAnimationFrame实现的\n    setTimeout(function() {\n        draw();\n    },\n    100)\n} ();\n```', NULL, '<html>\n\n\n<head>\n\n\n</head>\n\n\n<body>\n    <div id=\"app\">\n        {{name}}\n        <hr>\n        <span>{{name}}</span>\n        <hr>\n        <input type=\"text\" v-model=\"name\">\n        <hr>\n        <input type=\"text\" v-model=\"name\">\n        <hr>\n        <input type=\"button\" onclick=\"changeVal()\" value=\"测试按钮\">\n        <div>\n            <span>{{name}}</span>\n        </div>\n    </div>\n\n\n    <script>\n\n\n        class Watcher{\n            constructor(el,vm,valueName){\n                this.el = el;\n                this.vm = vm;\n                if(el.tagName===\"INPUT\"){\n                    this.type = \"value\";\n                }else{\n                    this.type = \"textContent\";\n                }\n                this.valueName = valueName;\n                this.update();\n            }\n\n\n            update(){\n                this.el[this.type] = this.vm.data[this.valueName];\n            }\n        }\n\n\n        class WatchTasks{\n            constructor(vm){\n                this.tasks = {};\n                this.vm = vm;\n            }\n\n\n            addTask(node, key){\n                !this.tasks[key] && (this.tasks[key] = []);\n                let watcher = new Watcher(node,this.vm,key)\n                this.tasks[key].push(watcher);\n            }\n\n\n            update(key){\n                this.tasks[key].map(item=>{\n                    item.update()\n                })\n            }\n        }\n\n\n        class Demo {\n            constructor(options = {}) {\n                this.$el = document.querySelector(options.el);\n                if (typeof options.data == \"function\") {\n                    this.data = options.data();\n                } else {\n                    this.data = options.data;\n                }\n                this.proxyData();\n                this.watchTasks = new WatchTasks(this);\n                this.compile(this.$el);\n            }\n\n\n            proxyData() {\n                const _this = this;\n                this.data = new Proxy(this.data, {\n                    get(target, key) {\n                        // console.log(`获取了属性${key},值为${target[key]}`)\n                        return target[key]\n                    },\n                    set(target, key, val) {\n                        // console.log(`设置了属性${key},值为${val}`)\n                        target[key] = val\n                        _this.watchTasks.update(key,val);\n                        return true;\n                    }\n                })\n            }\n\n\n            compile(el) {\n                const nodes = new Array(...el.childNodes)\n                const _this = this;\n                nodes.map(node => {\n                    if (node.nodeType === 3) {\n                        this.compileText(node, \"textContent\")\n                    } else if(node.nodeType === 1){\n                        if(node.childNodes.length> 0){\n                            this.compile(node)\n                        }\n                        if (node.hasAttribute(\"v-model\") && node.tagName === \"INPUT\") {\n                            let key = node.getAttribute(\"v-model\");\n                            this.watchTasks.addTask(node, key);\n                            node.addEventListener(\"keyup\",(e)=>{\n                                _this.data[key] = e.currentTarget.value;\n                            })\n                        }\n                    }\n                })\n            }\n\n\n            compileText(node, type) {\n                let matchs = node[type].match(/{{(\\S*)}}/);\n                let key = (matchs && matchs.length > 1) ? matchs[1].trim() : 0;\n                key && this.watchTasks.addTask(node, key);\n            }\n        }\n\n\n\n        const app = new Demo({\n            el: \"#app\",\n            data() {\n                return {\n                    name: \"黄坚强\",\n                    age: 27\n                }\n            }\n        })\n\n\n        function changeVal() {\n            app.data.name = \"aaa\"\n        }\n    </script>\n</body>\n\n\n</html>', 0, NULL, '1', '2020-07-05 14:10:43', '2020-11-07 07:00:11');
INSERT INTO `t_article` VALUES ('5ac73e40a31111ea8af06d7438d100b6', '使用proxy实现简易响应式asca', 't3', 'dqwdqwd', '/file/download/e4c12dcfcc65499597357dd4a130b084.png', '问题描述\n\n在前端开发中，固定位置布局(position:fixed)是常见的应用场景，特殊情况下，我们更需要将固守位置(fixed)的DIV水平居中布局？\n\n使用CSS如何实现将一个固定位置(position:fixed)的DIV水平居中布局呢？\n\n比如有如下的固定布局DIV:\n\n<div class=\"menu\">\n    ...\n</div>\n\n<style type=\"text/css\">\n.menu{\n    position:fixed;\n    width:800px;\n    top:0;\n}\n</style>\n\n方案一\n\n设置left和margin-left属性，如下：\n\nleft: 50%;\nmargin-left: -400px; /* 设置margin-left为整个DIV的一半 */\n\n方案二\n\n此方案为CSS3以下版的解决方案，但此方案适合所有的元素，包括没有with属性以及动态with的元素。\n\n水平居中：\n\nleft: 50%;\ntransform: translateX(-50%);\n\n\n垂直居中：\n\ntop: 50%;\ntransform: translateY(-50%);\n\n\n水平和垂直居中：\n\nleft: 50%;\ntop: 50%;\ntransform: translate(-50%, -50%);\n\n方案三\n\n设置left:0,right:0,margin:auto，如下：\n\n#menu {\n    position: fixed;   \n    left: 0;           \n    right: 0;           \n    top: 0px;         \n    width: 500px;      \n    margin: auto;      /* 水平居中 */\n    max-width: 100%;   \n    z-index: 10000;   \n}', 0, NULL, '1', '2020-05-31 15:35:52', '2020-11-07 00:00:48');
INSERT INTO `t_article` VALUES ('6e443630a31b11ea8af06d7438d100b6', '使用proxy实现简易响应式asca', 't3', 'dqwdqwd', NULL, '1. 强制不换行\ndiv{\n    white-space:nowrap;\n}\n2. 自动换行\ndiv{\n    word-wrap: break-word;\n    word-break: normal;\n}\n3. 强制英文单词断行\n div{\n    word-break:break-all;\n }\n4. CSS设置不转行：\noverflow:hidden 隐藏\nwhite-space：normal 默认\npre 换行和其他空白字符都将受到保护\nnowrap 强制在同一行内显示所有文本，直到文本结束或者遭遇 br 对象\n5. 设置强行换行：\nword-break:\nnormal：依照亚洲语言和非亚洲语言的文本规则，允许在字内换行\nbreak-all：该行为与亚洲语言的normal相同。也允许非亚洲语言文本行的任意字内断开。该值适合包含一些非亚洲文本的亚洲文本\nkeep-all：与所有非亚洲语言的normal相同。对于中文，韩文，日文，不允许字断开。适合包含少量亚洲文本的非亚洲文本与之间的高度解决办法\n英文不换行\nCSS里加上 word-break: break-all; 问题解决。这个问题只有IE才有，在FF下测试,FF可以自己加滚动条，这样也不影响效果\n\n建议大家做Skin时，记得在body里加 word-break: break-all; 这样可以解决IE的框架被英文撑开的问题\n\n以下引用word-break的说明, 注意word-break 是IE5+专有属性\n\n\n语法： word-break : normal | break-all | keep-all 参数： normal : 　依照亚洲语言和非亚洲语言的文本规则，允许在字内换行 break-all : 　该行为与亚洲语言的normal相同。也允许非亚洲语言文本行的任意字内断开。该值适合包含一些非亚洲文本的亚洲文本 keep-all : 　与所有非亚洲语言的normal相同。对于中文，韩文，日文，不允许字断开。适合包含少量亚洲文本的非亚洲文本 说明： 设置或检索对象内文本的字内换行行为。尤其在出现多种语言时。 对于中文，应该使用break-all 。', 0, NULL, '1', '2020-05-31 16:47:59', '2020-11-07 00:00:48');
INSERT INTO `t_article` VALUES ('7c6f25c0b84311eab22c5f97d38b0c88', '使用proxy实现简易响应式asca', 't3', 'dqwdqwd', NULL, 'function sort(arr){\n  	let length = arr.length;\n  	for(let i = 0; i < length; i++){\n    	for(let j=0; j < length-i; j++){\n        	let tmp = arr[j+1];\n          	if(tmp < arr[j]){\n              	tmp = arr[j];\n              	arr[j] = arr[j + 1];\n              	arr[j + 1] = tmp;\n            }\n        }\n    }\n	return arr;	\n}\n\n\nconsole.log(sort([9,2,11,18,3,17,8,80,20,5,15,24,6,1,7]))', 0, NULL, '1', '2020-06-27 14:57:37', '2020-11-07 00:00:48');
INSERT INTO `t_article` VALUES ('89a4d330a31611ea8af06d7438d100b6', '使用proxy实现简易响应式asca', 't3', 'dqwdqwd', '/file/download/e8fea6965de948e084f13aa419103deb.png', 'position 属性指定了元素的定位类型。\n\nposition 属性的五个值：\n\nstatic\nrelative\nfixed\nabsolute\nsticky\n\n元素可以使用的顶部，底部，左侧和右侧属性定位。然而，这些属性无法工作，除非是先设定position属性。他们也有不同的工作方式，这取决于定位方法。\n\n\n\n\nstatic 定位\n\nHTML 元素的默认值，即没有定位，遵循正常的文档流对象。\n\n静态定位的元素不会受到 top, bottom, left, right影响。\n\ndiv.static {\n    position: static;\n    border: 3px solid #73AD21;\n}\n\n\n\n\nfixed 定位\n\n元素的位置相对于浏览器窗口是固定位置。\n\n即使窗口是滚动的它也不会移动：\n\np.pos_fixed\n{\n    position:fixed;\n    top:30px;\n    right:5px;\n}\n\n注意： Fixed 定位在 IE7 和 IE8 下需要描述 !DOCTYPE 才能支持。\n\nFixed定位使元素的位置与文档流无关，因此不占据空间。\n\nFixed定位的元素和其他元素重叠。\n\n\n\n\nrelative 定位\n\n相对定位元素的定位是相对其正常位置。\n\nh2.pos_left\n{\n    position:relative;\n    left:-20px;\n}\nh2.pos_right\n{\n    position:relative;\n    left:20px;\n}\n\n移动相对定位元素，但它原本所占的空间不会改变。\n\nh2.pos_top\n{\n    position:relative;\n    top:-50px;\n}\n\n相对定位元素经常被用来作为绝对定位元素的容器块。\n\n\n\n\nabsolute 定位\n\n绝对定位的元素的位置相对于最近的已定位父元素，如果元素没有已定位的父元素，那么它的位置相对于<html>:\n\nh2\n{\n    position:absolute;\n    left:100px;\n    top:150px;\n}\n\nabsolute 定位使元素的位置与文档流无关，因此不占据空间。\n\nabsolute 定位的元素和其他元素重叠。\n\n\n\n\nsticky 定位\n\nsticky 英文字面意思是粘，粘贴，所以可以把它称之为粘性定位。\n\nposition: sticky; 基于用户的滚动位置来定位。\n\n粘性定位的元素是依赖于用户的滚动，在 position:relative 与 position:fixed 定位之间切换。\n\n它的行为就像 position:relative; 而当页面滚动超出目标区域时，它的表现就像 position:fixed;，它会固定在目标位置。\n\n元素定位表现为在跨越特定阈值前为相对定位，之后为固定定位。\n\n这个特定阈值指的是 top, right, bottom 或 left 之一，换言之，指定 top, right, bottom 或 left 四个阈值其中之一，才可使粘性定位生效。否则其行为与相对定位相同。\n\n注意: Internet Explorer, Edge 15 及更早 IE 版本不支持 sticky 定位。 Safari 需要使用 -webkit- prefix (查看以下实例)。\n\ndiv.sticky {\n    position: -webkit-sticky; /* Safari */\n    position: sticky;\n    top: 0;\n    background-color: green;\n    border: 2px solid #4CAF50;\n}\n\n\n\n\n\n重叠的元素\n\n元素的定位与文档流无关，所以它们可以覆盖页面上的其它元素\n\nz-index属性指定了一个元素的堆叠顺序（哪个元素应该放在前面，或后面）\n\n一个元素可以有正数或负数的堆叠顺序：\n\nimg\n{\n    position:absolute;\n    left:0px;\n    top:0px;\n    z-index:-1;\n}\n\n具有更高堆叠顺序的元素总是在较低的堆叠顺序元素的前面。\n\n注意： 如果两个定位元素重叠，没有指定z - index，最后定位在HTML代码中的元素将被显示在最前面。\n\n\n\n\n\n\n\n所有的CSS定位属性\n\n\"CSS\" 列中的数字表示哪个CSS(CSS1 或者CSS2)版本定义了该属性。\n\n属性	说明	值	CSS\nbottom	定义了定位元素下外边距边界与其包含块下边界之间的偏移。	auto\nlength\n%\ninherit	2\nclip	剪辑一个绝对定位的元素	shape\nauto\ninherit	2\ncursor	显示光标移动到指定的类型	url\nauto\ncrosshair\ndefault\npointer\nmove\ne-resize\nne-resize\nnw-resize\nn-resize\nse-resize\nsw-resize\ns-resize\nw-resize\ntext\nwait\nhelp	2\nleft	定义了定位元素左外边距边界与其包含块左边界之间的偏移。	auto\nlength\n%\ninherit	2\noverflow\n	设置当元素的内容溢出其区域时发生的事情。	auto\nhidden\nscroll\nvisible\ninherit	2\noverflow-y\n	指定如何处理顶部/底部边缘的内容溢出元素的内容区域	auto\nhidden\nscroll\nvisible\nno-display\nno-content	2\noverflow-x\n	指定如何处理右边/左边边缘的内容溢出元素的内容区域	auto\nhidden\nscroll\nvisible\nno-display\nno-content	2\nposition	指定元素的定位类型	absolute\nfixed\nrelative\nstatic\ninherit	2\nright	定义了定位元素右外边距边界与其包含块右边界之间的偏移。	auto\nlength\n%\ninherit	2\ntop	定义了一个定位元素的上外边距边界与其包含块上边界之间的偏移。	auto\nlength\n%\ninherit	2\nz-index	设置元素的堆叠顺序	number\nauto\ninherit	2', 0, NULL, '1', '2020-05-31 16:12:58', '2020-11-07 00:00:48');
INSERT INTO `t_article` VALUES ('8b3305b0781311eaa366b568abcf0f2e', '使用proxy实现简易响应式asca', 't3', 'dqwdqwd', NULL, '今天是2020年4月6日\n\n在家工作已两个月，两个月前，公司接了腾讯的防疫健康小程序，我们便进入了疯狂的加班阶段，一天17~8个小时成了家常便饭。\n\n这两个月内：\n\n学习了小程序的开发部署流程，开发记账小程序\n重新拾起了git，使用github pages部署了自己的前端工程\n重构了自己的node后端小框架\n学习了css，模拟淘宝首页写了个demo，\n学习了react基本搭建开发流程\n学习webpack的基本使用，终于稍微能看懂webpack的配置文件\n使用vue-cli + iview搭建了本项', 0, NULL, NULL, '2020-04-06 22:33:12', '2020-11-07 00:00:48');
INSERT INTO `t_article` VALUES ('8fde1f80b84311eab22c5f97d38b0c88', '使用proxy实现简易响应式asca', 't3', 'dqwdqwd', NULL, 'function sort(arr){\n  	let length = arr.length;\n  	let minIndex, tmp;\n  	\n  	for(let i = 0; i< length; i++){\n    	minIndex = i;\n      	for(let j = i+1;j < length; j++){\n        	if(arr[minIndex] > arr[j]){\n            	minIndex = j;\n            }\n        }\n      	tmp = arr[i];\n      	arr[i] = arr[minIndex];\n      	arr[minIndex] = tmp;\n    }\n	return arr;	\n}\n\n\nconsole.log(sort([9,2,11,18,3,17,8,80,20,5,15,24,6,1,7]))', 0, NULL, '1', '2020-06-27 14:58:10', '2020-11-07 00:00:48');
INSERT INTO `t_article` VALUES ('aefc3a10b88811eab22c5f97d38b0c88', 'js小技巧', 't2', '```javascript\n转Number类型\n\nString转化为Number；日期输出时间戳。\n\n \n\n会自动转化为Number类型的。日期取时间戳不用new Date().getTime()。、\n\n+\'45\'//45 \n\n+new Date() //自动转为13位的时间戳\n\n\n\n\n单行写一个评级组件\n\nlet rate = 3; \n\n\"★★★★★☆☆☆☆☆\".slice(5 - rate, 10 - rate);//\"★★★☆☆\"  \n\n\n\n\n数组去重\nlet array=[1, \"1\", 2, 1, 1, 3];\n//拓展运算符(...)内部使用for...of循环\n[...new Set(array)];//[1, \"1\", 2, 3]\n//利用Array.from将Set结构转换成数组\nArray.from(new Set(array));//[1, \"1\", 2, 3]\n\n\n\n```', NULL, 'function quick_sort(arr, from, to){\nif(from >= to)return;\n	let left = from,\n		right = to,\n		base = arr[from];\n	while(left < right){\n		while(arr[right]>= base && left < right){\n			right--;\n		}\n		arr[left] = arr[right];\n		while(arr[left]<= base && left < right){\n			left++;\n		}\n		arr[right] = arr[left];\n	}\n	arr[left] = base;\n    console.log(left,right,arr);\n	quick_sort(arr, from, left-1);\n	quick_sort(arr, right+1, to);\n	//return arr;\n}\nquick_sort([9,2,1,7,5,8,0,6,4,3],5,9)', 0, NULL, '1', '2020-06-27 23:12:57', '2020-11-07 22:49:57');
INSERT INTO `t_article` VALUES ('e8794ea0b85011eab22c5f97d38b0c88', '使用proxy实现简易响应式asca', 't6', 'dqwdqwd', NULL, 'function sort(arr){\n  	let len = arr.length;\n  	let preIndex,tmp;\n  	\n  	for(var i = 1;i < len; i++){\n      	preIndex = i-1;\n     	tmp = arr[i];\n        while(preIndex >= 0 && tmp< arr[preIndex]){\n        	arr[preIndex + 1] = arr[preIndex];\n          	preIndex--;\n        }\n      	arr[preIndex+1] = tmp\n    }\n	return arr;	\n}\n\nconsole.log(sort([9,2,11,18,3,17,8,80,20,5,15,24,6,1,7]))', 0, NULL, '1', '2020-06-27 16:33:42', '2020-11-07 22:49:39');

-- ----------------------------
-- Table structure for t_article_type
-- ----------------------------
DROP TABLE IF EXISTS `t_article_type`;
CREATE TABLE `t_article_type`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `photoPath` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `sortNo` int(0) DEFAULT NULL,
  `createUser` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `createTime` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `updateTime` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_article_type
-- ----------------------------
INSERT INTO `t_article_type` VALUES ('t1', 'web', '/file/download/7318e36c63e142e0988d682030737d10.jpg', '这是第三个分类\n这是第三个分类\n这是第三个分类', 3, NULL, '2020-04-08 19:57:59', '2020-04-08 19:58:13');
INSERT INTO `t_article_type` VALUES ('t2', 'javascript', '/file/download/f260d1914ad4413880d37f18fbb5cfdc.jpg', 'asdasdasd', 1, NULL, '2020-04-07 22:09:42', '2020-04-10 20:31:07');
INSERT INTO `t_article_type` VALUES ('t3', 'vue', '/file/download/3635f62a252347f09ca8dcae028a10ef.jpg', '这个分类用于放vue学习中的笔记', 4, NULL, '2020-04-08 21:15:03', '2020-05-23 17:00:40');
INSERT INTO `t_article_type` VALUES ('t4', '算法', '/file/download/2116a736ab8a45c1b838a2840ac86961.jpg', 'cascade', 6, NULL, '2020-04-08 21:14:38', '2020-06-27 14:55:54');
INSERT INTO `t_article_type` VALUES ('t5', 'css', '/file/download/00ebf34a41f448c795a872bc26ddf85d.jpg', 'css', 5, NULL, '2020-04-08 21:14:22', '2020-05-31 15:46:54');
INSERT INTO `t_article_type` VALUES ('t6', '日常打卡', '/file/download/3ecb7ace6d5046bca1711e5a54c561b2.jpg', '用于记录打卡', 2, NULL, '2020-04-07 22:10:26', '2020-04-28 23:14:30');

-- ----------------------------
-- Table structure for t_code
-- ----------------------------
DROP TABLE IF EXISTS `t_code`;
CREATE TABLE `t_code`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `codeId` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `value` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `createUser` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `createTime` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `updateTime` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_code
-- ----------------------------
INSERT INTO `t_code` VALUES ('1', 'SEX', '0', '男', NULL, NULL, NULL);
INSERT INTO `t_code` VALUES ('2', 'SEX', '1', '女', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for t_code_dic
-- ----------------------------
DROP TABLE IF EXISTS `t_code_dic`;
CREATE TABLE `t_code_dic`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `codeId` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `tableName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `codeName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `valueName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `createUser` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `createTime` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `updateTime` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_code_dic
-- ----------------------------
INSERT INTO `t_code_dic` VALUES ('e24f13402a7711eba87d1195f0e5aa97', 'SEX', 't_code', 'code', 'value', NULL, '2020-11-19 22:59:55', NULL);
INSERT INTO `t_code_dic` VALUES ('2922bb402a7e11eba87d1195f0e5aa97', 'ARTICLE_TYPE', 't_article_type', 'id', 'name', NULL, '2020-11-19 23:44:50', NULL);
INSERT INTO `t_code_dic` VALUES ('519fa0302ff911eba87d1195f0e5aa97', 'ddd', 't_article_type', 'dw', 'dw', NULL, '2020-11-26 23:09:02', NULL);

-- ----------------------------
-- Table structure for t_goods
-- ----------------------------
DROP TABLE IF EXISTS `t_goods`;
CREATE TABLE `t_goods`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `pinming` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `danwei` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `guige` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `jinjia` float(11, 2) DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `stock` float(11, 0) DEFAULT 0 COMMENT '库存',
  `totalMoney` float(11, 0) DEFAULT 0,
  `createUser` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `createTime` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `updateTime` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_goods
-- ----------------------------
INSERT INTO `t_goods` VALUES ('12', '三角燕', 'g', '半干挑', 0.00, '', 0, 0, '3', NULL, NULL);
INSERT INTO `t_goods` VALUES ('14', '阿胶', '盒', '同仁堂', 0.00, '', 0, 0, '3', NULL, '2020-03-24 12:22:14');
INSERT INTO `t_goods` VALUES ('15', '白莲子', '包', '建宁', 0.00, '', 0, 0, '3', NULL, '2020-03-24 17:03:29');
INSERT INTO `t_goods` VALUES ('16', '西洋参', 'g', '山东2.5g', 0.00, '', 0, 0, '3', NULL, '2020-03-24 17:02:08');
INSERT INTO `t_goods` VALUES ('17', '海马', 'g', '本港1个以下', 0.00, '', 0, 0, '3', NULL, NULL);
INSERT INTO `t_goods` VALUES ('18', '虫草花', '包', '大', 0.00, '', 0, 0, '3', NULL, '2020-03-24 21:32:48');
INSERT INTO `t_goods` VALUES ('19', '西洋参节', 'g', '国产', 0.00, '', 0, 0, '3', NULL, NULL);
INSERT INTO `t_goods` VALUES ('1b442e206c0911eaa60bcb95426e4e52', 'h6u', '7', '6h顶顶顶', 0.00, '7', 1, 1, NULL, '2020-03-22 14:48:15', '2020-03-23 15:17:36');
INSERT INTO `t_goods` VALUES ('2', '石斛', 'g', '好', 0.00, '', 0, 0, '3', NULL, NULL);
INSERT INTO `t_goods` VALUES ('20', '燕碎', 'g', '小燕碎', 0.00, '', 0, 0, '3', NULL, NULL);
INSERT INTO `t_goods` VALUES ('21', '四物', '包', '35g', 0.00, '', 0, 0, '3', NULL, NULL);
INSERT INTO `t_goods` VALUES ('22', '血茸片', 'g', '血片', 0.00, '', 0, 0, '3', NULL, NULL);
INSERT INTO `t_goods` VALUES ('23', '雪蛤膏', '盒', '25g', 0.00, '', 0, 0, '3', NULL, NULL);
INSERT INTO `t_goods` VALUES ('24', '黄芪', '包', '斜片', 0.00, '', 0, 0, '3', NULL, NULL);
INSERT INTO `t_goods` VALUES ('2472f3106db611eab0165fa4aaf40047', '测试', '1', '啊倒萨', 2.00, '21', 0, 0, NULL, '2020-03-24 17:59:25', '2020-03-25 15:54:05');
INSERT INTO `t_goods` VALUES ('25', '高丽参', 'g', 'g', 0.00, '', 0, 0, '3', NULL, NULL);
INSERT INTO `t_goods` VALUES ('26', '红参', 'g', 'g', 0.00, '', 0, 0, '3', NULL, NULL);
INSERT INTO `t_goods` VALUES ('27', '囊丝燕碎', 'g', '囊丝', 0.00, '', 0, 0, '3', NULL, NULL);
INSERT INTO `t_goods` VALUES ('28', '西洋参', 'g', 'g', 0.00, '', 0, 0, '3', NULL, NULL);
INSERT INTO `t_goods` VALUES ('29', '燕窝-舒盏', 'g', 'g', 0.00, NULL, 0, 0, '3', NULL, NULL);
INSERT INTO `t_goods` VALUES ('3', '石斛', 'g', '普通', 0.00, '', 0, 0, '3', NULL, NULL);
INSERT INTO `t_goods` VALUES ('30', '西洋参', '个', '加拿大3克尖', 0.00, '', 0, 0, '3', NULL, '2020-03-25 12:42:45');
INSERT INTO `t_goods` VALUES ('31', '黑枸杞', '包', '小', 0.00, '', 0, 0, '3', NULL, NULL);
INSERT INTO `t_goods` VALUES ('32', '田七', 'g', '60头', 0.00, '', 0, 0, '3', NULL, NULL);
INSERT INTO `t_goods` VALUES ('33', '阿胶糕', '盒', '500g', 0.00, '', 0, 0, '3', NULL, NULL);
INSERT INTO `t_goods` VALUES ('34d718806cdf11ea8add0d775ec0cc54', 'asd', '231', 'asdqwdq', 123.00, '23', 0, 0, NULL, '2020-03-23 16:20:50', '2020-03-23 22:59:32');
INSERT INTO `t_goods` VALUES ('36', 'huangjq', '1', '1', 0.00, '1', 0, 0, '1', NULL, NULL);
INSERT INTO `t_goods` VALUES ('37', '西洋参（0.28）', 'g', 'g', 0.00, '', 0, 0, '3', NULL, NULL);
INSERT INTO `t_goods` VALUES ('38', '石蜂糖', '包', '500g', 0.00, '', 0, 0, '3', NULL, NULL);
INSERT INTO `t_goods` VALUES ('39', 'ceshi', 'g', 'g', 0.00, '1212', 0, 0, '1', NULL, NULL);
INSERT INTO `t_goods` VALUES ('4', '野生天麻', 'g', '小', 0.00, '', 0, 0, '3', NULL, NULL);
INSERT INTO `t_goods` VALUES ('40', '123', '123', '123', 0.00, '123', 0, 0, '1', NULL, NULL);
INSERT INTO `t_goods` VALUES ('41', '田七', 'g', '50头', 0.00, '', 0, 0, '1', NULL, NULL);
INSERT INTO `t_goods` VALUES ('5', '桃胶', 'g', '包', 0.00, '', 0, 0, '3', NULL, NULL);
INSERT INTO `t_goods` VALUES ('6', '党参', '包', '250g', 0.00, '', 0, 0, '3', NULL, NULL);
INSERT INTO `t_goods` VALUES ('7', '银耳', '包', '250g', 0.00, '', 0, 0, '3', NULL, NULL);
INSERT INTO `t_goods` VALUES ('8', '红枸杞', '包', '250g', 0.00, '', 0, 0, '3', NULL, NULL);
INSERT INTO `t_goods` VALUES ('9', '玛咖', 'g', 'g', 0.00, '', 0, 0, '3', NULL, NULL);

-- ----------------------------
-- Table structure for t_photo
-- ----------------------------
DROP TABLE IF EXISTS `t_photo`;
CREATE TABLE `t_photo`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `description` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `photoDate` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `createUser` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `createTime` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `updateTime` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_photo
-- ----------------------------
INSERT INTO `t_photo` VALUES ('3ab8db7058e111e992c301d103f503b1', 'sc', 'wc', '2019-04-09T16:00:00.000Z', NULL, '2019-04-07 10:59:58.760', NULL);
INSERT INTO `t_photo` VALUES ('79a4f280591111e9a04f61f98aad9d1e', 'asdzzzzzzzzzzzzzzz', 'asdasd', '2019-04-16T16:00:00.000Z', NULL, '2019-04-07 16:45:20.168', NULL);
INSERT INTO `t_photo` VALUES ('93bcd5f058d711e9a57f4109e0fd8d9a', 'ssssssss', '但是发射点发到付', '2019-04-08T16:00:00.000Z', NULL, '2019-04-07 09:50:53.136', NULL);
INSERT INTO `t_photo` VALUES ('bab71eb0591111e996e4530f61b26d0d', 'asd', 'asdasd', '2019-04-16T16:00:00.000Z', NULL, '2019-04-07 16:47:09.339', NULL);
INSERT INTO `t_photo` VALUES ('db7a1d00591111e98bdc9db0411f076b', 'asd', 'asdasd', '2019-04-16T16:00:00.000Z', NULL, '2019-04-07 16:48:04.304', NULL);
INSERT INTO `t_photo` VALUES ('dcb0ed20590211e9b649c9b5971bc302', 'dasd', 'asdasd', '2019-04-09T16:00:00.000Z', NULL, '2019-04-07 15:00:43.891', NULL);
INSERT INTO `t_photo` VALUES ('e06cbca0590211e9b649c9b5971bc302', 'fasdf', 'afasdfa', '2019-04-01T16:00:00.000Z', NULL, '2019-04-07 15:00:50.154', NULL);
INSERT INTO `t_photo` VALUES ('e4126e40591111e98bdc9db0411f076b', 'asd', 'asdasd', '2019-04-16T16:00:00.000Z', NULL, '2019-04-07 16:48:18.724', NULL);
INSERT INTO `t_photo` VALUES ('e5aa9840590211e9b649c9b5971bc302', 'asdf', 'adsf', '2019-04-09T16:00:00.000Z', NULL, '2019-04-07 15:00:58.948', NULL);
INSERT INTO `t_photo` VALUES ('e8953510590211e9b649c9b5971bc302', 'afdad', 'fadf', '2019-04-23T16:00:00.000Z', NULL, '2019-04-07 15:01:03.841', NULL);
INSERT INTO `t_photo` VALUES ('eb1b1ca0590211e9b649c9b5971bc302', 'asdfa', 'sdfasdf', '2019-04-09T16:00:00.000Z', NULL, '2019-04-07 15:01:08.074', NULL);
INSERT INTO `t_photo` VALUES ('ed529610590211e9b649c9b5971bc302', 'asdf', 'asdfasdf', '2019-04-02T16:00:00.000Z', NULL, '2019-04-07 15:01:11.793', NULL);
INSERT INTO `t_photo` VALUES ('f08d75c0590211e9b649c9b5971bc302', 'asdfa', 'dfasdf', '2019-04-17T16:00:00.000Z', NULL, '2019-04-07 15:01:17.212', NULL);
INSERT INTO `t_photo` VALUES ('f2dfa320590211e9b649c9b5971bc302', 'adf', 'adfa', '2019-04-16T16:00:00.000Z', NULL, '2019-04-07 15:01:21.106', NULL);
INSERT INTO `t_photo` VALUES ('f533a540590211e9b649c9b5971bc302', 'adf', 'adfadf', '2019-04-02T16:00:00.000Z', NULL, '2019-04-07 15:01:25.012', NULL);

-- ----------------------------
-- Table structure for t_role
-- ----------------------------
DROP TABLE IF EXISTS `t_role`;
CREATE TABLE `t_role`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `permissions` longtext CHARACTER SET utf8 COLLATE utf8_general_ci,
  `createUser` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `createTime` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `updateTime` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_role
-- ----------------------------
INSERT INTO `t_role` VALUES ('27b26cc09f3111eaa52b174761b9e252', '角色2', 'role2', '444', '100', '1', '2020-05-26 17:13:25', '2020-05-27 16:26:22');
INSERT INTO `t_role` VALUES ('2f8942c09f3111eaa52b174761b9e252', '角色1', 'role1', '333', '100', '1', '2020-05-26 17:13:38', '2020-05-27 16:26:22');
INSERT INTO `t_role` VALUES ('4349ead0a03511eaaf5187445f1dad63', '管理员', 'admin', '1', '100', '1', '2020-05-28 00:15:21', '2020-05-28 00:15:28');
INSERT INTO `t_role` VALUES ('474f7e209f3011ea94d6f309d237aefa', '角色3', 'role3', NULL, '100', '1', '2020-05-26 17:07:09', '2020-05-27 16:26:22');
INSERT INTO `t_role` VALUES ('das', '角色4', 'role4', 'sdfsd', '100', NULL, NULL, '2020-05-27 16:26:22');

-- ----------------------------
-- Table structure for t_role_permission_info
-- ----------------------------
DROP TABLE IF EXISTS `t_role_permission_info`;
CREATE TABLE `t_role_permission_info`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `code` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `createUser` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `createTime` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `updateTime` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_role_permission_info
-- ----------------------------
INSERT INTO `t_role_permission_info` VALUES ('22', 'ceshi1', 'miaoshu', 'code1', NULL, NULL, NULL);
INSERT INTO `t_role_permission_info` VALUES ('2f06e1709f3311ea9d781bb5eb00e497', 'gggtyyyy', 'ytyh', 'code2', '1', '2020-05-26 17:27:56', '2020-05-26 17:28:19');
INSERT INTO `t_role_permission_info` VALUES ('33c63500a03511eaaf5187445f1dad63', '文章类型管理', '文章->类型管理', 'ArticleTypeList', '1', '2020-05-28 00:14:55', NULL);
INSERT INTO `t_role_permission_info` VALUES ('d5a1c8409f4911ea9d781bb5eb00e497', '测试权限3', '阿萨大', 'code3', '1', '2020-05-26 20:10:05', NULL);

-- ----------------------------
-- Table structure for t_trade_record
-- ----------------------------
DROP TABLE IF EXISTS `t_trade_record`;
CREATE TABLE `t_trade_record`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `goodsId` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `type` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `number` float(11, 2) DEFAULT NULL,
  `price` float(10, 2) DEFAULT NULL,
  `cost` float(10, 2) DEFAULT NULL,
  `tradeDate` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `createUser` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `createTime` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `updateTime` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_trade_record
-- ----------------------------
INSERT INTO `t_trade_record` VALUES ('07ed34c06e7011ea885e739bcea0c47e', '1b442e206c0911eaa60bcb95426e4e52', '0', 1.00, 1.00, NULL, '2020-03-25', NULL, NULL, '2020-03-25 16:10:03', NULL);

-- ----------------------------
-- Table structure for t_upload_file
-- ----------------------------
DROP TABLE IF EXISTS `t_upload_file`;
CREATE TABLE `t_upload_file`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `recordId` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `originalName` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `realName` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `belongUser` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `createTime` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `updateTime` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_upload_file
-- ----------------------------
INSERT INTO `t_upload_file` VALUES ('063f8d004fd411e9a3d5eb4aa4f4dca1', '956e06204fc811e99e909b53c09c29c6', '2012111719294197.jpg', '60e77806f4f144438aad7114b912d802.jpg', NULL, NULL, NULL);
INSERT INTO `t_upload_file` VALUES ('063f8d014fd411e9a3d5eb4aa4f4dca1', '956e06204fc811e99e909b53c09c29c6', '微信图片_20190319194906.jpg', '25e3640bfab44b95b44b950d9a574eaf.jpg', NULL, NULL, NULL);
INSERT INTO `t_upload_file` VALUES ('063f8d024fd411e9a3d5eb4aa4f4dca1', '956e06204fc811e99e909b53c09c29c6', '2012111719294197.jpg', '60e77806f4f144438aad7114b912d802.jpg', NULL, NULL, NULL);
INSERT INTO `t_upload_file` VALUES ('063f8d034fd411e9a3d5eb4aa4f4dca1', '956e06204fc811e99e909b53c09c29c6', '微信图片_20190319194906.jpg', '25e3640bfab44b95b44b950d9a574eaf.jpg', NULL, NULL, NULL);
INSERT INTO `t_upload_file` VALUES ('21d024904fd811e98023cd6c81ecb071', 'bd87d5004fc811e99e909b53c09c29c6', '微信图片_20190319194906.jpg', '99a01c523ec1413a964b01949f692b61.jpg', NULL, NULL, NULL);
INSERT INTO `t_upload_file` VALUES ('25e4c2704fd811e98023cd6c81ecb071', 'ae0334d04fc811e99e909b53c09c29c6', '200812308231244_2.jpg', '93d33d3328cb4e319d27ae5023fc293c.jpg', NULL, NULL, NULL);
INSERT INTO `t_upload_file` VALUES ('33c7db50591211e99be409824f5828af', '3ab8db7058e111e992c301d103f503b1', '微信图片_20190319194900.jpg', '7ef29fa092a84831b95fe232a3aabf79.jpg', NULL, NULL, NULL);
INSERT INTO `t_upload_file` VALUES ('43644940591211e9bd6fcbf4fc85c20e', '3ab8db7058e111e992c301d103f503b1', '微信图片_20190307194223.jpg', 'd20869a7722443c4b526e18408be4f9a.jpg', NULL, NULL, NULL);
INSERT INTO `t_upload_file` VALUES ('440fd4a04fd411e9a3d5eb4aa4f4dca1', '956e06204fc811e99e909b53c09c29c6', '2012111719294197.jpg', '60e77806f4f144438aad7114b912d802.jpg', NULL, NULL, NULL);
INSERT INTO `t_upload_file` VALUES ('440fd4a14fd411e9a3d5eb4aa4f4dca1', '956e06204fc811e99e909b53c09c29c6', '微信图片_20190319194906.jpg', '25e3640bfab44b95b44b950d9a574eaf.jpg', NULL, NULL, NULL);
INSERT INTO `t_upload_file` VALUES ('440fd4a24fd411e9a3d5eb4aa4f4dca1', '956e06204fc811e99e909b53c09c29c6', '2012111719294197.jpg', '60e77806f4f144438aad7114b912d802.jpg', NULL, NULL, NULL);
INSERT INTO `t_upload_file` VALUES ('440fd4a34fd411e9a3d5eb4aa4f4dca1', '956e06204fc811e99e909b53c09c29c6', '微信图片_20190319194906.jpg', '25e3640bfab44b95b44b950d9a574eaf.jpg', NULL, NULL, NULL);
INSERT INTO `t_upload_file` VALUES ('509cabd1508811e9a920c52b47dcc571', '509cabd0508811e9a920c52b47dcc571', 'c9f1c139b6003af30f44ee573b2ac65c1038b629.jpg', '308958f896ef485381d4e69339a074cb.jpg', NULL, NULL, NULL);
INSERT INTO `t_upload_file` VALUES ('5315c5d0591211e9bd6fcbf4fc85c20e', '79a4f280591111e9a04f61f98aad9d1e', '微信图片_20190319194900.jpg', 'f30b9757bef94c2a898e846d229e95c6.jpg', NULL, NULL, NULL);
INSERT INTO `t_upload_file` VALUES ('5ac22cc1508811e9a920c52b47dcc571', '5ac22cc0508811e9a920c52b47dcc571', 'c9f1c139b6003af30f44ee573b2ac65c1038b629.jpg', '308958f896ef485381d4e69339a074cb.jpg', NULL, NULL, NULL);
INSERT INTO `t_upload_file` VALUES ('909d86b0509611e98dd8cf588f749f11', 'a0798190508911e99f0c1d75804f15ee', '微信图片_20190319194906.jpg', 'a306704e541340c3b944ed448d822273.jpg', NULL, NULL, NULL);
INSERT INTO `t_upload_file` VALUES ('93bd241058d711e9a57f4109e0fd8d9a', '93bcd5f058d711e9a57f4109e0fd8d9a', '微信图片_20190319194900.jpg', 'c359fb35782a4f0991b1f2561190a51b.jpg', NULL, NULL, NULL);
INSERT INTO `t_upload_file` VALUES ('956e06214fc811e99e909b53c09c29c6', '956e06204fc811e99e909b53c09c29c6', '2012111719294197.jpg', '60e77806f4f144438aad7114b912d802.jpg', NULL, NULL, NULL);
INSERT INTO `t_upload_file` VALUES ('956e06224fc811e99e909b53c09c29c6', '956e06204fc811e99e909b53c09c29c6', '微信图片_20190319194906.jpg', '25e3640bfab44b95b44b950d9a574eaf.jpg', NULL, NULL, NULL);
INSERT INTO `t_upload_file` VALUES ('96b8b5e0508911e99f0c1d75804f15ee', '96b88ed0508911e99f0c1d75804f15ee', '2012111719294197.jpg', '96386efe073f4fbd9aa0228d70ce1509.jpg', NULL, NULL, NULL);
INSERT INTO `t_upload_file` VALUES ('9ee4ebf0509611e98dd8cf588f749f11', 'a0798190508911e99f0c1d75804f15ee', '200812308231244_2.jpg', '914e01af1edb4d08ab6c86691a20f493.jpg', NULL, NULL, NULL);
INSERT INTO `t_upload_file` VALUES ('ad52f310594911e993847585d56810dc', '79a4f280591111e9a04f61f98aad9d1e', '微信图片_20190320233027.jpg', 'c23124b3de08436d871bbea9a0b73f41.jpg', NULL, NULL, NULL);
INSERT INTO `t_upload_file` VALUES ('b468c7904fc811e99e909b53c09c29c6', '956e06204fc811e99e909b53c09c29c6', '2012111719294197.jpg', '60e77806f4f144438aad7114b912d802.jpg', NULL, NULL, NULL);
INSERT INTO `t_upload_file` VALUES ('b468c7914fc811e99e909b53c09c29c6', '956e06204fc811e99e909b53c09c29c6', '微信图片_20190319194906.jpg', '25e3640bfab44b95b44b950d9a574eaf.jpg', NULL, NULL, NULL);
INSERT INTO `t_upload_file` VALUES ('bbd25bd04fd311e9a33ea90746a34bbb', '956e06204fc811e99e909b53c09c29c6', '2012111719294197.jpg', '60e77806f4f144438aad7114b912d802.jpg', NULL, NULL, NULL);
INSERT INTO `t_upload_file` VALUES ('bbd25bd14fd311e9a33ea90746a34bbb', '956e06204fc811e99e909b53c09c29c6', '微信图片_20190319194906.jpg', '25e3640bfab44b95b44b950d9a574eaf.jpg', NULL, NULL, NULL);
INSERT INTO `t_upload_file` VALUES ('bbd25bd24fd311e9a33ea90746a34bbb', '956e06204fc811e99e909b53c09c29c6', '2012111719294197.jpg', '60e77806f4f144438aad7114b912d802.jpg', NULL, NULL, NULL);
INSERT INTO `t_upload_file` VALUES ('bbd25bd34fd311e9a33ea90746a34bbb', '956e06204fc811e99e909b53c09c29c6', '微信图片_20190319194906.jpg', '25e3640bfab44b95b44b950d9a574eaf.jpg', NULL, NULL, NULL);
INSERT INTO `t_upload_file` VALUES ('bd87fc104fc811e99e909b53c09c29c6', 'bd87d5004fc811e99e909b53c09c29c6', '微信图片_20190319194906.jpg', 'f6ed23de42e04df89bba8ece1acfcee0.jpg', NULL, NULL, NULL);
INSERT INTO `t_upload_file` VALUES ('c8ff77704fd311e9a33ea90746a34bbb', '956e06204fc811e99e909b53c09c29c6', '2012111719294197.jpg', '60e77806f4f144438aad7114b912d802.jpg', NULL, NULL, NULL);
INSERT INTO `t_upload_file` VALUES ('c8ff77714fd311e9a33ea90746a34bbb', '956e06204fc811e99e909b53c09c29c6', '微信图片_20190319194906.jpg', '25e3640bfab44b95b44b950d9a574eaf.jpg', NULL, NULL, NULL);
INSERT INTO `t_upload_file` VALUES ('c8ff77724fd311e9a33ea90746a34bbb', '956e06204fc811e99e909b53c09c29c6', '2012111719294197.jpg', '60e77806f4f144438aad7114b912d802.jpg', NULL, NULL, NULL);
INSERT INTO `t_upload_file` VALUES ('c8ff77734fd311e9a33ea90746a34bbb', '956e06204fc811e99e909b53c09c29c6', '微信图片_20190319194906.jpg', '25e3640bfab44b95b44b950d9a574eaf.jpg', NULL, NULL, NULL);
INSERT INTO `t_upload_file` VALUES ('cf8192e04fd311e9a104bd1f10e181a8', '956e06204fc811e99e909b53c09c29c6', '2012111719294197.jpg', '60e77806f4f144438aad7114b912d802.jpg', NULL, NULL, NULL);
INSERT INTO `t_upload_file` VALUES ('cf81b9f04fd311e9a104bd1f10e181a8', '956e06204fc811e99e909b53c09c29c6', '微信图片_20190319194906.jpg', '25e3640bfab44b95b44b950d9a574eaf.jpg', NULL, NULL, NULL);
INSERT INTO `t_upload_file` VALUES ('cf81b9f14fd311e9a104bd1f10e181a8', '956e06204fc811e99e909b53c09c29c6', '2012111719294197.jpg', '60e77806f4f144438aad7114b912d802.jpg', NULL, NULL, NULL);
INSERT INTO `t_upload_file` VALUES ('cf81b9f24fd311e9a104bd1f10e181a8', '956e06204fc811e99e909b53c09c29c6', '微信图片_20190319194906.jpg', '25e3640bfab44b95b44b950d9a574eaf.jpg', NULL, NULL, NULL);
INSERT INTO `t_upload_file` VALUES ('d037c4814fc811e99e909b53c09c29c6', 'd037c4804fc811e99e909b53c09c29c6', '微信图片_20190319194906.jpg', 'd4d85da3bf0549e89265589f3dcdeeb7.jpg', NULL, NULL, NULL);
INSERT INTO `t_upload_file` VALUES ('d99c25b0594711e997aba398fa4f36b3', '3ab8db7058e111e992c301d103f503b1', '2012111719294197.jpg', '4e7f28694ded4d3f8936a968cb8d5ed9.jpg', NULL, NULL, NULL);
INSERT INTO `t_upload_file` VALUES ('da341ff0594711e997aba398fa4f36b3', '3ab8db7058e111e992c301d103f503b1', 'c9f1c139b6003af30f44ee573b2ac65c1038b629.jpg', '6b9020e83c2441a0963a9e5674e9175e.jpg', NULL, NULL, NULL);
INSERT INTO `t_upload_file` VALUES ('dac144c0594711e997aba398fa4f36b3', '3ab8db7058e111e992c301d103f503b1', '微信图片_20190319194906.jpg', '84a1daeaeff240048614fbd162fc8ba7.jpg', NULL, NULL, NULL);
INSERT INTO `t_upload_file` VALUES ('e614be60594711e9b7cb11285be71e30', '3ab8db7058e111e992c301d103f503b1', '2012111719294197.jpg', '4e7f28694ded4d3f8936a968cb8d5ed9.jpg', NULL, NULL, NULL);
INSERT INTO `t_upload_file` VALUES ('e6150c80594711e9b7cb11285be71e30', '3ab8db7058e111e992c301d103f503b1', 'c9f1c139b6003af30f44ee573b2ac65c1038b629.jpg', '6b9020e83c2441a0963a9e5674e9175e.jpg', NULL, NULL, NULL);
INSERT INTO `t_upload_file` VALUES ('e6150c81594711e9b7cb11285be71e30', '3ab8db7058e111e992c301d103f503b1', '微信图片_20190319194906.jpg', '84a1daeaeff240048614fbd162fc8ba7.jpg', NULL, NULL, NULL);
INSERT INTO `t_upload_file` VALUES ('ee8ef2f04fc811e9952d6fb248fc3f39', 'ee8ecbe04fc811e9952d6fb248fc3f39', '微信图片_20190319194906.jpg', 'f8117589c1c24420bab7705a20ab5a24.jpg', NULL, NULL, NULL);
INSERT INTO `t_upload_file` VALUES ('ee8ef2f14fc811e9952d6fb248fc3f39', 'ee8ecbe04fc811e9952d6fb248fc3f39', '微信图片_20190319194900.jpg', '8a456a782525409cba3a0df88ae29d11.jpg', NULL, NULL, NULL);
INSERT INTO `t_upload_file` VALUES ('ee8ef2f24fc811e9952d6fb248fc3f39', 'ee8ecbe04fc811e9952d6fb248fc3f39', '微信图片_20190307194223.jpg', 'c7c592ca1ad24458a9c84785329339ea.jpg', NULL, NULL, NULL);
INSERT INTO `t_upload_file` VALUES ('ee8ef2f34fc811e9952d6fb248fc3f39', 'ee8ecbe04fc811e9952d6fb248fc3f39', '200812308231244_2.jpg', 'f321a08ef5c746d89af35ff62d4fa9b1.jpg', NULL, NULL, NULL);
INSERT INTO `t_upload_file` VALUES ('ee8ef2f44fc811e9952d6fb248fc3f39', 'ee8ecbe04fc811e9952d6fb248fc3f39', '2012111719294197.jpg', 'ee9c6beaea3f4dda8cdd9021fb372104.jpg', NULL, NULL, NULL);

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `sex` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `createUser` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `createTime` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `updateTime` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES ('000000', 'Admin', '0', '/file/download/0c78079c54d3461e94df7647be51cd23.png', NULL, '', '2020-04-18 19:37:23');
INSERT INTO `t_user` VALUES ('91641a80825111eaa7e9a51d45123d71', 'asdasdasd', '1', '/file/download/2057dd0c209f4ee59d4f36fa3c38c719.png', '1', '2020-04-19 23:22:23', '2020-05-02 12:12:41');

-- ----------------------------
-- Table structure for t_user_account
-- ----------------------------
DROP TABLE IF EXISTS `t_user_account`;
CREATE TABLE `t_user_account`  (
  `id` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `username` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `password` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `status` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `userId` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `roles` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `createUser` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `createTime` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `updateTime` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_user_account
-- ----------------------------
INSERT INTO `t_user_account` VALUES ('1', 'admin', '111111', '1', '000000', 'role1,role2,admin,role3,role4', NULL, NULL, '2020-05-28 00:15:37');
INSERT INTO `t_user_account` VALUES ('935451c0825111eaa7e9a51d45123d71', 'asdasdasd', '111111', '0', '91641a80825111eaa7e9a51d45123d71', 'role3,admin', '1', '2020-04-19 23:22:26', '2020-07-18 17:06:35');

-- ----------------------------
-- View structure for vw_trade_info
-- ----------------------------
DROP VIEW IF EXISTS `vw_trade_info`;
CREATE ALGORITHM = UNDEFINED DEFINER = `root`@`localhost` SQL SECURITY DEFINER VIEW `vw_trade_info` AS select `t_trade_record`.`id` AS `id`,`t_trade_record`.`goodsId` AS `goodsId`,`t_trade_record`.`type` AS `type`,`t_trade_record`.`number` AS `number`,`t_trade_record`.`price` AS `price`,`t_trade_record`.`cost` AS `cost`,`t_trade_record`.`tradeDate` AS `tradeDate`,`t_trade_record`.`remark` AS `remark`,`t_trade_record`.`belongUserId` AS `belongUserId`,`t_trade_record`.`createTime` AS `createTime`,`t_trade_record`.`updateTime` AS `updateTime`,concat(`t_goods`.`pinming`,'（规格：',`t_goods`.`guige`,'）') AS `pinming` from (`t_trade_record` join `t_goods` on((`t_trade_record`.`goodsId` = `t_goods`.`id`)));

SET FOREIGN_KEY_CHECKS = 1;
