import common from '@ohos.app.ability.common';
import { PasswordStore } from '../utils/PasswordStore';
import router from '@ohos.router';

@Preview
@Entry
@Component
struct PasswordSetup {
  @State inputDigits: string = '';
  @State confirmDigits: string = '';
  @State step: number = 0;
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
    if (this.step === 0) {
      if (this.inputDigits.length < this.maxLen) {
        this.inputDigits += d;
      }
    } else {
      if (this.confirmDigits.length < this.maxLen) {
        this.confirmDigits += d;
      }
    }
  }

  private onDelete(): void {
    this.errorMsg = '';
    if (this.step === 0) {
      this.inputDigits = this.inputDigits.slice(0, -1);
    } else {
      this.confirmDigits = this.confirmDigits.slice(0, -1);
    }
  }

  private async onConfirm(): Promise<void> {
    if (this.step === 0) {
      if (this.inputDigits.length < 4) {
        this.errorMsg = '密码至少4位';
        return;
      }
      this.step = 1;
      this.errorMsg = '';
    } else {
      if (this.inputDigits !== this.confirmDigits) {
        this.errorMsg = '两次密码不一致';
        this.confirmDigits = '';
        return;
      }
      await this.store.setPassword(this.inputDigits);
      router.replaceUrl({ url: 'pages/MainPage' });
    }
  }

  private currentLen(): number {
    return this.step === 0 ? this.inputDigits.length : this.confirmDigits.length;
  }

  build() {
    Column({ space: 0 }) {
      Blank()

      Text('加密相册')
        .fontSize(24).fontWeight(FontWeight.Bold).fontColor('#111827')

      Text(this.step === 0 ? '设置访问密码' : '确认访问密码')
        .fontSize(16).fontColor('#667085').margin({ top: 8, bottom: 24 })

      // 密码圆点
      Row({ space: 16 }) {
        ForEach(Array.from({ length: this.maxLen }), (_: void, index: number) => {
          Circle()
            .width(14).height(14)
            .fill(index < this.currentLen() ? '#6366F1' : '#E0E7FF')
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
        const len = this.step === 0 ? this.inputDigits.length : this.confirmDigits.length;
        if (len === this.maxLen) {
          void this.onConfirm();
        }
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
