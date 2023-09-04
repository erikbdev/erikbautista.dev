import Image from 'next/image'
import { type } from 'os';
import { FiGithub, FiMail, FiExternalLink } from 'react-icons/fi';
import { Conditional } from './utils/contitional';

enum Deployments {
  GitHub = "GitHub",
  TestFlight = "TestFlight",
  BitBucket = "Bitbucket"
}

enum Frameworks {
  iOS = "iOS",
  Swift = "Swift",
  NextJS = "NextJS"
}

namespace Frameworks {
  function color(framework: Frameworks) {
    switch (framework) {
      case Frameworks.iOS:
        break
      case Frameworks.Swift:
        break
      case Frameworks.NextJS:
        break
    }
  }
}

interface Tag {
  name: string,
  color: string
}

interface Project {
  title: string,
  description: string,
  image: string | undefined,
  link: string | undefined,
  deployment: Deployments,
  tags: Frameworks[]
}

const projectButtons: Project[] = [
  {
    title: "Mochi",
    description: "All-in-one multi media app!",
    image: undefined,
    link: "https://github.com/Mochi-Team/mochi",
    deployment: Deployments.GitHub,
    tags: [Frameworks.iOS]
  },
  {
    title: "Anime Now!",
    description: "",
    image: undefined,
    link: "https://github.com/AnimeNow-Team/AnimeNow",
    deployment: Deployments.GitHub,
    tags: [Frameworks.iOS]
  },
  {
    title: "Safer Together",
    description: "",
    image: undefined,
    link: undefined,
    deployment: Deployments.BitBucket,
    tags: [Frameworks.iOS]
  }
];

export default function Home() {
  return (
    <main className="h-[calc(100dvh)] w-full flex flex-col">
      {/* Name & Title */}
      <div className="p-8 flex-none">
        <p className='font-semibold text-2xl'>Erik Bautista Santibanez</p>
        <p className='text-md text-neutral-400 pb-4'>iOS Developer & Software Engineer</p>
        <div className='flex flex-row text-neutral-200 space-x-3 text-2xl'>
          <a href='mailto:erikbautista15@gmail.com'><FiMail /></a>
          <a href='https://github.com/ErrorErrorError'><FiGithub /></a>
        </div>
      </div>

      {/* Cards */}
      <ul className="h-full w-full flex-auto overflow-y-hidden overflow-x-auto flex flex-nowrap items-center gap-4 md:gap-6 snap-x snap-mandatory scroll-px-8 scrollbar-padding">
        {projectButtons.map(element => <li key={element.title} className="h-full flex-none snap-start first:ps-8 last:pe-8">{ProjectCard(element)}</li>)}
      </ul>

      {/* Footer */}
      <div className="self-center md:self-start p-8">
        <p className="text-xs text-neutral-400">© 2023 Erik Bautista Santibanez. All rights reserved.</p>
      </div>
    </main>
  )
}

const ProjectCard = (project: Project) => {
  return (
    <div className="h-full p-6 aspect-[5/8] flex flex-col rounded-3xl transition ease-in-out duration-300 bg-neutral-500/40 hover:bg-green-500">
        <a href={project.link} className='blur-view !py-1 items-center self-end cursor-pointer flex flex-row text-xs space-x-1'>
          <p className=''>{project.deployment}</p> 
          <FiExternalLink className="text-[16px]" />
        </a>

      <Conditional showWhen={project.image !== undefined}>
        <Image
          className='mt-auto'
          src={project.image!}
          width={64}
          height={64}
          alt={`Logo of ${project.title}`}
        />
      </Conditional>
      <div className={`${project.image === undefined ? 'mt-auto' : ''} flex flex-row items-center space-x-4`}>
        <div className='flex-auto text-white text-left'>
          <div className='flex flex-row pb-1'>
            {project.tags.map(tag => {
              return <p className='blur-view text-sm font-normal'>{tag}</p>
            })}
          </div>
          <p className="text-lg font-semibold">{project.title}</p>
          <p className="text-sm font-normal">{project.description}</p>
        </div>
      </div>
    </div>
  )
}