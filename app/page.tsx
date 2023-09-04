import Image from 'next/image'
import { type } from 'os';
import { FiGithub, FiMail, FiExternalLink } from 'react-icons/fi';

const projectButtons: Project[] = [
  {
    title: "Mochi",
    description: "iOS App",
    image: "",
    link: "https://github.com/Mochi-Team/mochi"
  },
  {
    title: "Anime Now!",
    description: "iOS App",
    image: "",
    link: "https://github.com/AnimeNow-Team/AnimeNow"
  },
  {
    title: "Safer Together",
    description: "iOS App",
    image: "",
    link: undefined
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
      <a href={project.link} className='w-fit ml-auto cursor-pointer inline-flex items-center gap-1 rounded-full bg-neutral-500 p-1.5 px-3 text-xs'>Open <FiExternalLink className="text-lg" /></a>

      <div className='mt-auto flex flex-row items-center space-x-4'>
        {/* <Image
            className='row-start-1'
            src={project.image}
            width={64}
            height={64}
            alt='Picture of '
          /> */}
        <div className='flex-auto text-white text-left'>
          <p className="text-lg font-semibold">{project.title}</p>
          <p className="text-sm font-normal">{project.description}</p>
        </div>
      </div>
    </div>
  )
}

interface Project {
  title: string,
  description: string,
  image: string,
  link: string | undefined
}

// interface Deployments {
//   GitLab = "",
//   GitHub = ""
// }

// type Deployed = string | 