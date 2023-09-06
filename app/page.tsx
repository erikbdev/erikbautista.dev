import { FiArrowUpRight } from 'react-icons/fi';

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
  logo: URL | string | undefined,
  link: URL | undefined,
  deployment: Deployments,
  tags: (Languages | Frameworks | Platforms)[]
}

export default function Home() {
  return (
    <main>
      <section className={`full-height container grid sm:grid-cols-2 lg:grid-cols-3 md:items-center gap-4 md:gap-6`}>
        <ProjectCard project={{
          title: "Mochi",
          description: "An open-source image, text, video viewer.",
          logo: undefined,
          link: new URL("https://github.com/Mochi-Team/mochi"),
          deployment: Deployments.GitHub,
          tags: [Platforms.iOS, Frameworks.SwiftUI]
        }} />
        <ProjectCard project={{
          title: "Anime Now!",
          description: "Track your favorite anime content!",
          logo: undefined,
          link: new URL("https://github.com/AnimeNow-Team/AnimeNow"),
          deployment: Deployments.GitHub,
          tags: [Platforms.iOS, Frameworks.SwiftUI]
        }} />
        <ProjectCard project={{
          title: "Safer Together",
          description: "Building a safer world one step at a time.",
          logo: undefined,
          link: undefined,
          deployment: Deployments.BitBucket,
          tags: [Platforms.iOS, Frameworks.UIKit]
        }} />
      </section>
    </main>
  )
}

const ProjectCard = ({ project }: { project: Project }) => {
  return (
    <button key={project.title} className="aspect-[6/8] p-6 flex flex-col rounded-3xl transition ease-in-out duration-300 bg-neutral-500/40 border border-white/10">
      <a href={project.link?.href} className='blur-view !py-1 items-center self-end cursor-pointer flex flex-row text-xs space-x-1'>
        <p>{project.deployment}</p>
        <FiArrowUpRight className="text-[16px] text-neutral-300" />
      </a>

      {/* <div className='m-auto text-center items-center'>
        <div className='bg-red-50/10 w-44 h-44 mx-auto mb-4'></div>
        <p className="text-3xl font-semibold">{project.title}</p>
        <p className="text-md font-normal">{project.description}</p>
      </div> */}

      <div className='mt-auto text-white text-left'>
        <div className='flex flex-row pb-1 gap-2 '>
          {project.tags.map(tag => <p key={tag} className='blur-view text-sm font-normal'>{tag}</p>)}
        </div>
        <p className="text-lg font-semibold">{project.title}</p>
        <p className="text-sm font-normal">{project.description}</p>
      </div>
    </button>
  )
}