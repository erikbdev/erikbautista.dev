const socialMedia: Social[] = [];

const projectButtons: Project[] = [
  {
    title: "Title 1",
    description: "Some Description"
  },
  {
    title: "Title 2",
    description: "Some Description"
  },
];

export default function Home() {
  return (
    <div className="h-screen container max-w-6xl mx-auto p-8 grid space-y-8">
      <div className='row-span-6 md:grid md:grid-cols-2 md:gap-8 h-full content-center'>
        <div className="pb-8 self-center">
          {/* Name & Title */}
          <div>
            <p className='font-semibold text-3xl'>Erik Bautista Santibanez</p>
            <p className='my-2 text-lg text-gray-300'>iOS Developer & Software Engineer</p>
          </div>
          {/* TODO: Add buttons to find me */}
          <div>
            {socialMedia.map(SocialButton)}
          </div>
        </div>
        <div className='self-center w-fill'>
          <div className='flex flex-col space-y-4'>
            {projectButtons.map(ProjectButton)}
          </div>
        </div>
      </div>

      {/* Footer */}
      <div className="mx-auto md:mx-0 self-end">
        <p className="text-sm text-neutral-400">© 2023 Erik Bautista Santibanez. All rights reserved.</p>
      </div>
    </div>
  )
}

const SocialButton = (social: Social) => {
  return (<div></div>)
}

const ProjectButton = (project: Project) => {
  return (
    <button className="bg-neutral-500/40 rounded-lg h-24">
      <div className="px-6 text-white text-left">
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
  description: string
}