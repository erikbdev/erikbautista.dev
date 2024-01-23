import {
  Deployments,
  Platforms,
  Frameworks,
  Project,
  ScreenshotOrientation,
  ProjectMetadata,
} from '@/app/utils/allprojects';
import AnimeNowIcon from '@/public/animenow/logo.svg';
import ANDiscover from '@/public/animenow/an-discover.png';
import ANSearch from '@/public/animenow/an-search.png';
import ANDetails from '@/public/animenow/an-details.png';
import ANCollections from '@/public/animenow/an-collections.png';
import ANDownloads from '@/public/animenow/an-downloads.png';
import ANSettings from '@/public/animenow/an-settings.png';

export default {
  title: 'Anime Now!',
  shortDescription: 'Track your favorite anime content!',
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
    {
      r: 213,
      g: 180,
      b: 255,
    },
  ],
  screenshots: { 
    images: [
      {
        image: ANDiscover,
        alt: "anime now discover"
      },
      {
        image: ANDetails,
        alt: "anime now details"
      },
      {
        image: ANSearch,
        alt: "anime now search"
      },
      {
        image: ANDownloads,
        alt: "anime now downloads"
      },
      {
        image: ANCollections,
        alt: "anime now collections"
      },
      {
        image: ANSettings,
        alt: "anime now settings"
      },
    ], 
    orientation: ScreenshotOrientation.Portrait 
  },
  released: new Date('20 Sep 2022'),
} as ProjectMetadata;
