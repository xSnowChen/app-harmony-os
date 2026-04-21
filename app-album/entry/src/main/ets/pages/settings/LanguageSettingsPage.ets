import router from '@ohos.router';

@Preview
@Entry
@Component
struct LanguageSettingsPage {
  @State selectedLang: string = 'zh-CN';
  private languages: string[] = ['zh-CN', 'zh-TW', 'en-US', 'ja-JP', 'ko-KR'];
  private langLabels: string[] = ['简体中文', '繁體中文', 'English', '日本語', '한국어'];

  build() {
    Column({ space: 12 }) {
      Row({ space: 12 }) {
        Button('←')
          .width(36).height(36).fontSize(18).fontColor('#111827')
          .backgroundColor('#FFFFFF').borderRadius(18)
          .onClick(() => { router.back(); })
        Text('语言设置')
          .fontSize(20).fontWeight(FontWeight.Bold).fontColor('#111827')
        Blank()
      }
      .width('100%').padding({ left: 16, right: 16, top: 12, bottom: 12 })

      Column({ space: 0 }) {
        ForEach(this.languages, (lang: string, index: number) => {
          Row() {
            Text(this.langLabels[index]).fontSize(16).fontColor('#111827')
            Blank()
            if (this.selectedLang === lang) {
              Text('✓').fontSize(18).fontColor('#6366F1')
            }
          }
          .width('100%').padding(16)
          .onClick(() => { this.selectedLang = lang; })

          if (index < this.languages.length - 1) {
            Divider().color('#E5E7EB')
          }
        }, (lang: string) => lang)
      }
      .backgroundColor('#FFFFFF').borderRadius(8).margin({ left: 16, right: 16 })

      Blank()
    }
    .width('100%').height('100%').backgroundColor('#F3F6FC')
  }
}
