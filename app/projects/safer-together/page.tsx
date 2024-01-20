import STDashboard from "@/public/safertogether/st-dashboard.png";
import STRegistration from "@/public/safertogether/st-registration.png";
import STCreateReport from "@/public/safertogether/st-create-report.png";
import STReports from "@/public/safertogether/st-reports.png";
import STInfectionType from "@/public/safertogether/st-infection-type.png";

import { CaseStudy, ImageOrientation } from "@/app/components/casestudy";

export default async function Page() {
  return (
    <CaseStudy
      projectName="Safer Together"
      projectDescription="Safer Together is a mobile application aimed to combat COVID-19, and
  any future exposures."
      images={[
        {
          image: STRegistration,
          alt: "safer together registration",
        },
        {
          image: STDashboard,
          alt: "safer together dashboard",
        },
        {
          image: STReports,
          alt: "safer together reports",
        },
        {
          image: STCreateReport,
          alt: "safer together create report",
        },
        {
          image: STInfectionType,
          alt: "safer together report infection type",
        },
      ]}
      orientation={ImageOrientation.Portrait}
    />
  );
}
