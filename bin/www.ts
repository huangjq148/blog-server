// 导入koa，和koa 1.x不同，在koa2中，我们导入的是一个class，因此用大写的Koa表示:
const Koa = require("koa");

// 创建一个Koa对象表示web app本身:
const app = new Koa();
const bodyParser = require("koa-bodyparser");

const moduleAlias = require("module-alias");
moduleAlias();

// 导入controller middleware:
const controller = require("../src/controller");
app.use(bodyParser());
// 使用middleware:
app.use(controller());
 

// 在端口3000监听:
app.listen(3000);
console.log("app started at port 3000...");
