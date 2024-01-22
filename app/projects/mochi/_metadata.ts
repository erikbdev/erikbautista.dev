import {
  Deployments,
  Platforms,
  Frameworks,
  Languages,
  ScreenshotOrientation,
  ProjectMetadata,
} from '@/app/utils/allprojects';
import MochiIcon from '@/public/mochi/logo.png';

export default {
  title: 'Mochi',
  description:
    'An open-source image, text, and video viewer for Apple devices.',
  logo: MochiIcon,
  externalLink: {
    link: 'https://github.com/Mochi-Team/mochi',
    deployment: Deployments.GitHub,
  },
  tags: [Platforms.iOS, Platforms.macOS, Frameworks.SwiftUI, Languages.JS],
  colors: [
    {
      r: 177,
      g: 219,
      b: 149,
    },
    // {
    //   r: 203,
    //   g: 231,
    //   b: 299,
    // },
    {
      r: 108,
      g: 161,
      b: 124,
    },
    {
      r: 204,
      g: 104,
      b: 136,
    },
    {
      r: 109,
      g: 179,
      b: 176,
    },
  ],
  screenshots: {
    images: [],
    orientation: ScreenshotOrientation.Portrait,
  },
  released: new Date('12 Aug 2023'),
} as ProjectMetadata;
