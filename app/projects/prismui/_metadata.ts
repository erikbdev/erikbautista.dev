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
  colors: [
    {
      r: 255,
      g: 100,
      b: 0,
    },
    {
      r: 200,
      g: 250,
      b: 0,
    },
    {
      r: 0,
      g: 226,
      b: 255,
    },
  ],
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
  released: new Date('08 Jul 2021'),
} as ProjectMetadata;
