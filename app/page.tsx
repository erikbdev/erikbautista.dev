import Image from 'next/image'
import { FiArrowUpRight, FiGithub, FiMail } from 'react-icons/fi';
import { Conditional } from './utils/contitional';
import { StaticImport } from 'next/dist/shared/lib/get-img-props';

import MochiIcon from "../public/Mochi/logo.png";
import AnimeNowIcon from "../public/AnimeNow/logo.svg"
import Reveal from './components/reveal';
import { Fragment } from 'react';
import { getUserInfo } from './utils/userinfo';

enum Deployments {
  GitHub = "GitHub",
  TestFlight = "TestFlight",
  BitBucket = "Bitbucket"
}

enum Languages {
  Swift = "Swift",
  HTML = "HTML",
  JS = "JavaScript",
  Rust = "Rust",
  WebAssembly = "Web Assembly"
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

const projects: Project[] = [
  {
    title: "Mochi",
    description: "An open-source image, text, video viewer.",
    logo: MochiIcon,
    link: new URL("https://github.com/Mochi-Team/mochi"),
    deployment: Deployments.GitHub,
    tags: [Platforms.iOS, Frameworks.SwiftUI, Languages.JS]
  },
  {
    title: "Anime Now!",
    description: "Track your favorite anime content!",
    logo: AnimeNowIcon,
    link: new URL("https://github.com/AnimeNow-Team/AnimeNow"),
    deployment: Deployments.GitHub,
    tags: [Platforms.iOS, Frameworks.SwiftUI]
  },
  {
    title: "Safer Together",
    description: "Building a safer world one step at a time.",
    logo: "",
    link: undefined,
    deployment: Deployments.BitBucket,
    tags: [Platforms.iOS, Frameworks.UIKit]
  }
]

export default async function Home() {
  const info = await getUserInfo();

  return (
    <div className='flex flex-col gap-8'>
      <div className="on-reveal-blur flex-initial">
        <p className='font-semibold text-2xl'>{info.name}</p>
        <p className='text-md text-neutral-400 pb-4'>iOS Developer & Software Engineer</p>
        <div className='flex flex-row text-neutral-200 space-x-2 text-2xl'>
          <a href={`mailto:${info.email}`}><FiMail /></a>
          <a href='https://github.com/ErrorErrorError'><FiGithub /></a>
        </div>
      </div>
      <section className={`h-full`}>
        {/* <h1 className='text-2xl font-semibold pb-3'>Projects</h1> */}
        <div className='grid sm:grid-cols-2 gap-4'>
          {
            projects.map(project =>
              <Reveal key={project.title}>
                <ProjectCard project={project} />
              </Reveal>
            )
          }
        </div>
      </section>
    </div>
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
        <p className="text-lg font-semibold">{project.title}</p>
        <p className="text-sm font-normal">{project.description}</p>
        <div className='flex flex-row flex-wrap pt-2 gap-1 '>
          {project.tags.map(tag => <p key={tag} className='w-fit blur-view text-sm font-normal'>{tag}</p>)}
        </div>
      </div>
    </a>
  )
}