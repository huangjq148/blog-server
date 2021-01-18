const fs = require("fs");

type Router = {
  get: (method: string, handler: Function) => void;
  post: (method: string, handler: Function) => void;
};

// 驼峰转换下划线
function toLine(name: string) {
  return name.replace(/([A-Z])/g, "-$1").toLowerCase();
}

function addMapping(fileName: string, router: Router, mapping: any) {
  const prefix = toLine(fileName.replace(".ts", ""));
  for (const url in mapping) {
    if (url.startsWith("GET ")) {

      const path = "/" + prefix + url.substring(4);
      router.get(path, mapping[url]);
      console.log(`register URL mapping: GET\t ${path} \t\t\t\thttp://localhost:3000${path}`);

    } else if (url.startsWith("POST ")) {

      const path = "/" + prefix + url.substring(5);
      router.post(path, mapping[url]);
      console.log(`register URL mapping: POST\t ${path}`);

    } else if (url.startsWith("DELETE ")) {

      const path = "/" + prefix + url.substring(7);
      router.post(path, mapping[url]);
      console.log(`register URL mapping: DELETE\t ${path}`);

    } else if (url.startsWith("PUT ")) {

      const path = "/" + prefix + url.substring(4);
      router.post(path, mapping[url]);
      console.log(`register URL mapping: PUT\t ${path}`);

    } else {
      console.log(`invalid URL: ${url}`);
    }
  }
}

function addControllers(router: any) {
  const files = fs.readdirSync(__dirname + "/");
  const js_files = files.filter((f: string) => {
    return f.endsWith(".ts") && f !== "index.ts";
  });

  for (const f of js_files) {
    console.log(`process controller: ${f}...`);
    let mapping = require(__dirname + "/" + f);
    addMapping(f, router, mapping);
  }
}

module.exports = function (dir: string) {
  let router = require("koa-router")();
  addControllers(router);
  return router.routes();
};
