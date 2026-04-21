import router from '@ohos.router';

interface MenuItem {
  id: string;
  label: string;
  icon: ResourceStr;
  page: string;
}

@Preview
@Entry
@Component
struct MainPage {
  private menuItems: MenuItem[] = [
    { id: 'photos', label: '照片', icon: $r('app.media.ic_album_photos'), page: 'pages/PhotosPage' },
    { id: 'videos', label: '视频', icon: $r('app.media.ic_album_videos'), page: 'pages/VideosPage' },
    { id: 'gifs', label: '动图', icon: $r('app.media.ic_album_gifs'), page: 'pages/GifsPage' },
    { id: 'docs', label: '资料', icon: $r('app.media.ic_album_docs'), page: 'pages/DocsPage' },
    { id: 'records', label: '录音&文件', icon: $r('app.media.ic_album_records'), page: 'pages/RecordsPage' },
    { id: 'settings', label: '设置', icon: $r('app.media.ic_album_settings'), page: 'pages/SettingsPage' }
  ];

  private navigateTo(page: string): void {
    router.pushUrl({ url: page });
  }

  build() {
    Column() {
      Grid() {
        ForEach(this.menuItems, (item: MenuItem) => {
          GridItem() {
            Column({ space: 6 }) {
              Column() {
                Image(item.icon)
                  .width(64)
                  .height(64)
                  .objectFit(ImageFit.Contain)
              }
              .width(96)
              .height(96)
              .borderRadius(18)
              .backgroundColor('#EFF6FF')
              .justifyContent(FlexAlign.Center)

              Text(item.label)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor('#1F2937')
                .textAlign(TextAlign.Center)
                .maxLines(1)
            }
            .width('100%')
            .justifyContent(FlexAlign.Center)
            .alignItems(HorizontalAlign.Center)
            .onClick(() => { this.navigateTo(item.page); })
          }
        }, (item: MenuItem) => item.id)
      }
      .columnsTemplate('1fr 1fr')
      .rowsTemplate('1fr 1fr 1fr')
      .rowsGap(4)
      .columnsGap(4)
      .width('100%')
      .height('85%')
      .padding({ left: 16, right: 16 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8FAFC')
    .justifyContent(FlexAlign.Center)
  }
}
