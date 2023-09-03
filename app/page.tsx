const socialMedia: Social[] = [];

const projectButtons: Project[] = [
  {
    title: "Mochi",
    description: "iOS Mobile Application",
    link: undefined
  },
  {
    title: "Anime Now!",
    description: "",
    link: undefined
  },
  {
    title: "Safer Together",
    description: "",
    link: undefined
  }
];

export default function Home() {
  return (
    <main className="h-screen w-full flex flex-col">
      {/* Name & Title */}
      <div className="container max-w-6xl mx-auto p-8">
        <p className='font-semibold text-3xl'>Erik Bautista Santibanez</p>
        <p className='text-lg text-gray-300'>iOS Developer & Software Engineer</p>
        {/* TODO: Add buttons to find me */}
        <div>
          {socialMedia.map(SocialButton)}
        </div>
      </div>

      {/* Cards */}
      <ul className="h-full w-full overflow-x-auto flex flex-nowrap items-center gap-6 snap-x snap-mandatory scroll-px-8">
        {projectButtons.map(element => <li className="h-full max-h-[32rem] min-h-32 flex-none snap-start first:ps-8 last:pe-8">{ProjectCard(element)}</li>)}
      </ul>

      {/* Footer */}
      <div className="container max-w-6xl mx-auto self-center md:self-start p-8">
        <p className="text-sm text-neutral-400">© 2023 Erik Bautista Santibanez. All rights reserved.</p>
      </div>
    </main>
  )
}

const SocialButton = (social: Social) => {
  return (<div></div>)
}

const ProjectCard = (project: Project) => {
  return (
    <button className="h-full aspect-[2/3] rounded-lg transition ease-in-out duration-300 bg-neutral-500/40 hover:bg-green-500">
      <div className="p-6 text-white text-left h-full">
        <p className="text-lg font-semibold">{project.title}</p>
        <p className="text-sm font-normal">{project.description}</p>
      </div>
    </button>
  )
}

interface Social {
  name: string,
  image: string,
  link: string
}

interface Project {
  title: string,
  description: string,
  link: string | undefined
}