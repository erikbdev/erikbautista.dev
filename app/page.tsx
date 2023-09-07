import Image from 'next/image'
import { FiArrowUpRight } from 'react-icons/fi';
import { Conditional } from './utils/contitional';
import { StaticImport } from 'next/dist/shared/lib/get-img-props';

import MochiIcon from "../public/Mochi/logo.svg";
import AnimeNowIcon from "../public/AnimeNow/logo.svg"
import Reveal from './components/reveal';

enum Deployments {
  GitHub = "GitHub",
  TestFlight = "TestFlight",
  BitBucket = "Bitbucket"
}

enum Languages {
  Swift = "Swift",
  HTML = "HTML",
  JS = "JavaScript",
  Rust = "Rust"
}

enum Frameworks {
  SwiftUI = "SwiftUI",
  UIKit = "UIKit",
  NextJS = "NextJS"
}

enum Platforms {
  iOS = "iOS",
  macOS = "macOS",
  Mobile = "Mobile",
  Desktop = "Desktop"
}

interface Project {
  title: string,
  description: string,
  logo: string | StaticImport,
  link: URL | undefined,
  deployment: Deployments,
  tags: (Languages | Frameworks | Platforms)[]
}

export default function Home() {
  return (
    <section className={`h-full px-8`}>
      <div className='grid sm:grid-cols-2 gap-4 screen-container'>
        <Reveal>
          <ProjectCard project={{
            title: "Mochi",
            description: "An open-source image, text, video viewer.",
            logo: MochiIcon,
            link: new URL("https://github.com/Mochi-Team/mochi"),
            deployment: Deployments.GitHub,
            tags: [Platforms.iOS, Frameworks.SwiftUI]
          }} />
        </Reveal>
        <Reveal>
          <ProjectCard project={{
            title: "Anime Now!",
            description: "Track your favorite anime content!",
            logo: AnimeNowIcon,
            link: new URL("https://github.com/AnimeNow-Team/AnimeNow"),
            deployment: Deployments.GitHub,
            tags: [Platforms.iOS, Frameworks.SwiftUI]
          }} />
        </Reveal>
        <Reveal>
          <ProjectCard project={{
            title: "Safer Together",
            description: "Building a safer world one step at a time.",
            logo: "",
            link: undefined,
            deployment: Deployments.BitBucket,
            tags: [Platforms.iOS, Frameworks.UIKit]
          }} />
        </Reveal>
      </div>
    </section>
  )
}

const ProjectCard = ({ project }: { project: Project }) => {
  return (
    <a href={project.link?.href} target="_blank" rel="noopener noreferrer" key={project.title} className="w-full transition ease-in-out duration-300 aspect-[6/8] p-6 flex flex-col rounded-3xl bg-neutral-500/40 border border-white/10">
      <div className='blur-view !py-1 items-center self-end cursor-pointer flex flex-row text-xs space-x-1'>
        <p>{project.deployment}</p>
        <FiArrowUpRight className="text-[16px] text-neutral-300" />
      </div>

      <Image
        className='my-auto w-[50%] self-center'
        src={project.logo}
        alt={`Logo of ${project.title}`}
      />

      <div className='text-white text-left'>
        <div className='flex flex-row pb-1 gap-2 '>
          {project.tags.map(tag => <p key={tag} className='blur-view text-sm font-normal'>{tag}</p>)}
        </div>
        <p className="text-lg font-semibold">{project.title}</p>
        <p className="text-sm font-normal">{project.description}</p>
      </div>
    </a>
  )
}