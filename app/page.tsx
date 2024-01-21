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
    <div
      key={project.href}
      className="flex aspect-[6/8] w-full flex-col gap-4 rounded-3xl border border-neutral-500/50 bg-neutral-500/25 p-6 transition duration-300 ease-in-out"
    >
      {/* Icon, title, and description  */}
      <div className="flex flex-col gap-2 text-left text-white">
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
            <Link
              href={project.externalLink.link}
              target="_blank"
              rel="noopener noreferrer"
              className="blur-view self-center !py-1 text-xs"
            >
              <div className="flex flex-row items-center space-x-1">
                <p>{project.externalLink.deployment}</p>
                <FiArrowUpRight className="text-[16px] text-neutral-300" />
              </div>
            </Link>
          ) : (
            <></>
          )}
        </div>
        <p className="text-sm font-normal">{project.description}</p>
      </div>

      {/* Case study link */}
      <Link
        href={project.href}
        className="flex flex-row items-center gap-1 self-start rounded-full bg-white px-3 py-1.5 text-xs text-neutral-900"
      >
        Learn More
        <FiChevronRight />
      </Link>

      {/* Tags */}
      <TagsComponent tags={project.tags} />
    </div>
  );
};
