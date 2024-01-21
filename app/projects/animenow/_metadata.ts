import { Deployments, Platforms, Frameworks, Project, ScreenshotOrientation, ProjectMetadata } from "@/app/utils/allprojects";
import AnimeNowIcon from '@/public/animenow/logo.svg';

export default  {
  title: 'Anime Now!',
  description: 'Track your favorite anime content!',
  logo: AnimeNowIcon,
  externalLink: {
    link: 'https://github.com/AnimeNow-Team/AnimeNow',
    deployment: Deployments.GitHub,
  },
  tags: [Platforms.iOS, Platforms.macOS, Frameworks.SwiftUI],
  colors: [],
  screenshots: { images: [], orientation: ScreenshotOrientation.Portrait }
} as ProjectMetadata;