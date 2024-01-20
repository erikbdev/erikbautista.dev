import Image from "next/image";
import { FiArrowUpRight, FiGithub, FiMail } from "react-icons/fi";
import { StaticImport } from "next/dist/shared/lib/get-img-props";
import Reveal from "./components/reveal";
import { getUserInfo } from "./utils/userinfo";

import MochiIcon from "@/public/mochi/logo.png";
import AnimeNowIcon from "@/public/animenow/logo.svg";
import Link from "next/link";

enum Deployments {
  GitHub = "GitHub",
  TestFlight = "TestFlight",
  BitBucket = "Bitbucket",
  Projects = "Projects",
}

enum Languages {
  Swift = "Swift",
  HTML = "HTML",
  JS = "JavaScript",
  Rust = "Rust",
  WebAssembly = "Web Assembly",
}

enum Frameworks {
  SwiftUI = "SwiftUI",
  UIKit = "UIKit",
  AppKit = "AppKit",
  NextJS = "NextJS",
}

enum Platforms {
  iOS = "iOS",
  macOS = "macOS",
  Mobile = "Mobile",
  Desktop = "Desktop",
}

type Project = {
  title: string;
  description: string;
  logo: string | StaticImport | undefined;
  link: string;
  deployment: Deployments;
  tags: (Languages | Frameworks | Platforms)[];
  colors: string[];
};

const projects: Project[] = [
  {
    title: "Mochi",
    description: "An open-source image, text, video viewer.",
    logo: MochiIcon,
    link: "https://github.com/Mochi-Team/mochi",
    deployment: Deployments.GitHub,
    tags: [Platforms.iOS, Platforms.macOS, Frameworks.SwiftUI, Languages.JS],
    colors: [],
  },
  {
    title: "Anime Now!",
    description: "Track your favorite anime content!",
    logo: AnimeNowIcon,
    link: "https://github.com/AnimeNow-Team/AnimeNow",
    deployment: Deployments.GitHub,
    tags: [Platforms.iOS, Platforms.macOS, Frameworks.SwiftUI],
    colors: [],
  },
  {
    title: "Safer Together",
    description: "Building a safer world one step at a time.",
    logo: undefined,
    link: "projects/safer-together",
    deployment: Deployments.Projects,
    tags: [Platforms.iOS, Frameworks.UIKit],
    colors: [],
  },
  {
    title: "PrismUI",
    description: "Take control of your MSI RGB keyboard on macOS.",
    logo: undefined,
    link: "projects/prismui",
    deployment: Deployments.Projects,
    tags: [Platforms.macOS, Frameworks.AppKit, Frameworks.SwiftUI],
    colors: [],
  },
];

export default async function Home() {
  const info = await getUserInfo();

  return (
    <div className="flex flex-col gap-8">
      <div className="on-reveal-blur flex-initial">
        <div className="flex flex-row space-x-2">
          <p className="font-semibold text-2xl">{info.name}</p>
        </div>
        <p className="text-md text-neutral-400 pb-4">
          iOS Developer & Software Engineer
        </p>
        <div className="flex flex-row text-neutral-200 space-x-2 text-2xl">
          <a href={`mailto:${info.email}`}>
            <FiMail />
          </a>
          <a href="https://github.com/ErrorErrorError">
            <FiGithub />
          </a>
        </div>
      </div>
      <section className={`h-full`}>
        <div className="grid sm:grid-cols-2 gap-4">
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
    <Link
      href={project.link}
      // target="_blank"
      // rel="noopener noreferrer"
      key={project.title}
      className="w-full transition ease-in-out duration-300 aspect-[6/8] p-6 flex flex-col rounded-3xl bg-neutral-500/25 border border-neutral-500/50"
    >
      <div className="blur-view !py-1 items-center self-end cursor-pointer flex flex-row text-xs space-x-1">
        <p>{project.deployment}</p>
        <FiArrowUpRight className="text-[16px] text-neutral-300" />
      </div>

      {project.logo ? (
        <Image
          className="my-auto w-[50%] self-center"
          src={project.logo}
          alt={`Logo of ${project.title}`}
        />
      ) : (
        <div className="my-auto"></div>
      )}

      <div className="text-white text-left">
        <p className="text-lg font-semibold">{project.title}</p>
        <p className="text-sm font-normal">{project.description}</p>
        <div className="flex flex-row flex-wrap pt-2 gap-1  text-xs">
          {project.tags.map((tag) => (
            <p key={tag} className="w-fit blur-view font-normal">
              {tag}
            </p>
          ))}
        </div>
      </div>
    </Link>
  );
};
