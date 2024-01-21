import {
  Deployments,
  Platforms,
  Frameworks,
  ScreenshotOrientation,
  ProjectMetadata,
} from '@/app/utils/allprojects';
import IdleKeysScreen from '@/public/prismui/prismui-idle-keys.png';
import StaticKeysScreen from '@/public/prismui/prismui-static-effect.png';
import WaveEffectScreen from '@/public/prismui/prismui-wave-effect.png';

export default {
  title: 'PrismUI',
  description: 'Take control of your MSI RGB keyboard on macOS.',
  logo: undefined,
  tags: [Platforms.macOS, Frameworks.AppKit, Frameworks.SwiftUI],
  colors: [],
  screenshots: {
    images: [
      {
        image: IdleKeysScreen,
        alt: 'prismui idle keys screen',
      },
      {
        image: StaticKeysScreen,
        alt: 'prismui static effect screen',
      },
      {
        image: WaveEffectScreen,
        alt: 'prismui wave effect screen',
      },
    ],
    orientation: ScreenshotOrientation.Landscape,
  },
} as ProjectMetadata;
