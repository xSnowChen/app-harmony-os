import common from '@ohos.app.ability.common';
import { PasswordStore } from '../utils/PasswordStore';
import router from '@ohos.router';

@Entry
@Component
struct PasswordVerify {
  @State inputDigits: string = '';
  @State errorMsg: string = '';
  private store: PasswordStore = new PasswordStore();
  private maxLen: number = 6;

  private getContext(): common.UIAbilityContext {
    return this.getUIContext().getHostContext() as common.UIAbilityContext;
  }

  async aboutToAppear(): Promise<void> {
    await this.store.init(this.getContext());
  }

  private onDigit(d: string): void {
    this.errorMsg = '';
    if (this.inputDigits.length < this.maxLen) {
      this.inputDigits += d;
    }
    if (this.inputDigits.length === this.maxLen) {
      void this.doVerify();
    }
  }

  private onDelete(): void {
    this.errorMsg = '';
    this.inputDigits = this.inputDigits.slice(0, -1);
  }

  private async doVerify(): Promise<void> {
    const valid = await this.store.verifyPassword(this.inputDigits);
    if (valid) {
      router.replaceUrl({ url: 'pages/MainPage' });
    } else {
      this.errorMsg = '密码错误，请重试';
      this.inputDigits = '';
    }
  }

  build() {
    Column({ space: 0 }) {
      Blank()

      Text('加密相册')
        .fontSize(24).fontWeight(FontWeight.Bold).fontColor('#111827')

      Text('请输入密码以解锁')
        .fontSize(16).fontColor('#667085').margin({ top: 8, bottom: 24 })

      // 密码圆点
      Row({ space: 16 }) {
        ForEach(Array.from({ length: this.maxLen }), (_: void, index: number) => {
          Circle()
            .width(14).height(14)
            .fill(index < this.inputDigits.length ? '#6366F1' : '#E0E7FF')
        }, (_: void, index: number) => index.toString())
      }

      if (this.errorMsg) {
        Text(this.errorMsg)
          .fontSize(13).fontColor('#EF4444').margin({ top: 12 })
      }

      Blank()

      // 数字键盘
      Column({ space: 12 }) {
        this.KeyRow(['1', '2', '3'])
        this.KeyRow(['4', '5', '6'])
        this.KeyRow(['7', '8', '9'])
        Row({ space: 20 }) {
          this.KeyCell('')
          this.KeyCell('0')
          this.DeleteCell()
        }
      }
      .padding({ bottom: 40 })
    }
    .width('100%').height('100%')
    .padding({ left: 32, right: 32, top: 60 })
    .backgroundColor('#F3F6FC')
  }

  @Builder
  KeyRow(keys: string[]) {
    Row({ space: 20 }) {
      ForEach(keys, (k: string) => {
        this.KeyCell(k)
      }, (k: string) => k)
    }
  }

  @Builder
  KeyCell(digit: string) {
    Column() {
      Text(digit)
        .fontSize(28).fontWeight(FontWeight.Medium).fontColor('#111827')
    }
    .width(80).height(80).justifyContent(FlexAlign.Center)
    .backgroundColor('#FFFFFF').borderRadius(40)
    .onClick(() => {
      if (digit !== '') {
        this.onDigit(digit);
      }
    })
  }

  @Builder
  DeleteCell() {
    Column() {
      Text('⌫')
        .fontSize(24).fontColor('#111827')
    }
    .width(80).height(80).justifyContent(FlexAlign.Center)
    .backgroundColor('#FFFFFF').borderRadius(40)
    .onClick(() => { this.onDelete(); })
  }
}
