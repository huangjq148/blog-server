import { Context } from "koa";
const fs = require("fs");

/**
 *   @Author huangjq
 *   @createDate 2019/8/11
 */
// const multipart = require("connect-multiparty");
// const multipartMiddleware = multipart();
const UUID = require("node-uuid");
const { ResponseResult } = require("@/models");
// let { Utils, DbUtilsClass, ResponseResult } = require("../../utils");
// let DbUtils = new DbUtilsClass("t_upload_file");
// let { checkDir } = require(__dirname + "/utils/fileUtils");
// const TABLE = "t_upload_file";

//检查文件夹是否存在，不存在则创建一个
function checkDir(path) {
  return new Promise((resolve: any, reject: any) => {
    fs.exists(path, function (isExists) {
      if (!isExists) {
        fs.mkdir(path, function (err) {
          if (err) {
            console.log(err);
            reject(err);
          } else {
            resolve();
          }
        });
      } else {
        resolve();
      }
    });
  });
}

//http://localhost:3000/uploader/upload
const uploadFile = async function (ctx: Context) {
  //   @ts-ignore
  const { file } = ctx.request.files;
  console.log(file.name); // 上传的文件信息
  const originalFilename = file.name;
  const suffix = originalFilename.substr(originalFilename.lastIndexOf("."));
  const fileRealName = UUID.v4().replace(/-/g, "") + suffix;

  const des_file = "./upload/" + fileRealName;

  await checkDir("upload");

  try {
    const data = fs.readFileSync(file.path);
    const error = fs.writeFileSync(des_file, data);
    if (error) {
      throw Error("文件写入错误");
    }
    const response = {
      message: "File uploaded successfully",
      filename: {
        originalName: file.name,
        realName: fileRealName,
      },
      downloadUrl: "/uploader/download/" + fileRealName,
    };
    console.log(response);
    ctx.response.body = ResponseResult.success(response);
  } catch (e) {
    ctx.response.body = ResponseResult.fail(e);
  }
};

// http://localhost:3000/uploader/download/34217a4b84954602a7898a3e03fa0309.png
const downloadFile = function (ctx: Context) {
  const originalName = ctx.request.query.originalName;
  const realName = ctx.params.realName;
  const filePath = "./upload/" + realName;

  try {
    const result = fs.readFileSync(filePath);
    ctx.append("Content-Type", "application/octet-stream");
    //告诉浏览器这是一个需要下载的文件)
    ctx.append(
      "Content-Disposition",
      "attachment; filename=" + originalName || realName
    );
    ctx.response.body = result;
  } catch (e) {
    ctx.response.body = ResponseResult.fail("Read file failed!");
  }
};

const previewFile = async function (ctx: Context) {
  const realName = ctx.params.realName;
  const filePath = "./upload/" + realName;
  try {
    const file = fs.readFileSync(filePath);
    ctx.response.body = file;
  } catch (e) {
    ctx.response.body = ResponseResult.fail("Read file failed!");
  }

  //   , function (isErr, data) {
  //     if (isErr) {
  //       res.end("Read file failed!");
  //       return;
  //     }
  //     res.end(data);
  //   });
};

// //http://localhost:3000/uploader/preview/e881c02f2a3449c1b2b58824d17cb61a.jpg?originalName=hh.png
// router.get("/preview/:realName", function (req, res, next) {
//   const realName = req.param("realName");
//   const filePath = "./upload/" + realName;
//   fs.readFile(filePath, function (isErr, data) {
//     if (isErr) {
//       res.end("Read file failed!");
//       return;
//     }
//     res.end(data);
//   });
// });

// router.post("/delete/:id", function (req, res, next) {
//   DbUtils;
//   DbUtils.queryObj({ id: req.params.id }, "t_upload_file")
//     .then((result) => {
//       return DbUtils.delete({ id: req.params.id }, "t_upload_file").then(
//         function (result1) {
//           fs.unlink(`./upload/${result.realName}`, function (error) {
//             if (error) {
//               console.log(error);
//               return false;
//             }
//             res.json(ResponseResult.success());
//           });
//         }
//       );
//     })
//     .catch(() => {
//       res.json(ResponseResult.fail());
//     });
// });

// module.exports = router;

http: module.exports = {
  "POST /upload": uploadFile,
  "GET /download/:realName": downloadFile,
  "GET /preview/:realName": previewFile,
};
