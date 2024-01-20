import { CaseStudy, ImageOrientation } from "@/app/components/casestudy";
import IdleKeysScreen from "@/public/prismui/prismui-idle-keys.png";
import StaticKeysScreen from "@/public/prismui/prismui-static-effect.png";
import WaveEffectScreen from "@/public/prismui/prismui-wave-effect.png";

export default async function Page() {
  return <CaseStudy 
    projectName="PrismUI" 
    projectDescription="" 
    images={[
      {
        image: IdleKeysScreen,
        alt: "prismui idle keys screen"
      },
      {
        image: StaticKeysScreen,
        alt: "prismui static effect screen"
      },
      {
        image: WaveEffectScreen,
        alt: "prismui wave effect screen"
      }
    ]}
    orientation={ImageOrientation.Landscape}
  />;
}
