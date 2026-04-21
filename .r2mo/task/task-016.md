---
runAt: 2026-04-20.08-58-08
title: 手机加密相册长线开发
author:
---
- 初始化进入应用时让用户设置密码，设置好后存储在手机中
- 点击进入后提供（不同颜色圆形图）：
	- 照片（可分文件夹进行管理，可导入，可预览）
	- 视频
	- 动图
	- 资料
	- 录音&文件
	- 设置
- 设置中会包含（区域分类）：
	- 文件管理
		- 回收站
		- 查看重复文件
		- 大文件排序
		- 清理临时文件
	- 数据安全
		- 备份数据
		- 闯入者拍摄
		- 手机互传
	- 密码相关
		- 密码与密保
		- Face ID登录和访问文件夹
	- 配置
		- App设置
		- 语言设置

## Changes

### 2026-04-21

**Commit 1: 3aedb4b**
- 密码设置/验证页面 (`PasswordSetup.ets`, `PasswordVerify.ets`)
- PasswordStore 本地存储密码哈希
- EntryAbility 根据密码状态路由页面
- MainPage 6个功能入口布局
- SettingsPage 四区域框架

**Commit 2: ed445fc**
- 文件管理子页面：回收站、重复文件、大文件排序、清理临时文件
- 数据安全子页面：备份数据、闯入者拍摄、手机互传
- 密码相关子页面：密码修改、Face ID设置
- 配置子页面：App设置、语言设置
- SettingsPage 导航逻辑

**Commit 3: b59dd1d**
- Changes 记录回写

**Commit 4: 0d4c73e**
- PhotosPage 文件夹切换 + 照片网格 + 导入入口
- VideosPage/GifsPage/DocsPage/RecordsPage 内容页面
- MainPage 导航连接所有内容页面

**验证结果**: app-album 已在模拟器成功启动，进入密码设置流程。