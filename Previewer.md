# DevEco Previewer Device Profiles

Data source: DevEco Studio SDK `productConfig.json` (HarmonyOS 6.0.2)

## How to Use

1. Open an `.ets` file in DevEco Studio
2. Click **Previewer** panel (top-right of editor)
3. In Previewer toolbar, select device from dropdown or choose **Custom**
4. Enter values from the table below

## Legend

| Symbol | Meaning |
|--------|---------|
| \* | Popular model, recommended for daily debugging |
| rect | Standard rectangle with pill cutout |
| fold | Foldable device |
| light/dark | Both color modes supported |

## Phone

| Model | Resolution (vp) | Screen Shape | Color Mode | DPI | Popular |
|-------|-----------------|--------------|------------|-----|---------|
| Pura 90 Pro Max | 374×823 | rect | light/dark | 560 | |
| Pura 90 Pro | 359×789 | rect | light/dark | 560 | |
| Pura 90 | 377×816 | rect | light/dark | 560 | |
| Pura 80 Pro / Pro+ / Ultra | 365×814 | rect | light/dark | 560 | \* |
| Pura 80 | 359×789 | rect | light/dark | 560 | |
| Mate 70 Pro / Pro+ / RS | 376×809 | rect | light/dark | 560 | \* |
| Mate 70 | 374×827 | rect | light/dark | 520 | \* |
| Mate 70 Air | 406×849 | rect | light/dark | 520 | |
| Mate 60 Pro / Pro+ / RS | 388×837 | rect | light/dark | 520 | \* |
| Mate 60 | 374×827 | rect | light/dark | 520 | \* |
| Mate 80 Pro Max / RS | 391×844 | rect | light/dark | 540 | |
| Mate 80 / Pro | 366×809 | rect | light/dark | 560 | |
| Pura 70 Pro / Pro+ / Ultra | 373×843 | rect | light/dark | 540 | \* |
| Pura 70 | 372×818 | rect | light/dark | 540 | |
| nova 13 Pro | 363×823 | rect | light/dark | 540 | \* |
| nova 13 | 361×804 | rect | light/dark | 480 | |
| nova 12 Pro / Ultra | 363×823 | rect | light/dark | 540 | \* |
| nova 12 | 361×804 | rect | light/dark | 480 | |
| nova 14 Ultra | 363×817 | rect | light/dark | 560 | |
| nova 14 Pro | 363×823 | rect | light/dark | 540 | |
| nova 14 | 361×804 | rect | light/dark | 480 | |
| nova 15 Pro / Ultra | 377×816 | rect | light/dark | 560 | |
| nova 15 | 361×804 | rect | light/dark | 480 | |
| Pocket 2 | 364×861 | rect | light/dark | 500 | \* |
| nova flip / flip S | 364×861 | rect | light/dark | 500 | |
| Enjoy 90 Pro Max | 377×817 | rect | light/dark | 540 | |
| Enjoy 90 Plus | 360×802 | rect | light/dark | 320 | |

## Foldable

| Model | Screen | Resolution (vp) | Screen Shape | Color Mode | DPI | Popular |
|-------|--------|-----------------|--------------|------------|-----|---------|
| Mate X5 | Inner | 712×799 | fold | light/dark | 500 | \* |
| Mate X5 | Outer | 346×801 | fold | light/dark | 500 | \* |
| Mate X6 | Inner | 717×781 | fold | light/dark | 500 | \* |
| Mate X6 | Outer | 346×781 | fold | light/dark | 500 | \* |
| Mate X7 | Inner | 707×773 | fold | light/dark | 500 | |
| Mate X7 | Outer | 346×782 | fold | light/dark | 500 | |
| Pura X | Inner | 440×707 | fold | light/dark | 480 | \* |
| Pura X | Outer | 327×327 | fold | light/dark | 480 | \* |
| Mate XT | Full | 1107×776 | fold | light/dark | 460 | |
| Mate XT | Dual | 712×776 | fold | light/dark | 460 | |
| Mate XT | Single | 351×776 | fold | light/dark | 460 | |

## DPI Tiers

| DPI | Tier | Target Devices |
|-----|------|---------------|
| 560 | Flagship | Mate 70/80 Pro, Pura 80/90, nova 14 Ultra/15 Pro |
| 540 | Upper-mid | Pura 70 Pro, Mate 80 Pro Max, nova 12/13/14 Pro |
| 520 | Mid | Mate 60/70 base, Mate 70 Air |
| 500 | Foldable | Mate X5/X6/X7, Pocket 2, nova flip |
| 480 | Standard | nova base, Pura X |
| 320 | Budget | Enjoy 90 Plus |

## Notes

| Topic | Detail |
|-------|--------|
| Phone cutout | All phones use pill-shaped cutout (dynamic island), not circular hole-punch |
| Foldable screens | Separate inner (unfolded) and outer (cover) dimensions |
| Previewer `rect` | Includes pill cutout, no separate `pill` option needed |
| Pura X outer screen | 980×980 square (327×327 vp), unique form factor |
| Design target width | Most HarmonyOS phone layouts target 360–376 vp width |
| Default Previewer profile | 360×780 vp (generic phone) |
