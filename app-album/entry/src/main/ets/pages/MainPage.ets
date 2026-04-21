import router from '@ohos.router';

interface MenuItem {
  id: string;
  label: string;
  color: string;
  icon: string;
  page: string;
}

@Entry
@Component
struct MainPage {
  private menuItems: MenuItem[] = [
    { id: 'photos', label: '照片', color: '#6366F1', icon: '📷', page: 'pages/PhotosPage' },
    { id: 'videos', label: '视频', color: '#EC4899', icon: '🎬', page: 'pages/VideosPage' },
    { id: 'gifs', label: '动图', color: '#F59E0B', icon: '🎭', page: 'pages/GifsPage' },
    { id: 'docs', label: '资料', color: '#10B981', icon: '📄', page: 'pages/DocsPage' },
    { id: 'records', label: '录音&文件', color: '#3B82F6', icon: '🎙️', page: 'pages/RecordsPage' },
    { id: 'settings', label: '设置', color: '#6B7280', icon: '⚙️', page: 'pages/SettingsPage' }
  ];

  private navigateTo(page: string): void {
    router.pushUrl({ url: page });
  }

  build() {
    Column({ space: 20 }) {
      Row({ space: 12 }) {
        Text('加密相册')
          .fontSize(24).fontWeight(FontWeight.Bold).fontColor('#111827')
        Blank()
      }
      .width('100%').padding({ left: 16, right: 16, top: 12, bottom: 12 })

      Grid() {
        ForEach(this.menuItems, (item: MenuItem) => {
          GridItem() {
            Stack() {
              Circle()
                .width(56).height(56).fill(item.color).opacity(0.15)
              Text(item.icon).fontSize(24)
              Text(item.label)
                .fontSize(14).fontColor('#111827')
                .position({ y: 72 })
            }
            .width('100%').height(90)
            .onClick(() => { this.navigateTo(item.page); })
          }
        }, (item: MenuItem) => item.id)
      }
      .columnsTemplate('1fr 1fr 1fr')
      .rowsGap(16).columnsGap(16)
      .width('100%').padding({ left: 16, right: 16 }).layoutWeight(1)

      Button('锁定')
        .width('90%').height(44).fontSize(16).fontColor('#6366F1')
        .backgroundColor('#E0E7FF').borderRadius(8).margin({ bottom: 20 })
        .onClick(() => { router.replaceUrl({ url: 'pages/PasswordVerify' }); })
    }
    .width('100%').height('100%').backgroundColor('#F3F6FC')
  }
}