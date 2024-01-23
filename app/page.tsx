import Image from 'next/image';
import {
  FiArrowUpRight,
  FiChevronRight,
  FiGithub,
  FiMail,
} from 'react-icons/fi';
import Reveal from './components/reveal';
import { getUserInfo } from './utils/userinfo';

import Link from 'next/link';
import { Project, allProjects } from './utils/allprojects';
import { TagsComponent } from './components/taglist';
import { BGGradientAnimation } from './components/gradientanimation';
import { ExternalLinkButton } from './components/externalmaterialbutton';

export default async function Home() {
  const info = await getUserInfo();
  const projects = await allProjects();

  return (
    <div className="flex flex-col gap-8">
      <div className="on-reveal-blur flex-initial">
        <div className="flex flex-row space-x-2">
          <p className="text-2xl font-semibold">{info.name}</p>
        </div>
        <p className="text-md pb-4 text-neutral-400">
          iOS Developer & Software Engineer
        </p>
        <div className="flex flex-row space-x-2 text-2xl text-neutral-200">
          <a href={`mailto:${info.email}`}>
            <FiMail />
          </a>
          <a href="https://github.com/ErrorErrorError">
            <FiGithub />
          </a>
        </div>
      </div>
      <section className={`h-full`}>
        <div className="grid gap-4 sm:grid-cols-2">
          {projects.map((project) => (
            <Reveal key={project.title}>
              <ProjectCard project={project} />
            </Reveal>
          ))}
        </div>
      </section>
    </div>
  );
}

const ProjectCard = ({ project }: { project: Project }) => {
  return (
    <BGGradientAnimation
      key={project.href}
      colors={project.colors}
      className="aspect-[6/8] h-full w-full"
      canvasClassName="z-0 bg-neutral-500/25 rounded-3xl border border-neutral-500/50"
    >
      <div className="flex h-full w-full flex-col gap-4 p-6">
        {/* Icon, title, and description  */}
        <div className="z-10 flex flex-col gap-2 text-left text-white">
          <div className="flex flex-row gap-2">
            {project.logo ? (
              <Image
                className="self-center"
                src={project.logo}
                alt={`Logo of ${project.title}`}
                width={38}
                height={38}
              />
            ) : (
              <></>
            )}
            <p className="flex-grow self-center text-lg font-semibold">
              {project.title}
            </p>

            {project.externalLink ? (
              <ExternalLinkButton externalLink={project.externalLink} />
            ) : (
              <></>
            )}
          </div>
          <p className="text-sm font-normal">{project.shortDescription}</p>
        </div>

        {/* Case study link */}
        <Link
          href={project.href}
          className="z-10 flex flex-row items-center gap-1 self-start rounded-full border border-neutral-400/50 bg-white px-3 py-1.5 text-xs text-neutral-900"
        >
          Learn More
          <FiChevronRight />
        </Link>

        {/* Tags */}
        <TagsComponent tags={project.tags} />
      </div>
    </BGGradientAnimation>
  );
};
