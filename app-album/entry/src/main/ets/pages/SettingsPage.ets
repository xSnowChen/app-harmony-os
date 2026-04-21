import router from '@ohos.router';

@Entry
@Component
struct SettingsPage {
  private navigateTo(url: string): void {
    router.pushUrl({ url: url });
  }

  build() {
    Scroll() {
      Column({ space: 16 }) {
        Row({ space: 12 }) {
          Button('←')
            .width(36).height(36).fontSize(18).fontColor('#111827')
            .backgroundColor('#FFFFFF').borderRadius(18)
            .onClick(() => { router.back(); })
          Text('设置')
            .fontSize(20).fontWeight(FontWeight.Bold).fontColor('#111827')
          Blank()
        }
        .width('100%').padding({ left: 16, right: 16, top: 12, bottom: 12 })

        // 文件管理
        Column({ space: 8 }) {
          Text('文件管理')
            .fontSize(14).fontColor('#6B7280').width('100%').padding({ left: 16 })
          Column() {
            this.ItemRow('回收站', '🗑️', 'pages/settings/RecycleBinPage')
            Divider().color('#E5E7EB')
            this.ItemRow('查看重复文件', '📄', 'pages/settings/DuplicateFilesPage')
            Divider().color('#E5E7EB')
            this.ItemRow('大文件排序', '📊', 'pages/settings/LargeFilesPage')
            Divider().color('#E5E7EB')
            this.ItemRow('清理临时文件', '🧹', 'pages/settings/CleanTempPage')
          }
          .backgroundColor('#FFFFFF').borderRadius(8).margin({ left: 16, right: 16 })
        }

        // 数据安全
        Column({ space: 8 }) {
          Text('数据安全')
            .fontSize(14).fontColor('#6B7280').width('100%').padding({ left: 16 })
          Column() {
            this.ItemRow('备份数据', '💾', 'pages/settings/BackupDataPage')
            Divider().color('#E5E7EB')
            this.ItemRow('闯入者拍摄', '📸', 'pages/settings/IntruderPhotoPage')
            Divider().color('#E5E7EB')
            this.ItemRow('手机互传', '📱', 'pages/settings/PhoneTransferPage')
          }
          .backgroundColor('#FFFFFF').borderRadius(8).margin({ left: 16, right: 16 })
        }

        // 密码相关
        Column({ space: 8 }) {
          Text('密码相关')
            .fontSize(14).fontColor('#6B7280').width('100%').padding({ left: 16 })
          Column() {
            this.ItemRow('密码与密保', '🔐', 'pages/settings/PasswordSecurityPage')
            Divider().color('#E5E7EB')
            this.ItemRow('Face ID登录', '👤', 'pages/settings/FaceIdPage')
          }
          .backgroundColor('#FFFFFF').borderRadius(8).margin({ left: 16, right: 16 })
        }

        // 配置
        Column({ space: 8 }) {
          Text('配置')
            .fontSize(14).fontColor('#6B7280').width('100%').padding({ left: 16 })
          Column() {
            this.ItemRow('App设置', '⚙️', 'pages/settings/AppSettingsPage')
            Divider().color('#E5E7EB')
            this.ItemRow('语言设置', '🌐', 'pages/settings/LanguageSettingsPage')
          }
          .backgroundColor('#FFFFFF').borderRadius(8).margin({ left: 16, right: 16 })
        }
      }
      .padding({ bottom: 20 })
    }
    .width('100%').height('100%').backgroundColor('#F3F6FC')
  }

  @Builder
  ItemRow(title: string, icon: string, targetPage: string) {
    Row({ space: 12 }) {
      Text(icon).fontSize(20)
      Text(title).fontSize(16).fontColor('#111827')
      Blank()
      Text('>').fontSize(16).fontColor('#9CA3AF')
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 14, bottom: 14 })
    .onClick(() => { this.navigateTo(targetPage); })
  }
}
