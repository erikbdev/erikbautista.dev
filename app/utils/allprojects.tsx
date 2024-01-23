import { access, constants, readFile, readdir } from 'fs/promises';
import { StaticImageData } from 'next/image';
import path from 'path';
import { RGB } from '../components/gradientanimation';

export enum Deployments {
  GitHub = 'GitHub',
  TestFlight = 'TestFlight',
  BitBucket = 'Bitbucket',
  Projects = 'Projects',
  Website = 'Website'
}

export enum Languages {
  Swift = 'Swift',
  HTML = 'HTML',
  JS = 'JavaScript',
  Rust = 'Rust',
  WebAssembly = 'Web Assembly',
}

export enum Frameworks {
  SwiftUI = 'SwiftUI',
  UIKit = 'UIKit',
  AppKit = 'AppKit',
  NextJS = 'NextJS',
}

export enum Platforms {
  iOS = 'iOS',
  macOS = 'macOS',
  Mobile = 'Mobile',
  Desktop = 'Desktop',
}

export type ScreenshotImage = {
  image: StaticImageData;
  alt: string;
};

export enum ScreenshotOrientation {
  Portrait,
  Landscape,
}

export type ProjectScreenshots = {
  images: ScreenshotImage[];
  orientation: ScreenshotOrientation;
};

export type ExternalLink = {
  link: string;
  deployment: Deployments;
};

export type Project = {
  title: string;
  shortDescription: string;
  description?: string;
  logo: string | StaticImageData | undefined;
  externalLink?: ExternalLink;
  href: string;
  tags: (Languages | Frameworks | Platforms)[];
  colors: RGB[];
  screenshots: ProjectScreenshots;
  released: Date;
};

export type ProjectMetadata = Omit<Project, 'href'>;

export async function allProjects(): Promise<Project[]> {
  const projectsPath = path.join(process.cwd(), 'app/projects');

  const projectsDir = await readdir(projectsPath);
  const projects: Project[] = [];

  for (const folder of projectsDir) {
    try {
      const manifest: Project = await import(
        `@/app/projects/${folder}/_metadata`
      ).then((v) => v.default);
      manifest.href = `/projects/${folder}`;
      projects.push(manifest);
    } catch (e) {
      continue;
    }
  }

  return projects.sort((a, b) => b.released.getTime() - a.released.getTime());
}
