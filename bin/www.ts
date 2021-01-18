// 导入koa，和koa 1.x不同，在koa2中，我们导入的是一个class，因此用大写的Koa表示:
const Koa = require("koa");

// 创建一个Koa对象表示web app本身:
const app = new Koa();
const session = require("koa-session");
const bodyParser = require("koa-bodyparser");
const koaCors = require('koa-cors')

const moduleAlias = require("module-alias");
moduleAlias();

// 导入controller middleware:
const controller = require("../src/controller");
app.use(bodyParser());
// 使用middleware:
app.use(controller());

app.keys = ["some secret hurr"];
const CONFIG = {
  key: "koa:sess", //cookie key (default is koa:sess)
  maxAge: 86400000, // cookie的过期时间 maxAge in ms (default is 1 days)
  overwrite: true, //是否可以overwrite    (默认default true)
  httpOnly: true, //cookie是否只有服务器端可以访问 httpOnly or not (default true)
  signed: true, //签名默认true
  rolling: false, //在每次请求时强行设置cookie，这将重置cookie过期时间（默认：false）
  renew: false, //(boolean) renew session when session is nearly expired,
};
app.use(session(CONFIG, app));
app.use(ctx => {
  if (ctx.path === '/favicon.ico') return; let n = ctx.session.count || 0; ctx.session.count = ++n;
  ctx.body = '第' + n + '次访问';
});

const koaOptions = {
  origin: true,
  credentials: true
};

app
  .use(koaCors(koaOptions))
// 在端口3000监听:
app.listen(3000);
console.log("app started at port 3000...");
