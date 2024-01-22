import {
  Deployments,
  Platforms,
  Frameworks,
  Project,
  ScreenshotOrientation,
  ProjectMetadata,
} from '@/app/utils/allprojects';
import AnimeNowIcon from '@/public/animenow/logo.svg';

export default {
  title: 'Anime Now!',
  description: 'Track your favorite anime content!',
  logo: AnimeNowIcon,
  externalLink: {
    link: 'https://github.com/AnimeNow-Team/AnimeNow',
    deployment: Deployments.GitHub,
  },
  tags: [Platforms.iOS, Platforms.macOS, Frameworks.SwiftUI],
  colors: [
    {
      r: 56,
      g: 151,
      b: 204,
    },
    {
      r: 190,
      g: 26,
      b: 54,
    },
    // {
    //   r: 58,
    //   g: 58,
    //   b: 58,
    // },
    {
      r: 213,
      g: 180,
      b: 255,
    },
  ],
  screenshots: { images: [], orientation: ScreenshotOrientation.Portrait },
  released: new Date('20 Sep 2022'),
} as ProjectMetadata;
