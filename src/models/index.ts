export const Code = {
  codeId: "",
  tableName: "",
  codeName: "",
  valueName: "",
};

export const Article = {
  id: "",
  title: "",
  type: "",
  content: "",
  photoPath: "",
  contentText: "",
  clickCount: 0,
};

export const ArticleType = {
  id: "",
  name: "",
  photoPath: "",
  description: "",
};

export class ResponseResultClass {
  result: { statusCode: number; data: {}; message: string };
  constructor() {
    this.result = {
      statusCode: 200,
      data: {},
      message: "操作成功",
    };
  }

  success(data = {}, message = "操作成功") {
    this.result.statusCode = 200;
    this.result.data = data;
    this.result.message = message;
    return JSON.stringify(this.result);
  }

  fail(data, message = "操作失败", statusCode = 300) {
    console.error(data);
    this.result.statusCode = statusCode;
    this.result.data = data;
    this.result.message = message;
    return JSON.stringify(this.result);
  }

  noLogin() {
    console.error("需要登录或者没有通过登陆认证");
    const result = {
      statusCode: 401,
      message: "需要登录或者说没有通过登陆认证",
    };
    return JSON.stringify(result);
  }

  noPermission() {
    console.error("权限不足");
    const result = {
      statusCode: 403,
      message: "权限不足",
    };
    return JSON.stringify(result);
  }
}

export const ResponseResult = new ResponseResultClass();
