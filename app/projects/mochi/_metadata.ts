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
  description: 'An open-source image, text, video viewer.',
  logo: MochiIcon,
  externalLink: {
    link: 'https://github.com/Mochi-Team/mochi',
    deployment: Deployments.GitHub,
  },
  tags: [Platforms.iOS, Platforms.macOS, Frameworks.SwiftUI, Languages.JS],
  colors: [],
  screenshots: { images: [], orientation: ScreenshotOrientation.Portrait },
} as ProjectMetadata;
