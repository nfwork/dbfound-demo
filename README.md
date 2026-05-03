# dbfound-demo

`dbfound-demo` 是一个基于 DBFound MVC 的示例项目，内置了 `DBFoundUI` 前端组件示例，用于演示使用 DBFound 快速开发传统 Java Web 管理系统。

本项目没有使用 Spring，也没有引入 Spring MVC。请求入口由 DBFound 提供的 `DispatcherFilter` 统一处理，页面层主要使用 JSP 和 `dbfound-tags` 标签，业务数据查询和增删改操作主要通过 DBFound 的 XML Model 配置完成。

## 项目特点

- 基于 Maven 构建，打包类型为 `war`
- 使用 DBFound MVC 作为 Web MVC 框架
- 内置 `DBFoundUI`，包含表单、表格、树、菜单、图表、弹窗等页面示例
- 使用 JSP + DBFound 标签开发页面
- 使用 XML Model 描述查询、执行 SQL、参数、过滤条件等数据操作
- 使用 MySQL 作为示例数据库

## 目录说明

```text
.
├── pom.xml                         Maven 项目配置
├── sql/demo.sql                    示例数据库脚本
├── src/main/java                   Java 扩展代码
│   └── com/nfwork/demo
│       ├── controller              DBFound ActionController 示例
│       ├── interceptor             登录校验拦截器
│       └── adapter                 文件上传适配示例
├── src/main/resources
│   ├── dbfound-conf.xml            DBFound 主配置，包含数据源、拦截器、Controller 扫描路径
│   ├── dbfound-mvc.xml             DBFound MVC 配置
│   └── model                       DBFound XML Model 配置
└── src/main/webapp
    ├── DBFoundUI                   DBFoundUI 前端资源和模板
    ├── WEB-INF/web.xml             Web 入口配置
    ├── login.jsp                   登录入口
    ├── index.jsp                   系统首页
    └── modules                     示例业务页面
```

## 环境要求

- JDK 11+
- Maven 3+
- MySQL
- Tomcat 或其他支持 Servlet/JSP 的 Web 容器

## 快速启动

1. 创建并初始化数据库：

   ```bash
   mysql -uroot -p < sql/demo.sql
   ```

2. 修改数据库连接配置：

   配置文件位于 `src/main/resources/dbfound-conf.xml`，默认连接信息如下：

   ```xml
   <property name="jdbcUrl" value="jdbc:mysql://127.0.0.1/dbfound?useUnicode=true&amp;characterEncoding=utf8" />
   <property name="username" value="dbfound" />
   <property name="password" value="dbfound" />
   ```

3. 构建项目：

   ```bash
   mvn clean package
   ```

4. 将生成的 `target/dbfound-demo-0.0.1-SNAPSHOT.war` 部署到 Tomcat。

5. 访问系统：

   ```text
   http://localhost:8080/dbfound-demo/
   ```

   示例账号：

   ```text
   用户名：ADMIN
   密码：admin
   ```

## 配置说明

DBFound 的主配置在 `src/main/resources/dbfound-conf.xml`。

### JSON 序列化

`system` 节点中的 `camelCaseToUnderscore` 用于 Java 对象 JSON 序列化时，将驼峰字段名转换为下划线字段名：

```xml
<system>
   <camelCaseToUnderscore>true</camelCaseToUnderscore>
</system>
```
该配置不会影响 `ResponseObject`、`queryResponseObject` 的输出结构，`totalCounts`、`outParam`依然会保持驼峰，主要为了兼容 `DBFoundUI` 内置字段名，使其正常运行。

### Web 配置

`web` 节点配置了拦截器和 Controller 扫描路径：

```xml
<web>
    <interceptor>com.nfwork.demo.interceptor.AccessCheckInterceptor</interceptor>
    <controllerPaths>com.nfwork.demo.controller</controllerPaths>
</web>
```

### mvc 配置

项目的 Web 入口配置在 `src/main/webapp/WEB-INF/web.xml`：

```xml
<filter>
    <filter-name>DBFound</filter-name>
    <filter-class>com.nfwork.dbfound.web.DispatcherFilter</filter-class>
</filter>
<filter-mapping>
    <filter-name>DBFound</filter-name>
    <url-pattern>/*</url-pattern>
</filter-mapping>
```

## jsp页面
页面通过 `dbfound-tags` 标签和 XML Model 绑定数据。例如 `index.jsp` 中使用 `menu` model 加载功能菜单：

```xml
<d:initProcedure>
    <d:dataSet id="menuStore" modelName="menu"></d:dataSet>
</d:initProcedure>
```

对应的 Model 文件位于 `src/main/resources/model/menu.xml`。

## 示例模块

项目中包含多个示例模块，可用于学习 DBFound MVC 与 DBFoundUI 的常见用法：

- 系统管理：用户、角色、功能、权限、访问控制
- 基础资料：学生、教师、课程、班级等
- 测试示例：表单、表格、树、下拉框、布局、图表等
- 文件管理：上传、下载、文件管理示例
- 业务示例：任务、员工、工程登记、结算等

## 开发提示

- 新增页面通常放在 `src/main/webapp/modules` 下
- 新增数据模型通常放在 `src/main/resources/model` 下
- 如果需要 Java Controller，可放在 `com.nfwork.demo.controller` 包下，并使用 DBFound 的 `ActionController`
- 如果需要登录或权限拦截，可参考 `AccessCheckInterceptor`
