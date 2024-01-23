import {
  Deployments,
  Platforms,
  Frameworks,
  ProjectMetadata,
  ScreenshotOrientation,
} from '@/app/utils/allprojects';
import STDashboard from '@/public/safertogether/st-dashboard.png';
import STRegistration from '@/public/safertogether/st-registration.png';
import STCreateReport from '@/public/safertogether/st-create-report.png';
import STReports from '@/public/safertogether/st-reports.png';
import STInfectionType from '@/public/safertogether/st-infection-type.png';

export default {
  title: 'Safer Together',
  shortDescription: 'Building a safer world one step at a time.',
  logo: undefined,
  tags: [Platforms.iOS, Frameworks.UIKit],
  colors: [
    {
      r: 0,
      g: 120,
      b: 200,
    },
    {
      r: 0,
      g: 255,
      b: 200,
    },
  ],
  screenshots: {
    images: [
      {
        image: STRegistration,
        alt: 'safer together registration',
      },
      {
        image: STDashboard,
        alt: 'safer together dashboard',
      },
      {
        image: STReports,
        alt: 'safer together reports',
      },
      {
        image: STCreateReport,
        alt: 'safer together create report',
      },
      {
        image: STInfectionType,
        alt: 'safer together report infection type',
      },
    ],
    orientation: ScreenshotOrientation.Portrait,
  },
  released: new Date('25 Oct 2021'),
} as ProjectMetadata;
